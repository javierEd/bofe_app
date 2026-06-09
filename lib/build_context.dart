import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'l10n/app_localizations.g.dart';
import 'router.dart';

extension BuildContextExt on BuildContext {
  GraphQLClient get graphQLClient => GraphQLProvider.of(this).value;

  AppLocalizations get l10n => AppLocalizations.of(this)!;

  AppRouter get router => AppRouter(this);
}
