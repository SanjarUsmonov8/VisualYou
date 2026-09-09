import 'package:flutter/material.dart';
import 'package:visualyou/features/device_transfer/device_transfer_backup.dart';
import 'package:visualyou/l10n/app_strings.dart';

class DeviceTransferHomeBanner extends StatelessWidget {
  const DeviceTransferHomeBanner({required this.controller, super.key});

  final DeviceTransferBackupController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        if (controller.stage == DeviceTransferStage.idle ||
            controller.stage == DeviceTransferStage.checking) {
          return const SizedBox.shrink();
        }
        final colors = Theme.of(context).colorScheme;
        final restoring = controller.stage == DeviceTransferStage.restoreAvailable;
        final title = switch (controller.stage) {
          DeviceTransferStage.exporting => context.tr('Preparing your backup'),
          DeviceTransferStage.uploading => context.tr('Uploading your backup'),
          DeviceTransferStage.ready => context.tr('Backup ready for device transfer'),
          DeviceTransferStage.restoreAvailable => context.tr('Get your data on this device'),
          DeviceTransferStage.downloading => context.tr('Downloading your data'),
          DeviceTransferStage.restoring => context.tr('Restoring your data'),
          DeviceTransferStage.restored => context.tr('Your data is restored'),
          DeviceTransferStage.error => context.tr('Backup needs attention'),
          _ => '',
        };
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Material(
            color: colors.primaryContainer.withValues(alpha: .75),
            borderRadius: BorderRadius.circular(24),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: restoring ? () => _confirmRestore(context) : null,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          restoring
                              ? Icons.phone_android_rounded
                              : Icons.cloud_upload_rounded,
                          color: colors.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                        if (restoring)
                          FilledButton(
                            onPressed: () => _confirmRestore(context),
                            child: Text(context.tr('Restore')),
                          ),
                      ],
                    ),
                    if (controller.isBusy) ...[
                      const SizedBox(height: 12),
                      LinearProgressIndicator(value: controller.progress),
                      if (controller.progress != null) ...[
                        const SizedBox(height: 5),
                        Text('${(controller.progress! * 100).round()}%'),
                      ],
                    ] else if (controller.stage == DeviceTransferStage.ready &&
                        controller.expiresAt != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        '${context.tr('Available until')} ${_date(controller.expiresAt!)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ] else if (controller.stage == DeviceTransferStage.error) ...[
                      const SizedBox(height: 6),
                      Text(
                        context.tr(controller.errorMessage ?? 'Try again from Settings.'),
                        style: TextStyle(color: colors.error),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmRestore(BuildContext context) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(context.tr('Restore backup?')),
            content: Text(
              context.tr(
                'This replaces the habit data currently stored on this phone with your saved backup.',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(context.tr('Cancel')),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(context.tr('Restore')),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmed) return;
    try {
      await controller.restore();
    } catch (_) {
      // The controller exposes the error in this banner.
    }
  }

  String _date(DateTime date) => '${date.day}/${date.month}/${date.year}';
}
