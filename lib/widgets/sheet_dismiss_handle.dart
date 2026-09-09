import 'package:flutter/material.dart';

/// A reusable handle for modal editors that closes the route when dragged down.
class SheetDismissHandle extends StatefulWidget {
  const SheetDismissHandle({super.key});

  @override
  State<SheetDismissHandle> createState() => _SheetDismissHandleState();
}

class _SheetDismissHandleState extends State<SheetDismissHandle> {
  double _downwardDistance = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragStart: (_) => _downwardDistance = 0,
      onVerticalDragUpdate: (details) {
        _downwardDistance = (_downwardDistance + details.delta.dy).clamp(
          0,
          120,
        );
      },
      onVerticalDragCancel: () => _downwardDistance = 0,
      onVerticalDragEnd: (details) {
        final velocity = details.primaryVelocity ?? 0;
        if (_downwardDistance >= 30 || velocity >= 320) {
          Navigator.of(context).maybePop();
        }
        _downwardDistance = 0;
      },
      child: SizedBox(
        height: 30,
        width: double.infinity,
        child: Center(
          child: Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ),
      ),
    );
  }
}
