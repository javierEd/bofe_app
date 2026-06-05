import 'package:flutter/material.dart';

class InfiniteScrollView extends StatefulWidget {
  const InfiniteScrollView({super.key, required this.hasMore, required this.onScrollAtBottom, required this.child});

  final bool hasMore;
  final Future<void> Function() onScrollAtBottom;
  final Widget child;

  @override
  State<InfiniteScrollView> createState() => _InfiniteScrollViewState();
}

class _InfiniteScrollViewState extends State<InfiniteScrollView> {
  final _controller = ScrollController();
  bool _isLoading = false;

  Future<void> _scrollListener() async {
    if (widget.hasMore &&
        _controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _isLoading = true;
      });

      await widget.onScrollAtBottom();

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
    return SingleChildScrollView(
      controller: _controller,
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 8,
        children: [
          widget.child,
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
