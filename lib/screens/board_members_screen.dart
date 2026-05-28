import 'package:bofe/graphql/queries/board_members.graphql.dart';
import 'package:bofe/screens/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../build_context.dart';
import '../components/infinite_scroll_view.dart';
import '../components/loading_overlay.dart';
import '../components/new_member_dialog.dart';
import '../components/query_result_builder.dart';
import '../components/screen_title.dart';
import '../components/snackbar_alert.dart';
import '../components/user_item.dart';
import '../graphql/mutations/delete_member.graphql.dart';
import '../graphql/mutations/update_member.graphql.dart';
import '../graphql/queries/board_by_slug.graphql.dart';
import '../graphql/schema.graphql.dart';

class BoardMembersScreen extends StatelessWidget {
  const BoardMembersScreen({super.key, required this.slug});

  final String slug;

  Future<void> _attemptToDeleteMember(
    BuildContext context, {
    required String id,
    required Refetch<Query$BoardMembers>? refetch,
  }) async {
    final loadingOverlay = showLoadingOverlay(context);
    final result = await context.graphQLClient.mutate$DeleteMember(
      Options$Mutation$DeleteMember(variables: Variables$Mutation$DeleteMember(id: id)),
    );

    if (!context.mounted) {
      return;
    }

    if (result.parsedData?.deleteMember == true) {
      refetch?.call();
    } else {
      final errors = result.exception?.graphqlErrors.first;

      showSnackBarAlert(context, errors?.message ?? 'Failed to delete member');
    }

    loadingOverlay.hide();
  }

  Future<void> _attemptToUpdateMember(
    BuildContext context, {
    required String id,
    required bool isAdmin,
    required Refetch<Query$BoardMembers>? refetch,
  }) async {
    final loadingOverlay = showLoadingOverlay(context);
    final result = await context.graphQLClient.mutate$UpdateMember(
      Options$Mutation$UpdateMember(
        variables: Variables$Mutation$UpdateMember(
          id: id,
          params: Input$UpdateMemberParams(isAdmin: isAdmin),
        ),
      ),
    );

    if (!context.mounted) {
      return;
    }

    if (result.parsedData?.updateMember.id != null) {
      refetch?.call();
    } else {
      final errors = result.exception?.graphqlErrors.first;

      showSnackBarAlert(context, errors?.message ?? 'Failed to update member');
    }

    loadingOverlay.hide();
  }

  Future<void> _onScrollAtBottom(String boardId, String? endCursor, FetchMore<Query$BoardMembers>? fetchMore) async {
    await fetchMore?.call(
      FetchMoreOptions$Query$BoardMembers(
        variables: Variables$Query$BoardMembers(id: boardId, after: endCursor),
        updateQuery: (previousResultData, fetchMoreResultData) {
          if (fetchMoreResultData == null || fetchMoreResultData['board']['members']['nodes'].length == 0) {
            return previousResultData;
          }

          fetchMoreResultData['board']['members']['nodes'] = [
            ...previousResultData?['board']['members']['nodes'],
            ...fetchMoreResultData['board']['members']['nodes']
                .where(
                  (node) =>
                      previousResultData?['board']['members']['nodes']
                          .map((node1) => node1['id'])
                          .contains(node['id']) !=
                      true,
                )
                .toList(),
          ];

          return fetchMoreResultData;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Query$BoardBySlug$Widget(
      options: Options$Query$BoardBySlug(variables: Variables$Query$BoardBySlug(slug: slug)),
      builder: (result, {fetchMore, refetch}) {
        return QueryResultBuilder(
          result: result,
          buildIf: (parsedData) => parsedData?.boardBySlug != null,
          noResultWidget: const NotFoundScreen(),
          builder: (parsedData) {
            final board = parsedData.boardBySlug;

            return ScreenTitle(
              title: 'Members of ${board!.name}',
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Members of ${board.name}'),
                  actions: board.canCreateMember
                      ? [
                          IconButton(
                            onPressed: () => showNewMemberDialog(context, boardId: board.id),
                            tooltip: 'New Member',
                            icon: const Icon(Icons.person_add_rounded),
                          ),
                        ]
                      : null,
                ),
                body: Query$BoardMembers$Widget(
                  options: Options$Query$BoardMembers(variables: Variables$Query$BoardMembers(id: board.id, first: 20)),
                  builder: (result, {fetchMore, refetch}) {
                    return QueryResultBuilder(
                      result: result,
                      buildIf: (parsedData) => parsedData?.board?.members.nodes.isNotEmpty == true,
                      refetch: refetch,
                      builder: (parsedData) {
                        final members = parsedData.board?.members;
                        final endCursor = members?.pageInfo.endCursor;
                        final hasNextPage = members?.pageInfo.hasNextPage ?? false;

                        return InfiniteScrollView(
                          hasMore: hasNextPage,
                          onScrollAtBottom: () => _onScrollAtBottom(board.id, endCursor, fetchMore),
                          child: Column(
                            spacing: 3,
                            children:
                                members?.nodes
                                    .map(
                                      (member) => Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          UserItem(user: member.user),
                                          if (member.isAdmin || member.isEditable)
                                            Row(
                                              spacing: 8,
                                              children: [
                                                if (member.isAdmin) Text('Admin', style: TextStyle(color: Colors.grey)),
                                                if (member.isEditable)
                                                  PopupMenuButton(
                                                    icon: Icon(Icons.more_vert_rounded),
                                                    tooltip: 'More',
                                                    position: PopupMenuPosition.under,
                                                    onSelected: (value) {
                                                      switch (value) {
                                                        case 1:
                                                          _attemptToUpdateMember(
                                                            context,
                                                            id: member.id,
                                                            isAdmin: !member.isAdmin,
                                                            refetch: refetch,
                                                          );
                                                          break;
                                                        case 2:
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) => AlertDialog(
                                                              title: const Text('Confirm your action'),
                                                              content: const Text(
                                                                'Are you sure you want to delete this member?',
                                                              ),
                                                              actions: [
                                                                OutlinedButton(
                                                                  child: const Text('Cancel'),
                                                                  onPressed: () => context.pop(),
                                                                ),
                                                                FilledButton(
                                                                  child: const Text('Confirm'),
                                                                  onPressed: () {
                                                                    context.pop();
                                                                    _attemptToDeleteMember(
                                                                      context,
                                                                      id: member.id,
                                                                      refetch: refetch,
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                          break;
                                                      }
                                                    },
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                        value: 1,
                                                        child: member.isAdmin
                                                            ? const ListTile(
                                                                leading: Icon(Icons.remove_moderator_rounded),
                                                                title: Text('Disable Admin'),
                                                              )
                                                            : const ListTile(
                                                                leading: Icon(Icons.add_moderator_rounded),
                                                                title: Text('Enable Admin'),
                                                              ),
                                                      ),
                                                      const PopupMenuItem(
                                                        value: 2,
                                                        child: ListTile(
                                                          leading: Icon(Icons.delete_rounded),
                                                          title: Text('Delete'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    )
                                    .toList() ??
                                [],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
