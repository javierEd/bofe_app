import '../fragments/card_fragment.graphql.dart';
import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Query$ListCards {
  factory Variables$Query$ListCards({
    required String id,
    String? after,
    int? first,
  }) => Variables$Query$ListCards._({
    r'id': id,
    if (after != null) r'after': after,
    if (first != null) r'first': first,
  });

  Variables$Query$ListCards._(this._$data);

  factory Variables$Query$ListCards.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    if (data.containsKey('after')) {
      final l$after = data['after'];
      result$data['after'] = (l$after as String?);
    }
    if (data.containsKey('first')) {
      final l$first = data['first'];
      result$data['first'] = (l$first as int?);
    }
    return Variables$Query$ListCards._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String? get after => (_$data['after'] as String?);

  int? get first => (_$data['first'] as int?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    if (_$data.containsKey('after')) {
      final l$after = after;
      result$data['after'] = l$after;
    }
    if (_$data.containsKey('first')) {
      final l$first = first;
      result$data['first'] = l$first;
    }
    return result$data;
  }

  CopyWith$Variables$Query$ListCards<Variables$Query$ListCards> get copyWith =>
      CopyWith$Variables$Query$ListCards(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$ListCards ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$after = after;
    final lOther$after = other.after;
    if (_$data.containsKey('after') != other._$data.containsKey('after')) {
      return false;
    }
    if (l$after != lOther$after) {
      return false;
    }
    final l$first = first;
    final lOther$first = other.first;
    if (_$data.containsKey('first') != other._$data.containsKey('first')) {
      return false;
    }
    if (l$first != lOther$first) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$after = after;
    final l$first = first;
    return Object.hashAll([
      l$id,
      _$data.containsKey('after') ? l$after : const {},
      _$data.containsKey('first') ? l$first : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$ListCards<TRes> {
  factory CopyWith$Variables$Query$ListCards(
    Variables$Query$ListCards instance,
    TRes Function(Variables$Query$ListCards) then,
  ) = _CopyWithImpl$Variables$Query$ListCards;

  factory CopyWith$Variables$Query$ListCards.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$ListCards;

  TRes call({String? id, String? after, int? first});
}

class _CopyWithImpl$Variables$Query$ListCards<TRes>
    implements CopyWith$Variables$Query$ListCards<TRes> {
  _CopyWithImpl$Variables$Query$ListCards(this._instance, this._then);

  final Variables$Query$ListCards _instance;

  final TRes Function(Variables$Query$ListCards) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? after = _undefined,
    Object? first = _undefined,
  }) => _then(
    Variables$Query$ListCards._({
      ..._instance._$data,
      if (id != _undefined && id != null) 'id': (id as String),
      if (after != _undefined) 'after': (after as String?),
      if (first != _undefined) 'first': (first as int?),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$ListCards<TRes>
    implements CopyWith$Variables$Query$ListCards<TRes> {
  _CopyWithStubImpl$Variables$Query$ListCards(this._res);

  TRes _res;

  call({String? id, String? after, int? first}) => _res;
}

class Query$ListCards {
  Query$ListCards({this.list, this.$__typename = 'QueryRoot'});

  factory Query$ListCards.fromJson(Map<String, dynamic> json) {
    final l$list = json['list'];
    final l$$__typename = json['__typename'];
    return Query$ListCards(
      list: l$list == null
          ? null
          : Query$ListCards$list.fromJson((l$list as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$ListCards$list? list;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$list = list;
    _resultData['list'] = l$list?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$list = list;
    final l$$__typename = $__typename;
    return Object.hashAll([l$list, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$ListCards || runtimeType != other.runtimeType) {
      return false;
    }
    final l$list = list;
    final lOther$list = other.list;
    if (l$list != lOther$list) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$ListCards on Query$ListCards {
  CopyWith$Query$ListCards<Query$ListCards> get copyWith =>
      CopyWith$Query$ListCards(this, (i) => i);
}

abstract class CopyWith$Query$ListCards<TRes> {
  factory CopyWith$Query$ListCards(
    Query$ListCards instance,
    TRes Function(Query$ListCards) then,
  ) = _CopyWithImpl$Query$ListCards;

  factory CopyWith$Query$ListCards.stub(TRes res) =
      _CopyWithStubImpl$Query$ListCards;

  TRes call({Query$ListCards$list? list, String? $__typename});
  CopyWith$Query$ListCards$list<TRes> get list;
}

class _CopyWithImpl$Query$ListCards<TRes>
    implements CopyWith$Query$ListCards<TRes> {
  _CopyWithImpl$Query$ListCards(this._instance, this._then);

  final Query$ListCards _instance;

  final TRes Function(Query$ListCards) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? list = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$ListCards(
          list: list == _undefined
              ? _instance.list
              : (list as Query$ListCards$list?),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );

  CopyWith$Query$ListCards$list<TRes> get list {
    final local$list = _instance.list;
    return local$list == null
        ? CopyWith$Query$ListCards$list.stub(_then(_instance))
        : CopyWith$Query$ListCards$list(local$list, (e) => call(list: e));
  }
}

class _CopyWithStubImpl$Query$ListCards<TRes>
    implements CopyWith$Query$ListCards<TRes> {
  _CopyWithStubImpl$Query$ListCards(this._res);

  TRes _res;

  call({Query$ListCards$list? list, String? $__typename}) => _res;

  CopyWith$Query$ListCards$list<TRes> get list =>
      CopyWith$Query$ListCards$list.stub(_res);
}

const documentNodeQueryListCards = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'ListCards'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'after')),
          type: NamedTypeNode(name: NameNode(value: 'UUID'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'first')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: false),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'list'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'cards'),
                  alias: null,
                  arguments: [
                    ArgumentNode(
                      name: NameNode(value: 'after'),
                      value: VariableNode(name: NameNode(value: 'after')),
                    ),
                    ArgumentNode(
                      name: NameNode(value: 'first'),
                      value: VariableNode(name: NameNode(value: 'first')),
                    ),
                  ],
                  directives: [],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FieldNode(
                        name: NameNode(value: 'nodes'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FragmentSpreadNode(
                              name: NameNode(value: 'CardFragment'),
                              directives: [],
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: 'pageInfo'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(
                          selections: [
                            FieldNode(
                              name: NameNode(value: 'endCursor'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                            FieldNode(
                              name: NameNode(value: '__typename'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null,
                            ),
                          ],
                        ),
                      ),
                      FieldNode(
                        name: NameNode(value: '__typename'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null,
                      ),
                    ],
                  ),
                ),
                FieldNode(
                  name: NameNode(value: 'createdAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'updatedAt'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ],
      ),
    ),
    fragmentDefinitionCardFragment,
  ],
);
Query$ListCards _parserFn$Query$ListCards(Map<String, dynamic> data) =>
    Query$ListCards.fromJson(data);
typedef OnQueryComplete$Query$ListCards =
    FutureOr<void> Function(Map<String, dynamic>?, Query$ListCards?);

class Options$Query$ListCards extends graphql.QueryOptions<Query$ListCards> {
  Options$Query$ListCards({
    String? operationName,
    required Variables$Query$ListCards variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$ListCards? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$ListCards? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(
                 data,
                 data == null ? null : _parserFn$Query$ListCards(data),
               ),
         onError: onError,
         document: documentNodeQueryListCards,
         parserFn: _parserFn$Query$ListCards,
       );

  final OnQueryComplete$Query$ListCards? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$ListCards
    extends graphql.WatchQueryOptions<Query$ListCards> {
  WatchOptions$Query$ListCards({
    String? operationName,
    required Variables$Query$ListCards variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$ListCards? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryListCards,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$ListCards,
       );
}

class FetchMoreOptions$Query$ListCards extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$ListCards({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$ListCards variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryListCards,
       );
}

extension ClientExtension$Query$ListCards on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$ListCards>> query$ListCards(
    Options$Query$ListCards options,
  ) async => await this.query(options);

  graphql.ObservableQuery<Query$ListCards> watchQuery$ListCards(
    WatchOptions$Query$ListCards options,
  ) => this.watchQuery(options);

  void writeQuery$ListCards({
    required Query$ListCards data,
    required Variables$Query$ListCards variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryListCards),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Query$ListCards? readQuery$ListCards({
    required Variables$Query$ListCards variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryListCards),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$ListCards.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$ListCards> useQuery$ListCards(
  Options$Query$ListCards options,
) => graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$ListCards> useWatchQuery$ListCards(
  WatchOptions$Query$ListCards options,
) => graphql_flutter.useWatchQuery(options);

class Query$ListCards$Widget extends graphql_flutter.Query<Query$ListCards> {
  Query$ListCards$Widget({
    widgets.Key? key,
    required Options$Query$ListCards options,
    required graphql_flutter.QueryBuilder<Query$ListCards> builder,
  }) : super(key: key, options: options, builder: builder);
}

class Query$ListCards$list {
  Query$ListCards$list({
    required this.id,
    required this.cards,
    required this.createdAt,
    this.updatedAt,
    this.$__typename = 'ListObject',
  });

  factory Query$ListCards$list.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$cards = json['cards'];
    final l$createdAt = json['createdAt'];
    final l$updatedAt = json['updatedAt'];
    final l$$__typename = json['__typename'];
    return Query$ListCards$list(
      id: (l$id as String),
      cards: Query$ListCards$list$cards.fromJson(
        (l$cards as Map<String, dynamic>),
      ),
      createdAt: DateTime.parse((l$createdAt as String)),
      updatedAt: l$updatedAt == null
          ? null
          : DateTime.parse((l$updatedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Query$ListCards$list$cards cards;

  final DateTime createdAt;

  final DateTime? updatedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$cards = cards;
    _resultData['cards'] = l$cards.toJson();
    final l$createdAt = createdAt;
    _resultData['createdAt'] = l$createdAt.toIso8601String();
    final l$updatedAt = updatedAt;
    _resultData['updatedAt'] = l$updatedAt?.toIso8601String();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$cards = cards;
    final l$createdAt = createdAt;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$cards,
      l$createdAt,
      l$updatedAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$ListCards$list || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$cards = cards;
    final lOther$cards = other.cards;
    if (l$cards != lOther$cards) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$updatedAt = updatedAt;
    final lOther$updatedAt = other.updatedAt;
    if (l$updatedAt != lOther$updatedAt) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$ListCards$list on Query$ListCards$list {
  CopyWith$Query$ListCards$list<Query$ListCards$list> get copyWith =>
      CopyWith$Query$ListCards$list(this, (i) => i);
}

abstract class CopyWith$Query$ListCards$list<TRes> {
  factory CopyWith$Query$ListCards$list(
    Query$ListCards$list instance,
    TRes Function(Query$ListCards$list) then,
  ) = _CopyWithImpl$Query$ListCards$list;

  factory CopyWith$Query$ListCards$list.stub(TRes res) =
      _CopyWithStubImpl$Query$ListCards$list;

  TRes call({
    String? id,
    Query$ListCards$list$cards? cards,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? $__typename,
  });
  CopyWith$Query$ListCards$list$cards<TRes> get cards;
}

class _CopyWithImpl$Query$ListCards$list<TRes>
    implements CopyWith$Query$ListCards$list<TRes> {
  _CopyWithImpl$Query$ListCards$list(this._instance, this._then);

  final Query$ListCards$list _instance;

  final TRes Function(Query$ListCards$list) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? cards = _undefined,
    Object? createdAt = _undefined,
    Object? updatedAt = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$ListCards$list(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      cards: cards == _undefined || cards == null
          ? _instance.cards
          : (cards as Query$ListCards$list$cards),
      createdAt: createdAt == _undefined || createdAt == null
          ? _instance.createdAt
          : (createdAt as DateTime),
      updatedAt: updatedAt == _undefined
          ? _instance.updatedAt
          : (updatedAt as DateTime?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Query$ListCards$list$cards<TRes> get cards {
    final local$cards = _instance.cards;
    return CopyWith$Query$ListCards$list$cards(
      local$cards,
      (e) => call(cards: e),
    );
  }
}

class _CopyWithStubImpl$Query$ListCards$list<TRes>
    implements CopyWith$Query$ListCards$list<TRes> {
  _CopyWithStubImpl$Query$ListCards$list(this._res);

  TRes _res;

  call({
    String? id,
    Query$ListCards$list$cards? cards,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? $__typename,
  }) => _res;

  CopyWith$Query$ListCards$list$cards<TRes> get cards =>
      CopyWith$Query$ListCards$list$cards.stub(_res);
}

class Query$ListCards$list$cards {
  Query$ListCards$list$cards({
    required this.nodes,
    required this.pageInfo,
    this.$__typename = 'CardObjectConnection',
  });

  factory Query$ListCards$list$cards.fromJson(Map<String, dynamic> json) {
    final l$nodes = json['nodes'];
    final l$pageInfo = json['pageInfo'];
    final l$$__typename = json['__typename'];
    return Query$ListCards$list$cards(
      nodes: (l$nodes as List<dynamic>)
          .map(
            (e) => Fragment$CardFragment.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      pageInfo: Query$ListCards$list$cards$pageInfo.fromJson(
        (l$pageInfo as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$CardFragment> nodes;

  final Query$ListCards$list$cards$pageInfo pageInfo;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$nodes = nodes;
    _resultData['nodes'] = l$nodes.map((e) => e.toJson()).toList();
    final l$pageInfo = pageInfo;
    _resultData['pageInfo'] = l$pageInfo.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$nodes = nodes;
    final l$pageInfo = pageInfo;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$nodes.map((v) => v)),
      l$pageInfo,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$ListCards$list$cards ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$nodes = nodes;
    final lOther$nodes = other.nodes;
    if (l$nodes.length != lOther$nodes.length) {
      return false;
    }
    for (int i = 0; i < l$nodes.length; i++) {
      final l$nodes$entry = l$nodes[i];
      final lOther$nodes$entry = lOther$nodes[i];
      if (l$nodes$entry != lOther$nodes$entry) {
        return false;
      }
    }
    final l$pageInfo = pageInfo;
    final lOther$pageInfo = other.pageInfo;
    if (l$pageInfo != lOther$pageInfo) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$ListCards$list$cards
    on Query$ListCards$list$cards {
  CopyWith$Query$ListCards$list$cards<Query$ListCards$list$cards>
  get copyWith => CopyWith$Query$ListCards$list$cards(this, (i) => i);
}

abstract class CopyWith$Query$ListCards$list$cards<TRes> {
  factory CopyWith$Query$ListCards$list$cards(
    Query$ListCards$list$cards instance,
    TRes Function(Query$ListCards$list$cards) then,
  ) = _CopyWithImpl$Query$ListCards$list$cards;

  factory CopyWith$Query$ListCards$list$cards.stub(TRes res) =
      _CopyWithStubImpl$Query$ListCards$list$cards;

  TRes call({
    List<Fragment$CardFragment>? nodes,
    Query$ListCards$list$cards$pageInfo? pageInfo,
    String? $__typename,
  });
  TRes nodes(
    Iterable<Fragment$CardFragment> Function(
      Iterable<CopyWith$Fragment$CardFragment<Fragment$CardFragment>>,
    )
    _fn,
  );
  CopyWith$Query$ListCards$list$cards$pageInfo<TRes> get pageInfo;
}

class _CopyWithImpl$Query$ListCards$list$cards<TRes>
    implements CopyWith$Query$ListCards$list$cards<TRes> {
  _CopyWithImpl$Query$ListCards$list$cards(this._instance, this._then);

  final Query$ListCards$list$cards _instance;

  final TRes Function(Query$ListCards$list$cards) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? nodes = _undefined,
    Object? pageInfo = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$ListCards$list$cards(
      nodes: nodes == _undefined || nodes == null
          ? _instance.nodes
          : (nodes as List<Fragment$CardFragment>),
      pageInfo: pageInfo == _undefined || pageInfo == null
          ? _instance.pageInfo
          : (pageInfo as Query$ListCards$list$cards$pageInfo),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes nodes(
    Iterable<Fragment$CardFragment> Function(
      Iterable<CopyWith$Fragment$CardFragment<Fragment$CardFragment>>,
    )
    _fn,
  ) => call(
    nodes: _fn(
      _instance.nodes.map((e) => CopyWith$Fragment$CardFragment(e, (i) => i)),
    ).toList(),
  );

  CopyWith$Query$ListCards$list$cards$pageInfo<TRes> get pageInfo {
    final local$pageInfo = _instance.pageInfo;
    return CopyWith$Query$ListCards$list$cards$pageInfo(
      local$pageInfo,
      (e) => call(pageInfo: e),
    );
  }
}

class _CopyWithStubImpl$Query$ListCards$list$cards<TRes>
    implements CopyWith$Query$ListCards$list$cards<TRes> {
  _CopyWithStubImpl$Query$ListCards$list$cards(this._res);

  TRes _res;

  call({
    List<Fragment$CardFragment>? nodes,
    Query$ListCards$list$cards$pageInfo? pageInfo,
    String? $__typename,
  }) => _res;

  nodes(_fn) => _res;

  CopyWith$Query$ListCards$list$cards$pageInfo<TRes> get pageInfo =>
      CopyWith$Query$ListCards$list$cards$pageInfo.stub(_res);
}

class Query$ListCards$list$cards$pageInfo {
  Query$ListCards$list$cards$pageInfo({
    this.endCursor,
    this.$__typename = 'PageInfo',
  });

  factory Query$ListCards$list$cards$pageInfo.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$endCursor = json['endCursor'];
    final l$$__typename = json['__typename'];
    return Query$ListCards$list$cards$pageInfo(
      endCursor: (l$endCursor as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? endCursor;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$endCursor = endCursor;
    _resultData['endCursor'] = l$endCursor;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$endCursor = endCursor;
    final l$$__typename = $__typename;
    return Object.hashAll([l$endCursor, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$ListCards$list$cards$pageInfo ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$endCursor = endCursor;
    final lOther$endCursor = other.endCursor;
    if (l$endCursor != lOther$endCursor) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$ListCards$list$cards$pageInfo
    on Query$ListCards$list$cards$pageInfo {
  CopyWith$Query$ListCards$list$cards$pageInfo<
    Query$ListCards$list$cards$pageInfo
  >
  get copyWith => CopyWith$Query$ListCards$list$cards$pageInfo(this, (i) => i);
}

abstract class CopyWith$Query$ListCards$list$cards$pageInfo<TRes> {
  factory CopyWith$Query$ListCards$list$cards$pageInfo(
    Query$ListCards$list$cards$pageInfo instance,
    TRes Function(Query$ListCards$list$cards$pageInfo) then,
  ) = _CopyWithImpl$Query$ListCards$list$cards$pageInfo;

  factory CopyWith$Query$ListCards$list$cards$pageInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$ListCards$list$cards$pageInfo;

  TRes call({String? endCursor, String? $__typename});
}

class _CopyWithImpl$Query$ListCards$list$cards$pageInfo<TRes>
    implements CopyWith$Query$ListCards$list$cards$pageInfo<TRes> {
  _CopyWithImpl$Query$ListCards$list$cards$pageInfo(this._instance, this._then);

  final Query$ListCards$list$cards$pageInfo _instance;

  final TRes Function(Query$ListCards$list$cards$pageInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? endCursor = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$ListCards$list$cards$pageInfo(
      endCursor: endCursor == _undefined
          ? _instance.endCursor
          : (endCursor as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$ListCards$list$cards$pageInfo<TRes>
    implements CopyWith$Query$ListCards$list$cards$pageInfo<TRes> {
  _CopyWithStubImpl$Query$ListCards$list$cards$pageInfo(this._res);

  TRes _res;

  call({String? endCursor, String? $__typename}) => _res;
}
