import 'package:bofe/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/card_popup_menu_button.dart';
import '../components/query_result_builder.dart';
import '../components/scrollable_dialog.dart';
import '../components/user_item.dart';
import '../graphql/queries/card.graphql.dart';

class CardDialogScreen extends StatelessWidget {
  const CardDialogScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return ScrollableDialog(
      child: Query$Card$Widget(
        options: Options$Query$Card(variables: Variables$Query$Card(id: id)),
        builder: (result, {fetchMore, refetch}) {
          return QueryResultBuilder(
            result: result,
            refetch: refetch,
            buildIf: (parsedData) => parsedData?.card != null,
            builder: (parsedData) {
              final card = parsedData.card!;

              return Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
                        onTap: () =>
                            context.goNamed(routeNameShowUser, pathParameters: {keyUsername: card.user.username}),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: UserItem(user: card.user),
                        ),
                      ),
                      CardPopupMenuButton(card: card),
                    ],
                  ),
                  SelectableText(card.content, style: TextStyle(fontSize: 18)),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
