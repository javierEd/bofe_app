import '../fragments/card_fragment.graphql.dart';
import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Mutation$UpdateCardList {
  factory Variables$Mutation$UpdateCardList({
    required String id,
    required String listId,
    required int position,
  }) => Variables$Mutation$UpdateCardList._({
    r'id': id,
    r'listId': listId,
    r'position': position,
  });

  Variables$Mutation$UpdateCardList._(this._$data);

  factory Variables$Mutation$UpdateCardList.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$listId = data['listId'];
    result$data['listId'] = (l$listId as String);
    final l$position = data['position'];
    result$data['position'] = (l$position as int);
    return Variables$Mutation$UpdateCardList._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String get listId => (_$data['listId'] as String);

  int get position => (_$data['position'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$listId = listId;
    result$data['listId'] = l$listId;
    final l$position = position;
    result$data['position'] = l$position;
    return result$data;
  }

  CopyWith$Variables$Mutation$UpdateCardList<Variables$Mutation$UpdateCardList>
  get copyWith => CopyWith$Variables$Mutation$UpdateCardList(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$UpdateCardList ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$listId = listId;
    final lOther$listId = other.listId;
    if (l$listId != lOther$listId) {
      return false;
    }
    final l$position = position;
    final lOther$position = other.position;
    if (l$position != lOther$position) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$listId = listId;
    final l$position = position;
    return Object.hashAll([l$id, l$listId, l$position]);
  }
}

abstract class CopyWith$Variables$Mutation$UpdateCardList<TRes> {
  factory CopyWith$Variables$Mutation$UpdateCardList(
    Variables$Mutation$UpdateCardList instance,
    TRes Function(Variables$Mutation$UpdateCardList) then,
  ) = _CopyWithImpl$Variables$Mutation$UpdateCardList;

  factory CopyWith$Variables$Mutation$UpdateCardList.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UpdateCardList;

  TRes call({String? id, String? listId, int? position});
}

class _CopyWithImpl$Variables$Mutation$UpdateCardList<TRes>
    implements CopyWith$Variables$Mutation$UpdateCardList<TRes> {
  _CopyWithImpl$Variables$Mutation$UpdateCardList(this._instance, this._then);

  final Variables$Mutation$UpdateCardList _instance;

  final TRes Function(Variables$Mutation$UpdateCardList) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? listId = _undefined,
    Object? position = _undefined,
  }) => _then(
    Variables$Mutation$UpdateCardList._({
      ..._instance._$data,
      if (id != _undefined && id != null) 'id': (id as String),
      if (listId != _undefined && listId != null) 'listId': (listId as String),
      if (position != _undefined && position != null)
        'position': (position as int),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$UpdateCardList<TRes>
    implements CopyWith$Variables$Mutation$UpdateCardList<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UpdateCardList(this._res);

  TRes _res;

  call({String? id, String? listId, int? position}) => _res;
}

class Mutation$UpdateCardList {
  Mutation$UpdateCardList({
    required this.updateCardList,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$UpdateCardList.fromJson(Map<String, dynamic> json) {
    final l$updateCardList = json['updateCardList'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateCardList(
      updateCardList: Fragment$CardFragment.fromJson(
        (l$updateCardList as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$CardFragment updateCardList;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateCardList = updateCardList;
    _resultData['updateCardList'] = l$updateCardList.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateCardList = updateCardList;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateCardList, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UpdateCardList || runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateCardList = updateCardList;
    final lOther$updateCardList = other.updateCardList;
    if (l$updateCardList != lOther$updateCardList) {
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

extension UtilityExtension$Mutation$UpdateCardList on Mutation$UpdateCardList {
  CopyWith$Mutation$UpdateCardList<Mutation$UpdateCardList> get copyWith =>
      CopyWith$Mutation$UpdateCardList(this, (i) => i);
}

abstract class CopyWith$Mutation$UpdateCardList<TRes> {
  factory CopyWith$Mutation$UpdateCardList(
    Mutation$UpdateCardList instance,
    TRes Function(Mutation$UpdateCardList) then,
  ) = _CopyWithImpl$Mutation$UpdateCardList;

  factory CopyWith$Mutation$UpdateCardList.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateCardList;

  TRes call({Fragment$CardFragment? updateCardList, String? $__typename});
  CopyWith$Fragment$CardFragment<TRes> get updateCardList;
}

class _CopyWithImpl$Mutation$UpdateCardList<TRes>
    implements CopyWith$Mutation$UpdateCardList<TRes> {
  _CopyWithImpl$Mutation$UpdateCardList(this._instance, this._then);

  final Mutation$UpdateCardList _instance;

  final TRes Function(Mutation$UpdateCardList) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? updateCardList = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$UpdateCardList(
      updateCardList: updateCardList == _undefined || updateCardList == null
          ? _instance.updateCardList
          : (updateCardList as Fragment$CardFragment),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$CardFragment<TRes> get updateCardList {
    final local$updateCardList = _instance.updateCardList;
    return CopyWith$Fragment$CardFragment(
      local$updateCardList,
      (e) => call(updateCardList: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$UpdateCardList<TRes>
    implements CopyWith$Mutation$UpdateCardList<TRes> {
  _CopyWithStubImpl$Mutation$UpdateCardList(this._res);

  TRes _res;

  call({Fragment$CardFragment? updateCardList, String? $__typename}) => _res;

  CopyWith$Fragment$CardFragment<TRes> get updateCardList =>
      CopyWith$Fragment$CardFragment.stub(_res);
}

const documentNodeMutationUpdateCardList = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateCardList'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'UUID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'listId')),
          type: NamedTypeNode(name: NameNode(value: 'UUID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'position')),
          type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'updateCardList'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
              ),
              ArgumentNode(
                name: NameNode(value: 'listId'),
                value: VariableNode(name: NameNode(value: 'listId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'position'),
                value: VariableNode(name: NameNode(value: 'position')),
              ),
            ],
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
Mutation$UpdateCardList _parserFn$Mutation$UpdateCardList(
  Map<String, dynamic> data,
) => Mutation$UpdateCardList.fromJson(data);
typedef OnMutationCompleted$Mutation$UpdateCardList =
    FutureOr<void> Function(Map<String, dynamic>?, Mutation$UpdateCardList?);

class Options$Mutation$UpdateCardList
    extends graphql.MutationOptions<Mutation$UpdateCardList> {
  Options$Mutation$UpdateCardList({
    String? operationName,
    required Variables$Mutation$UpdateCardList variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateCardList? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateCardList? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateCardList>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFn$Mutation$UpdateCardList(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateCardList,
         parserFn: _parserFn$Mutation$UpdateCardList,
       );

  final OnMutationCompleted$Mutation$UpdateCardList? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$UpdateCardList
    extends graphql.WatchQueryOptions<Mutation$UpdateCardList> {
  WatchOptions$Mutation$UpdateCardList({
    String? operationName,
    required Variables$Mutation$UpdateCardList variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateCardList? typedOptimisticResult,
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
         document: documentNodeMutationUpdateCardList,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$UpdateCardList,
       );
}

extension ClientExtension$Mutation$UpdateCardList on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UpdateCardList>> mutate$UpdateCardList(
    Options$Mutation$UpdateCardList options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<Mutation$UpdateCardList> watchMutation$UpdateCardList(
    WatchOptions$Mutation$UpdateCardList options,
  ) => this.watchMutation(options);
}

class Mutation$UpdateCardList$HookResult {
  Mutation$UpdateCardList$HookResult(this.runMutation, this.result);

  final RunMutation$Mutation$UpdateCardList runMutation;

  final graphql.QueryResult<Mutation$UpdateCardList> result;
}

Mutation$UpdateCardList$HookResult useMutation$UpdateCardList([
  WidgetOptions$Mutation$UpdateCardList? options,
]) {
  final result = graphql_flutter.useMutation(
    options ?? WidgetOptions$Mutation$UpdateCardList(),
  );
  return Mutation$UpdateCardList$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
          variables.toJson(),
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
        ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$UpdateCardList>
useWatchMutation$UpdateCardList(WatchOptions$Mutation$UpdateCardList options) =>
    graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$UpdateCardList
    extends graphql.MutationOptions<Mutation$UpdateCardList> {
  WidgetOptions$Mutation$UpdateCardList({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateCardList? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateCardList? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateCardList>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFn$Mutation$UpdateCardList(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateCardList,
         parserFn: _parserFn$Mutation$UpdateCardList,
       );

  final OnMutationCompleted$Mutation$UpdateCardList? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

typedef RunMutation$Mutation$UpdateCardList =
    graphql.MultiSourceResult<Mutation$UpdateCardList> Function(
      Variables$Mutation$UpdateCardList, {
      Object? optimisticResult,
      Mutation$UpdateCardList? typedOptimisticResult,
    });
typedef Builder$Mutation$UpdateCardList =
    widgets.Widget Function(
      RunMutation$Mutation$UpdateCardList,
      graphql.QueryResult<Mutation$UpdateCardList>?,
    );

class Mutation$UpdateCardList$Widget
    extends graphql_flutter.Mutation<Mutation$UpdateCardList> {
  Mutation$UpdateCardList$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$UpdateCardList? options,
    required Builder$Mutation$UpdateCardList builder,
  }) : super(
         key: key,
         options: options ?? WidgetOptions$Mutation$UpdateCardList(),
         builder: (run, result) => builder(
           (variables, {optimisticResult, typedOptimisticResult}) => run(
             variables.toJson(),
             optimisticResult:
                 optimisticResult ?? typedOptimisticResult?.toJson(),
           ),
           result,
         ),
       );
}
