import 'package:flutter/material.dart';

class InfiniteScrollView extends StatefulWidget {
  const InfiniteScrollView({
    super.key,
    required this.hasMore,
    required this.isLoading,
    required this.onScrollAtBottom,
    required this.child,
  });

  final bool hasMore;
  final bool isLoading;
  final Function() onScrollAtBottom;
  final Widget child;

  @override
  State<InfiniteScrollView> createState() => _InfiniteScrollViewState();
}

class _InfiniteScrollViewState extends State<InfiniteScrollView> {
  final _controller = ScrollController();

  void _scrollListener() {
    if (widget.hasMore &&
        _controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      widget.onScrollAtBottom();
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
    return SingleChildScrollView(
      controller: _controller,
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 6,
        children: [
          widget.child,
          if (widget.isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
