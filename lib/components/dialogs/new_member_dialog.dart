import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../build_context.dart';
import '../../graphql/fragments/user_fragment.graphql.dart';
import '../../graphql/queries/users.graphql.dart';
import '../../graphql/schema.graphql.dart';
import '../../graphql/mutations/create_member.graphql.dart';
import '../dropdown_search_field.dart';
import '../forms/form_container.dart';
import '../user_item.dart';

Future<dynamic> showNewMemberDialog(BuildContext context, {required boardId}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('New Member'),
        content: _NewMemberForm(boardId: boardId),
      );
    },
  );
}

class _NewMemberForm extends StatefulWidget {
  const _NewMemberForm({required this.boardId});

  final String boardId;

  @override
  State<_NewMemberForm> createState() => _NewMemberFormState();
}

class _NewMemberFormState extends State<_NewMemberForm> {
  final _formNewMember = GlobalKey<FormState>();

  String? _userId;
  bool _isAdmin = false;
  String? _errorUserId;

  Future<GraphQLError?> _attemptToCreateMember() async {
    final result = await context.graphQLClient.mutate$CreateMember(
      Options$Mutation$CreateMember(
        variables: Variables$Mutation$CreateMember(
          params: Input$MemberParams(boardId: widget.boardId, userId: _userId!, isAdmin: _isAdmin),
        ),
      ),
    );

    if (!mounted) {
      return null;
    }

    if (result.parsedData?.createMember != null) {
      context.pop();

      return null;
    }

    return result.exception?.graphqlErrors.first;
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      formKey: _formNewMember,
      onSubmit: () async {
        final errors = await _attemptToCreateMember();

        if (errors != null) {
          setState(() {
            _errorUserId = errors.extensions?['params']?['userId']?['message'];
          });

          return errors.message;
        }

        return null;
      },
      fields: [
        DropdownSearchField<Fragment$UserFragment>(
          labelText: 'User',
          errorText: _errorUserId,
          required: true,
          itemBuilder: (context, item, isDisabled, isSelected) => UserItem(user: item),
          compareFn: (item1, item2) => item1.id == item2.id,
          itemAsString: (item) => '${item.displayName} @${item.username}',
          dropdownBuilder: (context, item) => item != null ? UserItem(user: item) : SizedBox(),
          onSaved: (item) {
            setState(() {
              _userId = item?.id;
            });
          },
          items: (filter, loadProps) async {
            if (filter.length < 3) {
              return [];
            }

            final result = await context.graphQLClient.query$Users(
              Options$Query$Users(variables: Variables$Query$Users(query: filter)),
            );

            return result.parsedData?.users.nodes ?? [];
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Is admin?'),
            Switch(
              value: _isAdmin,
              onChanged: (value) {
                setState(() {
                  _isAdmin = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
