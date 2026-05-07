import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/board_item.dart';
import '../components/screen_title.dart';
import '../constants.dart';
import '../graphql/queries/user.graphql.dart';
import '../graphql/queries/user_boards.graphql.dart';
import '../screens/not_found_screen.dart';

class ShowUserScreen extends StatefulWidget {
  const ShowUserScreen({super.key, required this.username});

  final String username;

  @override
  State<ShowUserScreen> createState() => _ShowUserScreenState();
}

class _ShowUserScreenState extends State<ShowUserScreen> {
  final _scrollController = ScrollController();
  String? _boardsEndCursor;
  Function(FetchMoreOptions$Query$UserBoards)? _boardsFetchMore;

  void _scrollListener() {
    if (_scrollController.offset < _scrollController.position.maxScrollExtent ||
        _scrollController.position.outOfRange) {
      return;
    }

    _boardsFetchMore?.call(
      FetchMoreOptions$Query$UserBoards(
        variables: Variables$Query$UserBoards(username: widget.username, after: _boardsEndCursor, first: 12),
        updateQuery: (previousResultData, fetchMoreResultData) {
          if (fetchMoreResultData == null || fetchMoreResultData['user']['boards']['nodes'].length == 0) {
            return previousResultData;
          }

          fetchMoreResultData['user']['boards']['nodes'] = [
            ...previousResultData?['user']['boards']['nodes'],
            ...fetchMoreResultData['user']['boards']['nodes']
                .where(
                  (node) =>
                      previousResultData?['user']['boards']['nodes'].map((node1) => node1['id']).contains(node['id']) !=
                      true,
                )
                .toList(),
          ];

          return fetchMoreResultData;
        },
      ),
    );
  }

  Widget _getBoards() {
    return Query$UserBoards$Widget(
      options: Options$Query$UserBoards(
        fetchPolicy: FetchPolicy.noCache,
        variables: Variables$Query$UserBoards(username: widget.username, first: 12),
      ),
      builder: (result, {fetchMore, refetch}) {
        final user = result.parsedData?.user;

        _boardsEndCursor = user?.boards.pageInfo.endCursor;
        _boardsFetchMore = fetchMore;

        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          delegate: SliverChildListDelegate(
            user?.boards.nodes
                    .map(
                      (board) => BoardItem(
                        board: board,
                        onTap: () => context.goNamed(
                          routeNameShowUserBoard,
                          pathParameters: {keyUsername: widget.username, keySlug: board.slug},
                        ),
                      ),
                    )
                    .toList() ??
                [],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Query$User$Widget(
      options: Options$Query$User(variables: Variables$Query$User(username: widget.username)),
      builder: (result, {fetchMore, refetch}) {
        final user = result.parsedData?.user;

        if (user == null) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const NotFoundScreen();
          }
        }

        return ScreenTitle(
          title: '@${user.identityUser.username}',
          child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              leading: BackButton(onPressed: () => context.goNamed(routeNameHome)),
            ),
            body: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 16),
                    Center(
                      child: CircleAvatar(
                        radius: 48,
                        child: Text(user.identityUser.initials, style: TextStyle(fontSize: 48)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '@${user.identityUser.username}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    const SizedBox(height: 28),
                  ]),
                ),
                SliverPadding(padding: const EdgeInsets.all(16), sliver: _getBoards()),
              ],
            ),
          ),
        );
      },
    );
  }
}
