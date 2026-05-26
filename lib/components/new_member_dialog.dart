import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../graphql/fragments/user_fragment.graphql.dart';
import '../graphql/queries/users.graphql.dart';
import '../graphql/schema.graphql.dart';
import '../graphql/mutations/create_member.graphql.dart';
import '../graphql_client.dart';
import 'form_container.dart';
import 'snackbar_alert.dart';
import 'user_item.dart';

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

  Future<Map<String, dynamic>?> _attemptToCreateMember() async {
    final graphQLClient = context.graphQLClient.value;
    final result = await graphQLClient.mutate$CreateMember(
      Options$Mutation$CreateMember(
        variables: Variables$Mutation$CreateMember(
          params: Input$MemberParams(boardId: widget.boardId, userId: _userId!, isAdmin: _isAdmin),
        ),
      ),
    );

    if (!mounted) {
      return null;
    }

    final errors = result.exception?.graphqlErrors.first;
    final createdMember = result.parsedData?.createMember;

    if (createdMember != null) {
      context.pop();

      return null;
    } else {
      showSnackBarAlert(context, errors?.message ?? 'Failed to create member');

      return errors?.extensions?['params'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      formKey: _formNewMember,
      onSubmit: () async {
        if (_formNewMember.currentState?.validate() == true) {
          _formNewMember.currentState?.save();
          final errors = await _attemptToCreateMember();

          if (errors != null) {
            setState(() {
              _errorUserId = errors['userId']?['message'];
            });
          }
        }
      },
      fields: [
        DropdownSearch<Fragment$UserFragment>(
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: 'User',
              errorText: _errorUserId,
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
            ),
          ),
          popupProps: PopupProps.dialog(
            showSearchBox: true,
            title: const Text('Select an user', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            dialogProps: const DialogProps(
              titlePadding: EdgeInsets.all(16),
              contentPadding: EdgeInsets.all(16),
              barrierDismissible: true,
              barrierLabel: 'Close',
            ),
            itemBuilder: (context, item, isDisabled, isSelected) => UserItem(user: item),
          ),
          compareFn: (item1, item2) => item1.id == item2.id,
          itemAsString: (item) => '${item.displayName} @${item.username}',
          dropdownBuilder: (context, item) => item != null ? UserItem(user: item) : SizedBox(),
          validator: (item) {
            if (item == null) {
              return 'Can\'t be blank';
            }

            return null;
          },
          onSelected: (item) {
            setState(() {
              _userId = item?.id;
            });
          },
          items: (filter, loadProps) async {
            final query = filter.trim();

            if (query.length < 3) {
              return [];
            }

            final graphQLClient = context.graphQLClient.value;

            final result = await graphQLClient.query$Users(
              Options$Query$Users(variables: Variables$Query$Users(query: query)),
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
