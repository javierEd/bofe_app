import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../build_context.dart';
import '../graphql/fragments/card_fragment.graphql.dart';
import '../graphql/mutations/delete_card.graphql.dart';
import 'loading_overlay.dart';
import 'snackbar_alert.dart';

class CardPopupMenuButton extends StatelessWidget {
  const CardPopupMenuButton({super.key, required this.card, this.iconSize, this.beforeEdit});

  final Fragment$CardFragment card;
  final double? iconSize;
  final Function()? beforeEdit;

  Future<void> _attemptToDeleteCard(BuildContext context) async {
    final loadingOverlay = showLoadingOverlay(context);
    final result = await context.graphQLClient.mutate$DeleteCard(
      Options$Mutation$DeleteCard(variables: Variables$Mutation$DeleteCard(id: card.id)),
    );

    if (context.mounted && result.parsedData?.deleteCard != true) {
      final errors = result.exception?.graphqlErrors.first;

      showSnackBarAlert(context, errors?.message ?? 'Failed to delete card');
    }

    loadingOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    if (card.isEditable) {
      return PopupMenuButton(
        icon: Icon(Icons.more_vert_rounded),
        iconSize: iconSize,
        tooltip: 'More',
        position: PopupMenuPosition.under,
        onSelected: (value) {
          switch (value) {
            case 1:
              beforeEdit?.call();
              context.router.goToEditCard(card);
              break;
            case 2:
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirm your action'),
                  content: const Text('Are you sure you want to delete this card?'),
                  actions: [
                    OutlinedButton(child: const Text('Cancel'), onPressed: () => context.pop()),
                    FilledButton(
                      child: const Text('Confirm'),
                      onPressed: () {
                        context.pop();
                        _attemptToDeleteCard(context);
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
            child: ListTile(leading: Icon(Icons.edit_rounded), title: Text('Edit')),
          ),
          PopupMenuItem(
            value: 2,
            child: ListTile(leading: Icon(Icons.delete_rounded), title: Text('Delete')),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }
}
