import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScrollableDialog extends StatelessWidget {
  const ScrollableDialog({super.key, required this.child, this.title, this.width = 640});

  final Widget? title;
  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dialogTheme = DialogTheme.of(context).titleTextStyle ?? TextTheme.of(context).titleLarge!;

    return GestureDetector(
      onTap: () => context.pop(),
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: screenSize.height),
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Dialog(
                child: Container(
                  width: width,
                  padding: const EdgeInsets.all(16),
                  child: title != null
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 16,
                          children: [
                            DefaultTextStyle(style: dialogTheme, child: title!),
                            child,
                          ],
                        )
                      : child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
