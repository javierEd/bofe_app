import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScrollableDialog extends StatefulWidget {
  const ScrollableDialog({
    super.key,
    this.barrierDismissible = true,
    this.title,
    this.actions = const [],
    required this.child,
    this.width = 640,
    this.hasMore = false,
    this.onScrollAtBottom,
  });

  final bool barrierDismissible;
  final Widget? title;
  final List<Widget> actions;
  final Widget child;
  final double width;
  final bool hasMore;
  final Future<void> Function()? onScrollAtBottom;

  @override
  State<ScrollableDialog> createState() => _ScrollableDialogState();
}

class _ScrollableDialogState extends State<ScrollableDialog> {
  final _controller = ScrollController();
  bool _isLoading = false;

  Future<void> _scrollListener() async {
    if (widget.hasMore &&
        widget.onScrollAtBottom != null &&
        _controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _isLoading = true;
      });

      await widget.onScrollAtBottom?.call();

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dialogTheme = DialogTheme.of(context).titleTextStyle ?? TextTheme.of(context).titleLarge!;

    return GestureDetector(
      onTap: () {
        if (widget.barrierDismissible) {
          context.pop();
        }
      },
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: screenSize.height),
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Dialog(
                child: Container(
                  width: widget.width,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      if (widget.title != null || widget.actions.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (widget.title != null) DefaultTextStyle(style: dialogTheme, child: widget.title!),
                              if (widget.actions.isNotEmpty) ...[Spacer(), ...widget.actions],
                            ],
                          ),
                        ),
                      widget.child,
                      if (_isLoading) const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
