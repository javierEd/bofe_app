import 'package:boards/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'config.dart';
import 'session.dart';

extension GraphQLClientExt on GraphQLClient {
  static GraphQLClient setup() => GraphQLClient(
    link: AuthLink(getToken: () => Session.bearer)
        .concat(
          ErrorLink(
            onException: (request, forward, exception) {
              if (exception is ServerException && exception.statusCode == 401) {
                Session.onUnauthorized();

                throw exception;
              }

              return forward(request);
            },
          ),
        )
        .concat(
          HttpLink(
            Config.boardsApiUrl.replace(path: '/graphql').toString(),
            defaultHeaders: {headerXAppToken: Config.boardsAppToken},
          ),
        ),
    cache: GraphQLCache(store: HiveStore()),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.networkOnly),
      mutate: Policies(fetch: FetchPolicy.networkOnly),
      watchQuery: Policies(fetch: FetchPolicy.cacheAndNetwork),
    ),
    queryRequestTimeout: const Duration(minutes: 1),
  );
}

extension BuildContextExt on BuildContext {
  ValueNotifier<GraphQLClient> get graphQLClient => GraphQLProvider.of(this);
}
