import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScrollableDialog extends StatelessWidget {
  const ScrollableDialog({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => context.pop(),
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: screenSize.height),
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Dialog(
                child: Container(width: 640, padding: const EdgeInsets.all(16), child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
