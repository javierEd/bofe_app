import 'package:flutter/material.dart';

import '../components/query_result_builder.dart';
import '../constants.dart';
import '../graphql/fragments/board_fragment.graphql.dart';
import '../graphql/queries/board_by_slug.graphql.dart';
import '../screens/not_found_screen.dart';
import 'dialog_page.dart';

class BoardContext extends Query$BoardBySlug$Widget {
  BoardContext({
    super.key,
    required String username,
    required String slug,
    required Widget Function(Fragment$BoardFragment board) builder,
  }) : super(
         options: Options$Query$BoardBySlug(variables: Variables$Query$BoardBySlug(slug: slug)),
         builder: (result, {fetchMore, refetch}) => QueryResultBuilder(
           result: result,
           refetch: refetch,
           buildIf: (parsedData) =>
               parsedData?.boardBySlug != null &&
               parsedData?.boardBySlug?.user.username.toLowerCase() == username.toLowerCase(),
           noResultWidget: const NotFoundScreen(),
           builder: (parsedData) => builder(parsedData.boardBySlug!),
         ),
       );
}

class BoardContextDialogPage extends DialogPage {
  BoardContextDialogPage({
    required Map<String, String> pathParameters,
    required Widget Function(Fragment$BoardFragment board) builder,
  }) : super(
         barrierDismissible: false,
         builder: (context) =>
             BoardContext(username: pathParameters[keyUsername]!, slug: pathParameters[keySlug]!, builder: builder),
       );
}
