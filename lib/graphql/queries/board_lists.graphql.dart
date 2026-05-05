import '../fragments/list_fragment.graphql.dart';
import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Query$BoardLists {
  factory Variables$Query$BoardLists({
    required String idOrSlug,
    String? after,
    int? first,
  }) => Variables$Query$BoardLists._({
    r'idOrSlug': idOrSlug,
    if (after != null) r'after': after,
    if (first != null) r'first': first,
  });

  Variables$Query$BoardLists._(this._$data);

  factory Variables$Query$BoardLists.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$idOrSlug = data['idOrSlug'];
    result$data['idOrSlug'] = (l$idOrSlug as String);
    if (data.containsKey('after')) {
      final l$after = data['after'];
      result$data['after'] = (l$after as String?);
    }
    if (data.containsKey('first')) {
      final l$first = data['first'];
      result$data['first'] = (l$first as int?);
    }
    return Variables$Query$BoardLists._(result$data);
  }

  Map<String, dynamic> _$data;

  String get idOrSlug => (_$data['idOrSlug'] as String);

  String? get after => (_$data['after'] as String?);

  int? get first => (_$data['first'] as int?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$idOrSlug = idOrSlug;
    result$data['idOrSlug'] = l$idOrSlug;
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

  CopyWith$Variables$Query$BoardLists<Variables$Query$BoardLists>
  get copyWith => CopyWith$Variables$Query$BoardLists(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$BoardLists ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$idOrSlug = idOrSlug;
    final lOther$idOrSlug = other.idOrSlug;
    if (l$idOrSlug != lOther$idOrSlug) {
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
    final l$idOrSlug = idOrSlug;
    final l$after = after;
    final l$first = first;
    return Object.hashAll([
      l$idOrSlug,
      _$data.containsKey('after') ? l$after : const {},
      _$data.containsKey('first') ? l$first : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$BoardLists<TRes> {
  factory CopyWith$Variables$Query$BoardLists(
    Variables$Query$BoardLists instance,
    TRes Function(Variables$Query$BoardLists) then,
  ) = _CopyWithImpl$Variables$Query$BoardLists;

  factory CopyWith$Variables$Query$BoardLists.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$BoardLists;

  TRes call({String? idOrSlug, String? after, int? first});
}

class _CopyWithImpl$Variables$Query$BoardLists<TRes>
    implements CopyWith$Variables$Query$BoardLists<TRes> {
  _CopyWithImpl$Variables$Query$BoardLists(this._instance, this._then);

  final Variables$Query$BoardLists _instance;

  final TRes Function(Variables$Query$BoardLists) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? idOrSlug = _undefined,
    Object? after = _undefined,
    Object? first = _undefined,
  }) => _then(
    Variables$Query$BoardLists._({
      ..._instance._$data,
      if (idOrSlug != _undefined && idOrSlug != null)
        'idOrSlug': (idOrSlug as String),
      if (after != _undefined) 'after': (after as String?),
      if (first != _undefined) 'first': (first as int?),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$BoardLists<TRes>
    implements CopyWith$Variables$Query$BoardLists<TRes> {
  _CopyWithStubImpl$Variables$Query$BoardLists(this._res);

  TRes _res;

  call({String? idOrSlug, String? after, int? first}) => _res;
}

class Query$BoardLists {
  Query$BoardLists({this.board, this.$__typename = 'QueryRoot'});

  factory Query$BoardLists.fromJson(Map<String, dynamic> json) {
    final l$board = json['board'];
    final l$$__typename = json['__typename'];
    return Query$BoardLists(
      board: l$board == null
          ? null
          : Query$BoardLists$board.fromJson((l$board as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$BoardLists$board? board;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$board = board;
    _resultData['board'] = l$board?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$board = board;
    final l$$__typename = $__typename;
    return Object.hashAll([l$board, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$BoardLists || runtimeType != other.runtimeType) {
      return false;
    }
    final l$board = board;
    final lOther$board = other.board;
    if (l$board != lOther$board) {
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

extension UtilityExtension$Query$BoardLists on Query$BoardLists {
  CopyWith$Query$BoardLists<Query$BoardLists> get copyWith =>
      CopyWith$Query$BoardLists(this, (i) => i);
}

abstract class CopyWith$Query$BoardLists<TRes> {
  factory CopyWith$Query$BoardLists(
    Query$BoardLists instance,
    TRes Function(Query$BoardLists) then,
  ) = _CopyWithImpl$Query$BoardLists;

  factory CopyWith$Query$BoardLists.stub(TRes res) =
      _CopyWithStubImpl$Query$BoardLists;

  TRes call({Query$BoardLists$board? board, String? $__typename});
  CopyWith$Query$BoardLists$board<TRes> get board;
}

class _CopyWithImpl$Query$BoardLists<TRes>
    implements CopyWith$Query$BoardLists<TRes> {
  _CopyWithImpl$Query$BoardLists(this._instance, this._then);

  final Query$BoardLists _instance;

  final TRes Function(Query$BoardLists) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? board = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$BoardLists(
          board: board == _undefined
              ? _instance.board
              : (board as Query$BoardLists$board?),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );

  CopyWith$Query$BoardLists$board<TRes> get board {
    final local$board = _instance.board;
    return local$board == null
        ? CopyWith$Query$BoardLists$board.stub(_then(_instance))
        : CopyWith$Query$BoardLists$board(local$board, (e) => call(board: e));
  }
}

class _CopyWithStubImpl$Query$BoardLists<TRes>
    implements CopyWith$Query$BoardLists<TRes> {
  _CopyWithStubImpl$Query$BoardLists(this._res);

  TRes _res;

  call({Query$BoardLists$board? board, String? $__typename}) => _res;

  CopyWith$Query$BoardLists$board<TRes> get board =>
      CopyWith$Query$BoardLists$board.stub(_res);
}

const documentNodeQueryBoardLists = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'BoardLists'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'idOrSlug')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
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
            name: NameNode(value: 'board'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'idOrSlug'),
                value: VariableNode(name: NameNode(value: 'idOrSlug')),
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
                  name: NameNode(value: 'lists'),
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
                              name: NameNode(value: 'ListFragment'),
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
    fragmentDefinitionListFragment,
  ],
);
Query$BoardLists _parserFn$Query$BoardLists(Map<String, dynamic> data) =>
    Query$BoardLists.fromJson(data);
typedef OnQueryComplete$Query$BoardLists =
    FutureOr<void> Function(Map<String, dynamic>?, Query$BoardLists?);

class Options$Query$BoardLists extends graphql.QueryOptions<Query$BoardLists> {
  Options$Query$BoardLists({
    String? operationName,
    required Variables$Query$BoardLists variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$BoardLists? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$BoardLists? onComplete,
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
                 data == null ? null : _parserFn$Query$BoardLists(data),
               ),
         onError: onError,
         document: documentNodeQueryBoardLists,
         parserFn: _parserFn$Query$BoardLists,
       );

  final OnQueryComplete$Query$BoardLists? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$BoardLists
    extends graphql.WatchQueryOptions<Query$BoardLists> {
  WatchOptions$Query$BoardLists({
    String? operationName,
    required Variables$Query$BoardLists variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$BoardLists? typedOptimisticResult,
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
         document: documentNodeQueryBoardLists,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$BoardLists,
       );
}

class FetchMoreOptions$Query$BoardLists extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$BoardLists({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$BoardLists variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryBoardLists,
       );
}

extension ClientExtension$Query$BoardLists on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$BoardLists>> query$BoardLists(
    Options$Query$BoardLists options,
  ) async => await this.query(options);

  graphql.ObservableQuery<Query$BoardLists> watchQuery$BoardLists(
    WatchOptions$Query$BoardLists options,
  ) => this.watchQuery(options);

  void writeQuery$BoardLists({
    required Query$BoardLists data,
    required Variables$Query$BoardLists variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryBoardLists),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Query$BoardLists? readQuery$BoardLists({
    required Variables$Query$BoardLists variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryBoardLists),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$BoardLists.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$BoardLists> useQuery$BoardLists(
  Options$Query$BoardLists options,
) => graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$BoardLists> useWatchQuery$BoardLists(
  WatchOptions$Query$BoardLists options,
) => graphql_flutter.useWatchQuery(options);

class Query$BoardLists$Widget extends graphql_flutter.Query<Query$BoardLists> {
  Query$BoardLists$Widget({
    widgets.Key? key,
    required Options$Query$BoardLists options,
    required graphql_flutter.QueryBuilder<Query$BoardLists> builder,
  }) : super(key: key, options: options, builder: builder);
}

class Query$BoardLists$board {
  Query$BoardLists$board({
    required this.id,
    required this.lists,
    required this.createdAt,
    this.updatedAt,
    this.$__typename = 'BoardObject',
  });

  factory Query$BoardLists$board.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$lists = json['lists'];
    final l$createdAt = json['createdAt'];
    final l$updatedAt = json['updatedAt'];
    final l$$__typename = json['__typename'];
    return Query$BoardLists$board(
      id: (l$id as String),
      lists: Query$BoardLists$board$lists.fromJson(
        (l$lists as Map<String, dynamic>),
      ),
      createdAt: DateTime.parse((l$createdAt as String)),
      updatedAt: l$updatedAt == null
          ? null
          : DateTime.parse((l$updatedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Query$BoardLists$board$lists lists;

  final DateTime createdAt;

  final DateTime? updatedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$lists = lists;
    _resultData['lists'] = l$lists.toJson();
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
    final l$lists = lists;
    final l$createdAt = createdAt;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$lists,
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
    if (other is! Query$BoardLists$board || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$lists = lists;
    final lOther$lists = other.lists;
    if (l$lists != lOther$lists) {
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

extension UtilityExtension$Query$BoardLists$board on Query$BoardLists$board {
  CopyWith$Query$BoardLists$board<Query$BoardLists$board> get copyWith =>
      CopyWith$Query$BoardLists$board(this, (i) => i);
}

abstract class CopyWith$Query$BoardLists$board<TRes> {
  factory CopyWith$Query$BoardLists$board(
    Query$BoardLists$board instance,
    TRes Function(Query$BoardLists$board) then,
  ) = _CopyWithImpl$Query$BoardLists$board;

  factory CopyWith$Query$BoardLists$board.stub(TRes res) =
      _CopyWithStubImpl$Query$BoardLists$board;

  TRes call({
    String? id,
    Query$BoardLists$board$lists? lists,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? $__typename,
  });
  CopyWith$Query$BoardLists$board$lists<TRes> get lists;
}

class _CopyWithImpl$Query$BoardLists$board<TRes>
    implements CopyWith$Query$BoardLists$board<TRes> {
  _CopyWithImpl$Query$BoardLists$board(this._instance, this._then);

  final Query$BoardLists$board _instance;

  final TRes Function(Query$BoardLists$board) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? lists = _undefined,
    Object? createdAt = _undefined,
    Object? updatedAt = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$BoardLists$board(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      lists: lists == _undefined || lists == null
          ? _instance.lists
          : (lists as Query$BoardLists$board$lists),
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

  CopyWith$Query$BoardLists$board$lists<TRes> get lists {
    final local$lists = _instance.lists;
    return CopyWith$Query$BoardLists$board$lists(
      local$lists,
      (e) => call(lists: e),
    );
  }
}

class _CopyWithStubImpl$Query$BoardLists$board<TRes>
    implements CopyWith$Query$BoardLists$board<TRes> {
  _CopyWithStubImpl$Query$BoardLists$board(this._res);

  TRes _res;

  call({
    String? id,
    Query$BoardLists$board$lists? lists,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? $__typename,
  }) => _res;

  CopyWith$Query$BoardLists$board$lists<TRes> get lists =>
      CopyWith$Query$BoardLists$board$lists.stub(_res);
}

class Query$BoardLists$board$lists {
  Query$BoardLists$board$lists({
    required this.nodes,
    required this.pageInfo,
    this.$__typename = 'ListObjectConnection',
  });

  factory Query$BoardLists$board$lists.fromJson(Map<String, dynamic> json) {
    final l$nodes = json['nodes'];
    final l$pageInfo = json['pageInfo'];
    final l$$__typename = json['__typename'];
    return Query$BoardLists$board$lists(
      nodes: (l$nodes as List<dynamic>)
          .map(
            (e) => Fragment$ListFragment.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
      pageInfo: Query$BoardLists$board$lists$pageInfo.fromJson(
        (l$pageInfo as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$ListFragment> nodes;

  final Query$BoardLists$board$lists$pageInfo pageInfo;

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
    if (other is! Query$BoardLists$board$lists ||
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

extension UtilityExtension$Query$BoardLists$board$lists
    on Query$BoardLists$board$lists {
  CopyWith$Query$BoardLists$board$lists<Query$BoardLists$board$lists>
  get copyWith => CopyWith$Query$BoardLists$board$lists(this, (i) => i);
}

abstract class CopyWith$Query$BoardLists$board$lists<TRes> {
  factory CopyWith$Query$BoardLists$board$lists(
    Query$BoardLists$board$lists instance,
    TRes Function(Query$BoardLists$board$lists) then,
  ) = _CopyWithImpl$Query$BoardLists$board$lists;

  factory CopyWith$Query$BoardLists$board$lists.stub(TRes res) =
      _CopyWithStubImpl$Query$BoardLists$board$lists;

  TRes call({
    List<Fragment$ListFragment>? nodes,
    Query$BoardLists$board$lists$pageInfo? pageInfo,
    String? $__typename,
  });
  TRes nodes(
    Iterable<Fragment$ListFragment> Function(
      Iterable<CopyWith$Fragment$ListFragment<Fragment$ListFragment>>,
    )
    _fn,
  );
  CopyWith$Query$BoardLists$board$lists$pageInfo<TRes> get pageInfo;
}

class _CopyWithImpl$Query$BoardLists$board$lists<TRes>
    implements CopyWith$Query$BoardLists$board$lists<TRes> {
  _CopyWithImpl$Query$BoardLists$board$lists(this._instance, this._then);

  final Query$BoardLists$board$lists _instance;

  final TRes Function(Query$BoardLists$board$lists) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? nodes = _undefined,
    Object? pageInfo = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$BoardLists$board$lists(
      nodes: nodes == _undefined || nodes == null
          ? _instance.nodes
          : (nodes as List<Fragment$ListFragment>),
      pageInfo: pageInfo == _undefined || pageInfo == null
          ? _instance.pageInfo
          : (pageInfo as Query$BoardLists$board$lists$pageInfo),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  TRes nodes(
    Iterable<Fragment$ListFragment> Function(
      Iterable<CopyWith$Fragment$ListFragment<Fragment$ListFragment>>,
    )
    _fn,
  ) => call(
    nodes: _fn(
      _instance.nodes.map((e) => CopyWith$Fragment$ListFragment(e, (i) => i)),
    ).toList(),
  );

  CopyWith$Query$BoardLists$board$lists$pageInfo<TRes> get pageInfo {
    final local$pageInfo = _instance.pageInfo;
    return CopyWith$Query$BoardLists$board$lists$pageInfo(
      local$pageInfo,
      (e) => call(pageInfo: e),
    );
  }
}

class _CopyWithStubImpl$Query$BoardLists$board$lists<TRes>
    implements CopyWith$Query$BoardLists$board$lists<TRes> {
  _CopyWithStubImpl$Query$BoardLists$board$lists(this._res);

  TRes _res;

  call({
    List<Fragment$ListFragment>? nodes,
    Query$BoardLists$board$lists$pageInfo? pageInfo,
    String? $__typename,
  }) => _res;

  nodes(_fn) => _res;

  CopyWith$Query$BoardLists$board$lists$pageInfo<TRes> get pageInfo =>
      CopyWith$Query$BoardLists$board$lists$pageInfo.stub(_res);
}

class Query$BoardLists$board$lists$pageInfo {
  Query$BoardLists$board$lists$pageInfo({
    this.endCursor,
    this.$__typename = 'PageInfo',
  });

  factory Query$BoardLists$board$lists$pageInfo.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$endCursor = json['endCursor'];
    final l$$__typename = json['__typename'];
    return Query$BoardLists$board$lists$pageInfo(
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
    if (other is! Query$BoardLists$board$lists$pageInfo ||
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

extension UtilityExtension$Query$BoardLists$board$lists$pageInfo
    on Query$BoardLists$board$lists$pageInfo {
  CopyWith$Query$BoardLists$board$lists$pageInfo<
    Query$BoardLists$board$lists$pageInfo
  >
  get copyWith =>
      CopyWith$Query$BoardLists$board$lists$pageInfo(this, (i) => i);
}

abstract class CopyWith$Query$BoardLists$board$lists$pageInfo<TRes> {
  factory CopyWith$Query$BoardLists$board$lists$pageInfo(
    Query$BoardLists$board$lists$pageInfo instance,
    TRes Function(Query$BoardLists$board$lists$pageInfo) then,
  ) = _CopyWithImpl$Query$BoardLists$board$lists$pageInfo;

  factory CopyWith$Query$BoardLists$board$lists$pageInfo.stub(TRes res) =
      _CopyWithStubImpl$Query$BoardLists$board$lists$pageInfo;

  TRes call({String? endCursor, String? $__typename});
}

class _CopyWithImpl$Query$BoardLists$board$lists$pageInfo<TRes>
    implements CopyWith$Query$BoardLists$board$lists$pageInfo<TRes> {
  _CopyWithImpl$Query$BoardLists$board$lists$pageInfo(
    this._instance,
    this._then,
  );

  final Query$BoardLists$board$lists$pageInfo _instance;

  final TRes Function(Query$BoardLists$board$lists$pageInfo) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? endCursor = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$BoardLists$board$lists$pageInfo(
      endCursor: endCursor == _undefined
          ? _instance.endCursor
          : (endCursor as String?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$BoardLists$board$lists$pageInfo<TRes>
    implements CopyWith$Query$BoardLists$board$lists$pageInfo<TRes> {
  _CopyWithStubImpl$Query$BoardLists$board$lists$pageInfo(this._res);

  TRes _res;

  call({String? endCursor, String? $__typename}) => _res;
}
