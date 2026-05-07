import '../fragments/board_fragment.graphql.dart';
import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Query$Board {
  factory Variables$Query$Board({required String idOrSlug}) =>
      Variables$Query$Board._({r'idOrSlug': idOrSlug});

  Variables$Query$Board._(this._$data);

  factory Variables$Query$Board.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$idOrSlug = data['idOrSlug'];
    result$data['idOrSlug'] = (l$idOrSlug as String);
    return Variables$Query$Board._(result$data);
  }

  Map<String, dynamic> _$data;

  String get idOrSlug => (_$data['idOrSlug'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$idOrSlug = idOrSlug;
    result$data['idOrSlug'] = l$idOrSlug;
    return result$data;
  }

  CopyWith$Variables$Query$Board<Variables$Query$Board> get copyWith =>
      CopyWith$Variables$Query$Board(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$Board || runtimeType != other.runtimeType) {
      return false;
    }
    final l$idOrSlug = idOrSlug;
    final lOther$idOrSlug = other.idOrSlug;
    if (l$idOrSlug != lOther$idOrSlug) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$idOrSlug = idOrSlug;
    return Object.hashAll([l$idOrSlug]);
  }
}

abstract class CopyWith$Variables$Query$Board<TRes> {
  factory CopyWith$Variables$Query$Board(
    Variables$Query$Board instance,
    TRes Function(Variables$Query$Board) then,
  ) = _CopyWithImpl$Variables$Query$Board;

  factory CopyWith$Variables$Query$Board.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Board;

  TRes call({String? idOrSlug});
}

class _CopyWithImpl$Variables$Query$Board<TRes>
    implements CopyWith$Variables$Query$Board<TRes> {
  _CopyWithImpl$Variables$Query$Board(this._instance, this._then);

  final Variables$Query$Board _instance;

  final TRes Function(Variables$Query$Board) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? idOrSlug = _undefined}) => _then(
    Variables$Query$Board._({
      ..._instance._$data,
      if (idOrSlug != _undefined && idOrSlug != null)
        'idOrSlug': (idOrSlug as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$Board<TRes>
    implements CopyWith$Variables$Query$Board<TRes> {
  _CopyWithStubImpl$Variables$Query$Board(this._res);

  TRes _res;

  call({String? idOrSlug}) => _res;
}

class Query$Board {
  Query$Board({this.board, this.$__typename = 'QueryRoot'});

  factory Query$Board.fromJson(Map<String, dynamic> json) {
    final l$board = json['board'];
    final l$$__typename = json['__typename'];
    return Query$Board(
      board: l$board == null
          ? null
          : Query$Board$board.fromJson((l$board as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$Board$board? board;

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
    if (other is! Query$Board || runtimeType != other.runtimeType) {
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

extension UtilityExtension$Query$Board on Query$Board {
  CopyWith$Query$Board<Query$Board> get copyWith =>
      CopyWith$Query$Board(this, (i) => i);
}

abstract class CopyWith$Query$Board<TRes> {
  factory CopyWith$Query$Board(
    Query$Board instance,
    TRes Function(Query$Board) then,
  ) = _CopyWithImpl$Query$Board;

  factory CopyWith$Query$Board.stub(TRes res) = _CopyWithStubImpl$Query$Board;

  TRes call({Query$Board$board? board, String? $__typename});
  CopyWith$Query$Board$board<TRes> get board;
}

class _CopyWithImpl$Query$Board<TRes> implements CopyWith$Query$Board<TRes> {
  _CopyWithImpl$Query$Board(this._instance, this._then);

  final Query$Board _instance;

  final TRes Function(Query$Board) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? board = _undefined, Object? $__typename = _undefined}) =>
      _then(
        Query$Board(
          board: board == _undefined
              ? _instance.board
              : (board as Query$Board$board?),
          $__typename: $__typename == _undefined || $__typename == null
              ? _instance.$__typename
              : ($__typename as String),
        ),
      );

  CopyWith$Query$Board$board<TRes> get board {
    final local$board = _instance.board;
    return local$board == null
        ? CopyWith$Query$Board$board.stub(_then(_instance))
        : CopyWith$Query$Board$board(local$board, (e) => call(board: e));
  }
}

class _CopyWithStubImpl$Query$Board<TRes>
    implements CopyWith$Query$Board<TRes> {
  _CopyWithStubImpl$Query$Board(this._res);

  TRes _res;

  call({Query$Board$board? board, String? $__typename}) => _res;

  CopyWith$Query$Board$board<TRes> get board =>
      CopyWith$Query$Board$board.stub(_res);
}

const documentNodeQueryBoard = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Board'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'idOrSlug')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
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
                FragmentSpreadNode(
                  name: NameNode(value: 'BoardFragment'),
                  directives: [],
                ),
                FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
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
                        name: NameNode(value: 'identityUser'),
                        alias: null,
                        arguments: [],
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
                              name: NameNode(value: 'username'),
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
    fragmentDefinitionBoardFragment,
  ],
);
Query$Board _parserFn$Query$Board(Map<String, dynamic> data) =>
    Query$Board.fromJson(data);
typedef OnQueryComplete$Query$Board =
    FutureOr<void> Function(Map<String, dynamic>?, Query$Board?);

class Options$Query$Board extends graphql.QueryOptions<Query$Board> {
  Options$Query$Board({
    String? operationName,
    required Variables$Query$Board variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Board? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$Board? onComplete,
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
                 data == null ? null : _parserFn$Query$Board(data),
               ),
         onError: onError,
         document: documentNodeQueryBoard,
         parserFn: _parserFn$Query$Board,
       );

  final OnQueryComplete$Query$Board? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$Board extends graphql.WatchQueryOptions<Query$Board> {
  WatchOptions$Query$Board({
    String? operationName,
    required Variables$Query$Board variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Board? typedOptimisticResult,
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
         document: documentNodeQueryBoard,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$Board,
       );
}

class FetchMoreOptions$Query$Board extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$Board({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$Board variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryBoard,
       );
}

extension ClientExtension$Query$Board on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$Board>> query$Board(
    Options$Query$Board options,
  ) async => await this.query(options);

  graphql.ObservableQuery<Query$Board> watchQuery$Board(
    WatchOptions$Query$Board options,
  ) => this.watchQuery(options);

  void writeQuery$Board({
    required Query$Board data,
    required Variables$Query$Board variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryBoard),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Query$Board? readQuery$Board({
    required Variables$Query$Board variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryBoard),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$Board.fromJson(result);
  }
}

graphql_flutter.QueryHookResult<Query$Board> useQuery$Board(
  Options$Query$Board options,
) => graphql_flutter.useQuery(options);
graphql.ObservableQuery<Query$Board> useWatchQuery$Board(
  WatchOptions$Query$Board options,
) => graphql_flutter.useWatchQuery(options);

class Query$Board$Widget extends graphql_flutter.Query<Query$Board> {
  Query$Board$Widget({
    widgets.Key? key,
    required Options$Query$Board options,
    required graphql_flutter.QueryBuilder<Query$Board> builder,
  }) : super(key: key, options: options, builder: builder);
}

class Query$Board$board implements Fragment$BoardFragment {
  Query$Board$board({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.isEditable,
    required this.createdAt,
    this.updatedAt,
    this.$__typename = 'BoardObject',
    required this.user,
  });

  factory Query$Board$board.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$slug = json['slug'];
    final l$description = json['description'];
    final l$isEditable = json['isEditable'];
    final l$createdAt = json['createdAt'];
    final l$updatedAt = json['updatedAt'];
    final l$$__typename = json['__typename'];
    final l$user = json['user'];
    return Query$Board$board(
      id: (l$id as String),
      name: (l$name as String),
      slug: (l$slug as String),
      description: (l$description as String),
      isEditable: (l$isEditable as bool),
      createdAt: DateTime.parse((l$createdAt as String)),
      updatedAt: l$updatedAt == null
          ? null
          : DateTime.parse((l$updatedAt as String)),
      $__typename: (l$$__typename as String),
      user: Query$Board$board$user.fromJson((l$user as Map<String, dynamic>)),
    );
  }

  final String id;

  final String name;

  final String slug;

  final String description;

  final bool isEditable;

  final DateTime createdAt;

  final DateTime? updatedAt;

  final String $__typename;

  final Query$Board$board$user user;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$slug = slug;
    _resultData['slug'] = l$slug;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$isEditable = isEditable;
    _resultData['isEditable'] = l$isEditable;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = l$createdAt.toIso8601String();
    final l$updatedAt = updatedAt;
    _resultData['updatedAt'] = l$updatedAt?.toIso8601String();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    final l$user = user;
    _resultData['user'] = l$user.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$slug = slug;
    final l$description = description;
    final l$isEditable = isEditable;
    final l$createdAt = createdAt;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    final l$user = user;
    return Object.hashAll([
      l$id,
      l$name,
      l$slug,
      l$description,
      l$isEditable,
      l$createdAt,
      l$updatedAt,
      l$$__typename,
      l$user,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Board$board || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$slug = slug;
    final lOther$slug = other.slug;
    if (l$slug != lOther$slug) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$isEditable = isEditable;
    final lOther$isEditable = other.isEditable;
    if (l$isEditable != lOther$isEditable) {
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
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Board$board on Query$Board$board {
  CopyWith$Query$Board$board<Query$Board$board> get copyWith =>
      CopyWith$Query$Board$board(this, (i) => i);
}

abstract class CopyWith$Query$Board$board<TRes> {
  factory CopyWith$Query$Board$board(
    Query$Board$board instance,
    TRes Function(Query$Board$board) then,
  ) = _CopyWithImpl$Query$Board$board;

  factory CopyWith$Query$Board$board.stub(TRes res) =
      _CopyWithStubImpl$Query$Board$board;

  TRes call({
    String? id,
    String? name,
    String? slug,
    String? description,
    bool? isEditable,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? $__typename,
    Query$Board$board$user? user,
  });
  CopyWith$Query$Board$board$user<TRes> get user;
}

class _CopyWithImpl$Query$Board$board<TRes>
    implements CopyWith$Query$Board$board<TRes> {
  _CopyWithImpl$Query$Board$board(this._instance, this._then);

  final Query$Board$board _instance;

  final TRes Function(Query$Board$board) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? slug = _undefined,
    Object? description = _undefined,
    Object? isEditable = _undefined,
    Object? createdAt = _undefined,
    Object? updatedAt = _undefined,
    Object? $__typename = _undefined,
    Object? user = _undefined,
  }) => _then(
    Query$Board$board(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      name: name == _undefined || name == null
          ? _instance.name
          : (name as String),
      slug: slug == _undefined || slug == null
          ? _instance.slug
          : (slug as String),
      description: description == _undefined || description == null
          ? _instance.description
          : (description as String),
      isEditable: isEditable == _undefined || isEditable == null
          ? _instance.isEditable
          : (isEditable as bool),
      createdAt: createdAt == _undefined || createdAt == null
          ? _instance.createdAt
          : (createdAt as DateTime),
      updatedAt: updatedAt == _undefined
          ? _instance.updatedAt
          : (updatedAt as DateTime?),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
      user: user == _undefined || user == null
          ? _instance.user
          : (user as Query$Board$board$user),
    ),
  );

  CopyWith$Query$Board$board$user<TRes> get user {
    final local$user = _instance.user;
    return CopyWith$Query$Board$board$user(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Query$Board$board<TRes>
    implements CopyWith$Query$Board$board<TRes> {
  _CopyWithStubImpl$Query$Board$board(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? slug,
    String? description,
    bool? isEditable,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? $__typename,
    Query$Board$board$user? user,
  }) => _res;

  CopyWith$Query$Board$board$user<TRes> get user =>
      CopyWith$Query$Board$board$user.stub(_res);
}

class Query$Board$board$user {
  Query$Board$board$user({
    required this.id,
    required this.identityUser,
    this.$__typename = 'UserObject',
  });

  factory Query$Board$board$user.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$identityUser = json['identityUser'];
    final l$$__typename = json['__typename'];
    return Query$Board$board$user(
      id: (l$id as String),
      identityUser: Query$Board$board$user$identityUser.fromJson(
        (l$identityUser as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Query$Board$board$user$identityUser identityUser;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$identityUser = identityUser;
    _resultData['identityUser'] = l$identityUser.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$identityUser = identityUser;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$identityUser, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Board$board$user || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$identityUser = identityUser;
    final lOther$identityUser = other.identityUser;
    if (l$identityUser != lOther$identityUser) {
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

extension UtilityExtension$Query$Board$board$user on Query$Board$board$user {
  CopyWith$Query$Board$board$user<Query$Board$board$user> get copyWith =>
      CopyWith$Query$Board$board$user(this, (i) => i);
}

abstract class CopyWith$Query$Board$board$user<TRes> {
  factory CopyWith$Query$Board$board$user(
    Query$Board$board$user instance,
    TRes Function(Query$Board$board$user) then,
  ) = _CopyWithImpl$Query$Board$board$user;

  factory CopyWith$Query$Board$board$user.stub(TRes res) =
      _CopyWithStubImpl$Query$Board$board$user;

  TRes call({
    String? id,
    Query$Board$board$user$identityUser? identityUser,
    String? $__typename,
  });
  CopyWith$Query$Board$board$user$identityUser<TRes> get identityUser;
}

class _CopyWithImpl$Query$Board$board$user<TRes>
    implements CopyWith$Query$Board$board$user<TRes> {
  _CopyWithImpl$Query$Board$board$user(this._instance, this._then);

  final Query$Board$board$user _instance;

  final TRes Function(Query$Board$board$user) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? identityUser = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$Board$board$user(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      identityUser: identityUser == _undefined || identityUser == null
          ? _instance.identityUser
          : (identityUser as Query$Board$board$user$identityUser),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Query$Board$board$user$identityUser<TRes> get identityUser {
    final local$identityUser = _instance.identityUser;
    return CopyWith$Query$Board$board$user$identityUser(
      local$identityUser,
      (e) => call(identityUser: e),
    );
  }
}

class _CopyWithStubImpl$Query$Board$board$user<TRes>
    implements CopyWith$Query$Board$board$user<TRes> {
  _CopyWithStubImpl$Query$Board$board$user(this._res);

  TRes _res;

  call({
    String? id,
    Query$Board$board$user$identityUser? identityUser,
    String? $__typename,
  }) => _res;

  CopyWith$Query$Board$board$user$identityUser<TRes> get identityUser =>
      CopyWith$Query$Board$board$user$identityUser.stub(_res);
}

class Query$Board$board$user$identityUser {
  Query$Board$board$user$identityUser({
    required this.id,
    required this.username,
    this.$__typename = 'IdentityUserObject',
  });

  factory Query$Board$board$user$identityUser.fromJson(
    Map<String, dynamic> json,
  ) {
    final l$id = json['id'];
    final l$username = json['username'];
    final l$$__typename = json['__typename'];
    return Query$Board$board$user$identityUser(
      id: (l$id as String),
      username: (l$username as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String username;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$username = username;
    _resultData['username'] = l$username;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$username = username;
    final l$$__typename = $__typename;
    return Object.hashAll([l$id, l$username, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Board$board$user$identityUser ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$username = username;
    final lOther$username = other.username;
    if (l$username != lOther$username) {
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

extension UtilityExtension$Query$Board$board$user$identityUser
    on Query$Board$board$user$identityUser {
  CopyWith$Query$Board$board$user$identityUser<
    Query$Board$board$user$identityUser
  >
  get copyWith => CopyWith$Query$Board$board$user$identityUser(this, (i) => i);
}

abstract class CopyWith$Query$Board$board$user$identityUser<TRes> {
  factory CopyWith$Query$Board$board$user$identityUser(
    Query$Board$board$user$identityUser instance,
    TRes Function(Query$Board$board$user$identityUser) then,
  ) = _CopyWithImpl$Query$Board$board$user$identityUser;

  factory CopyWith$Query$Board$board$user$identityUser.stub(TRes res) =
      _CopyWithStubImpl$Query$Board$board$user$identityUser;

  TRes call({String? id, String? username, String? $__typename});
}

class _CopyWithImpl$Query$Board$board$user$identityUser<TRes>
    implements CopyWith$Query$Board$board$user$identityUser<TRes> {
  _CopyWithImpl$Query$Board$board$user$identityUser(this._instance, this._then);

  final Query$Board$board$user$identityUser _instance;

  final TRes Function(Query$Board$board$user$identityUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? username = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Query$Board$board$user$identityUser(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      username: username == _undefined || username == null
          ? _instance.username
          : (username as String),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );
}

class _CopyWithStubImpl$Query$Board$board$user$identityUser<TRes>
    implements CopyWith$Query$Board$board$user$identityUser<TRes> {
  _CopyWithStubImpl$Query$Board$board$user$identityUser(this._res);

  TRes _res;

  call({String? id, String? username, String? $__typename}) => _res;
}
