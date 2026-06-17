import 'package:bofe/graphql/fragments/board_fragment.graphql.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../build_context.dart';
import '../../components.dart';
import '../../components/current_user.dart';
import '../../components/loading_overlay.dart';
import '../../components/scrollable_dialog.dart';
import '../../components/user_item.dart';
import '../../graphql/mutations/delete_member.graphql.dart';
import '../../graphql/mutations/update_member.graphql.dart';
import '../../graphql/queries/board_members.graphql.dart';
import '../../graphql/schema.graphql.dart';

class MembersDialogScreen extends StatefulWidget {
  const MembersDialogScreen({super.key, required this.board});

  final Fragment$BoardFragment board;

  @override
  State<MembersDialogScreen> createState() => _MembersDialogScreenState();
}

class _MembersDialogScreenState extends State<MembersDialogScreen> {
  String? _endCursor;
  FetchMore<Query$BoardMembers>? _fetchMore;
  bool _hasNextPage = false;

  Future<void> _attemptToDeleteMember(BuildContext context, {required String id, required Function() onSuccess}) async {
    final loadingOverlay = showLoadingOverlay(context);
    final result = await context.graphQLClient.mutate$DeleteMember(
      Options$Mutation$DeleteMember(variables: Variables$Mutation$DeleteMember(id: id)),
    );

    if (!context.mounted) {
      return;
    }

    if (result.parsedData?.deleteMember == true) {
      onSuccess();
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

  Future<void> _onScrollAtBottom() async {
    await _fetchMore?.call(
      FetchMoreOptions$Query$BoardMembers(
        variables: Variables$Query$BoardMembers(id: widget.board.id, after: _endCursor),
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
    return ScrollableDialog(
      title: Text('Members'),
      actions: [
        if (widget.board.canCreateMember)
          IconButton(
            onPressed: () => showNewMemberDialog(context, boardId: widget.board.id),
            tooltip: 'New Member',
            icon: const Icon(Icons.person_add_rounded),
          ),
      ],
      hasMore: _hasNextPage,
      onScrollAtBottom: _onScrollAtBottom,
      child: Query$BoardMembers$Widget(
        options: Options$Query$BoardMembers(variables: Variables$Query$BoardMembers(id: widget.board.id, first: 20)),
        builder: (result, {fetchMore, refetch}) {
          _fetchMore ??= fetchMore;

          return QueryResultBuilder(
            result: result,
            buildIf: (parsedData) => parsedData?.board?.members.nodes.isNotEmpty == true,
            refetch: refetch,
            builder: (parsedData) {
              final members = parsedData.board?.members;
              _endCursor = members?.pageInfo.endCursor;
              _hasNextPage = members?.pageInfo.hasNextPage ?? false;

              return CurrentUser(
                builder: (user) => Column(
                  spacing: 3,
                  children:
                      members?.nodes
                          .map(
                            (member) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UserItem(user: member.user, onTap: () => context.router.pushToUser(member.user)),
                                if (member.isAdmin || member.isEditable)
                                  Row(
                                    spacing: 8,
                                    children: [
                                      if (member.isAdmin) Text('Admin', style: TextStyle(color: Colors.grey)),
                                      if (member.isEditable || member.isRemovable)
                                        PopupMenuButton(
                                          icon: Icon(Icons.more_vert_rounded),
                                          tooltip: 'More',
                                          position: PopupMenuPosition.under,
                                          onSelected: (value) {
                                            switch (value) {
                                              case 1:
                                                if (member.isAdmin) {
                                                  _attemptToUpdateMember(
                                                    context,
                                                    id: member.id,
                                                    isAdmin: !member.isAdmin,
                                                    refetch: refetch,
                                                  );
                                                }
                                                break;
                                              case 2:
                                                if (member.isRemovable) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) => AlertDialog(
                                                      title: const Text('Confirm your action'),
                                                      content: Text(
                                                        user?.id == member.user.id
                                                            ? 'Are you sure you want to leave this board?'
                                                            : 'Are you sure you want to remove this member?',
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
                                                              onSuccess: () {
                                                                if (user?.id == member.user.id) {
                                                                  context.router.goToHome();
                                                                } else {
                                                                  refetch?.call();
                                                                }
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                                break;
                                            }
                                          },
                                          itemBuilder: (context) => [
                                            if (member.isEditable)
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
                                            if (member.isRemovable)
                                              PopupMenuItem(
                                                value: 2,
                                                child: ListTile(
                                                  leading: Icon(Icons.person_remove_rounded),
                                                  title: Text(user?.id == member.user.id ? 'Leave' : 'Remove'),
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
    );
  }
}
