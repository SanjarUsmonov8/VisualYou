import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:visualyou/features/auth/email_auth.dart';

void main() {
  test(
    'password reset uses the start, verify, and complete endpoints',
    () async {
      var requestNumber = 0;
      final client = MockClient((request) async {
        requestNumber += 1;
        expect(request.method, 'POST');
        final body = jsonDecode(request.body) as Map<String, dynamic>;

        switch (requestNumber) {
          case 1:
            expect(
              request.url.path,
              '/api/v1/auth/email/password-reset/start/',
            );
            expect(body, {'email': 'person@example.com'});
            return http.Response(
              jsonEncode({
                'challenge_id': 'challenge-1',
                'expires_in_seconds': 600,
              }),
              202,
            );
          case 2:
            expect(
              request.url.path,
              '/api/v1/auth/email/password-reset/verify/',
            );
            expect(body, {'challenge_id': 'challenge-1', 'code': '123456'});
            return http.Response(
              jsonEncode({'setup_token': 'one-use-token'}),
              200,
            );
          case 3:
            expect(
              request.url.path,
              '/api/v1/auth/email/password-reset/complete/',
            );
            expect(body, {
              'challenge_id': 'challenge-1',
              'setup_token': 'one-use-token',
              'password': 'New-test-password-4096!',
            });
            return http.Response(
              jsonEncode({'detail': 'Password changed.'}),
              200,
            );
          default:
            fail('Unexpected request $requestNumber');
        }
      });
      final api = EmailAuthApi(
        client: client,
        baseUrl: 'https://example.com/api/v1',
      );

      final challenge = await api.startPasswordReset('person@example.com');
      expect(challenge.id, 'challenge-1');
      expect(challenge.expiresInSeconds, 600);

      final setupToken = await api.verifyPasswordResetCode(
        challengeId: challenge.id,
        code: '123456',
      );
      expect(setupToken, 'one-use-token');

      await api.completePasswordReset(
        challengeId: challenge.id,
        setupToken: setupToken,
        password: 'New-test-password-4096!',
      );
      expect(requestNumber, 3);
      api.close();
    },
  );
}
