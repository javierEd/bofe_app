import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../build_context.dart';
import '../../graphql/queries/card_attachment.graphql.dart';
import '../query_result_builder.dart';

void showCardAttachmentDialog(BuildContext context, {required String cardId, required String id}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Dialog.fullscreen(
      child: _CardAttachmentDialog(cardId: cardId, id: id),
    ),
  );
}

class _CardAttachmentDialog extends StatefulWidget {
  const _CardAttachmentDialog({required this.cardId, required this.id});

  final String cardId;
  final String id;

  @override
  State<_CardAttachmentDialog> createState() => _CardAttachmentDialogState();
}

class _CardAttachmentDialogState extends State<_CardAttachmentDialog> {
  int _attempts = 0;

  Future<void> _download() async {
    final result = await context.graphQLClient.query$CardAttachment(
      Options$Query$CardAttachment(
        variables: Variables$Query$CardAttachment(cardId: widget.cardId, id: widget.id),
      ),
    );
    final attachmentUrl = result.parsedData?.card?.attachment?.url.replace(queryParameters: {'download': 'true'});

    if (attachmentUrl != null && await canLaunchUrl(attachmentUrl)) {
      await launchUrl(attachmentUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Query$CardAttachment$Widget(
      options: Options$Query$CardAttachment(
        fetchPolicy: FetchPolicy.cacheFirst,
        variables: Variables$Query$CardAttachment(cardId: widget.cardId, id: widget.id),
      ),
      builder: (result, {fetchMore, refetch}) => QueryResultBuilder(
        result: result,
        refetch: refetch,
        buildIf: (parsedData) => parsedData?.card?.attachment != null,
        builder: (parsedData) => Scaffold(
          appBar: AppBar(
            title: Text(parsedData.card!.attachment!.fileName),
            actions: [
              IconButton(icon: Icon(Icons.download_rounded), tooltip: context.l10n.download, onPressed: _download),
            ],
          ),
          body: Center(
            child: CachedNetworkImage(
              useOldImageOnUrlChange: true,
              errorListener: (error) {
                if (_attempts++ < 3) {
                  refetch?.call();
                }
              },
              progressIndicatorBuilder: (context, url, progress) => CircularProgressIndicator(value: progress.progress),
              imageUrl: parsedData.card!.attachment!.url.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
