import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'router.dart';

extension BuildContextExt on BuildContext {
  GraphQLClient get graphQLClient => GraphQLProvider.of(this).value;

  AppRouter get router => AppRouter(this);
}
