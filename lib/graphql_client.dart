import 'package:graphql_flutter/graphql_flutter.dart';

import 'config.dart';
import 'constants.dart';
import 'preferences.dart';
import 'session_manager.dart';

GraphQLClient getGraphQLClient() {
  final httpLink = AuthLink(getToken: () => SessionManager.bearer)
      .concat(
        ErrorLink(
          onException: (request, forward, exception) {
            if (exception is ServerException && exception.statusCode == 401) {
              SessionManager.onUnauthorized();

              throw exception;
            }

            return forward(request);
          },
        ),
      )
      .concat(
        HttpLink(
          Config.apiUrl.replace(path: '/graphql').toString(),
          defaultHeaders: {
            headerXAppToken: Config.appToken,
            headerAcceptLanguage: Preferences.language.toLanguageTag(),
          },
        ),
      );
  final webSocketLink = WebSocketLink(
    Config.webSocketUrl.replace(path: '/ws').toString(),
    subProtocol: GraphQLProtocol.graphqlTransportWs,
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: const Duration(minutes: 1),
      delayBetweenReconnectionAttempts: const Duration(seconds: 10),
      initialPayload: () => {'app-token': Config.appToken, 'session-token': SessionManager.token},
    ),
  );

  return GraphQLClient(
    link: Link.split((request) => request.isSubscription, webSocketLink, httpLink),
    cache: GraphQLCache(store: HiveStore()),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.networkOnly),
      mutate: Policies(fetch: FetchPolicy.networkOnly),
      watchQuery: Policies(fetch: FetchPolicy.cacheAndNetwork),
    ),
    queryRequestTimeout: const Duration(minutes: 1),
  );
}
