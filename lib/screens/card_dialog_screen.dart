import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../build_context.dart';
import '../components/card_popup_menu_button.dart';
import '../components/query_result_builder.dart';
import '../components/scrollable_dialog.dart';
import '../components/user_item.dart';
import '../graphql/fragments/board_fragment.graphql.dart';
import '../graphql/queries/card.graphql.dart';

class CardDialogScreen extends StatelessWidget {
  const CardDialogScreen({super.key, required this.board, required this.id});

  final Fragment$BoardFragment board;
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
            buildIf: (parsedData) => parsedData?.card?.board.id == board.id,
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
                        onTap: () => context.router.pushToUser(card.user),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: UserItem(user: card.user),
                        ),
                      ),
                      CardPopupMenuButton(
                        card: card,
                        beforeEdit: () {
                          context.pop();
                        },
                      ),
                    ],
                  ),
                  MarkdownBody(
                    data: card.content,
                    selectable: true,
                    softLineBreak: true,
                    styleSheet: MarkdownStyleSheet(textScaler: TextScaler.linear(1.3)),
                    onTapLink: (text, href, title) async {
                      if (href != null && await canLaunchUrlString(href)) {
                        launchUrlString(href, mode: LaunchMode.inAppBrowserView);
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
