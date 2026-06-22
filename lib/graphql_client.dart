import 'package:graphql_flutter/graphql_flutter.dart';

import 'config.dart';
import 'constants.dart';
import 'preferences.dart';
import 'sessions_manager.dart';

GraphQLClient getGraphQLClient({bool includeToken = true}) {
  final httpLink = AuthLink(getToken: () => includeToken ? SessionsManager.bearer : null)
      .concat(
        ErrorLink(
          onException: (request, forward, exception) {
            if (exception is ServerException && exception.statusCode == 401) {
              SessionsManager.onUnauthorized();

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
      initialPayload: () => {
        'app-token': Config.appToken,
        'session-token': includeToken ? SessionsManager.token : null,
      },
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

extension GraphQLMutationExt<T> on QueryResult<T> {
  GraphQLError? get _mutationError => exception?.graphqlErrors.first;

  String? get errorMessage => _mutationError?.message;

  bool get hasErrors => _mutationError != null;

  String? getParamError(String name) {
    return _mutationError?.extensions?['params']?[name]?['message'];
  }
}
