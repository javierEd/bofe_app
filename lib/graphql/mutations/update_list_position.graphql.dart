import '../fragments/list_fragment.graphql.dart';
import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Mutation$UpdateListPosition {
  factory Variables$Mutation$UpdateListPosition({
    required String id,
    required int position,
  }) => Variables$Mutation$UpdateListPosition._({
    r'id': id,
    r'position': position,
  });

  Variables$Mutation$UpdateListPosition._(this._$data);

  factory Variables$Mutation$UpdateListPosition.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$position = data['position'];
    result$data['position'] = (l$position as int);
    return Variables$Mutation$UpdateListPosition._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  int get position => (_$data['position'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    final l$position = position;
    result$data['position'] = l$position;
    return result$data;
  }

  CopyWith$Variables$Mutation$UpdateListPosition<
    Variables$Mutation$UpdateListPosition
  >
  get copyWith =>
      CopyWith$Variables$Mutation$UpdateListPosition(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$UpdateListPosition ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
    final l$position = position;
    return Object.hashAll([l$id, l$position]);
  }
}

abstract class CopyWith$Variables$Mutation$UpdateListPosition<TRes> {
  factory CopyWith$Variables$Mutation$UpdateListPosition(
    Variables$Mutation$UpdateListPosition instance,
    TRes Function(Variables$Mutation$UpdateListPosition) then,
  ) = _CopyWithImpl$Variables$Mutation$UpdateListPosition;

  factory CopyWith$Variables$Mutation$UpdateListPosition.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UpdateListPosition;

  TRes call({String? id, int? position});
}

class _CopyWithImpl$Variables$Mutation$UpdateListPosition<TRes>
    implements CopyWith$Variables$Mutation$UpdateListPosition<TRes> {
  _CopyWithImpl$Variables$Mutation$UpdateListPosition(
    this._instance,
    this._then,
  );

  final Variables$Mutation$UpdateListPosition _instance;

  final TRes Function(Variables$Mutation$UpdateListPosition) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined, Object? position = _undefined}) => _then(
    Variables$Mutation$UpdateListPosition._({
      ..._instance._$data,
      if (id != _undefined && id != null) 'id': (id as String),
      if (position != _undefined && position != null)
        'position': (position as int),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$UpdateListPosition<TRes>
    implements CopyWith$Variables$Mutation$UpdateListPosition<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UpdateListPosition(this._res);

  TRes _res;

  call({String? id, int? position}) => _res;
}

class Mutation$UpdateListPosition {
  Mutation$UpdateListPosition({
    required this.updateListPosition,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$UpdateListPosition.fromJson(Map<String, dynamic> json) {
    final l$updateListPosition = json['updateListPosition'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateListPosition(
      updateListPosition: Fragment$ListFragment.fromJson(
        (l$updateListPosition as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$ListFragment updateListPosition;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateListPosition = updateListPosition;
    _resultData['updateListPosition'] = l$updateListPosition.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateListPosition = updateListPosition;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateListPosition, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UpdateListPosition ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateListPosition = updateListPosition;
    final lOther$updateListPosition = other.updateListPosition;
    if (l$updateListPosition != lOther$updateListPosition) {
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

extension UtilityExtension$Mutation$UpdateListPosition
    on Mutation$UpdateListPosition {
  CopyWith$Mutation$UpdateListPosition<Mutation$UpdateListPosition>
  get copyWith => CopyWith$Mutation$UpdateListPosition(this, (i) => i);
}

abstract class CopyWith$Mutation$UpdateListPosition<TRes> {
  factory CopyWith$Mutation$UpdateListPosition(
    Mutation$UpdateListPosition instance,
    TRes Function(Mutation$UpdateListPosition) then,
  ) = _CopyWithImpl$Mutation$UpdateListPosition;

  factory CopyWith$Mutation$UpdateListPosition.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateListPosition;

  TRes call({Fragment$ListFragment? updateListPosition, String? $__typename});
  CopyWith$Fragment$ListFragment<TRes> get updateListPosition;
}

class _CopyWithImpl$Mutation$UpdateListPosition<TRes>
    implements CopyWith$Mutation$UpdateListPosition<TRes> {
  _CopyWithImpl$Mutation$UpdateListPosition(this._instance, this._then);

  final Mutation$UpdateListPosition _instance;

  final TRes Function(Mutation$UpdateListPosition) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? updateListPosition = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$UpdateListPosition(
      updateListPosition:
          updateListPosition == _undefined || updateListPosition == null
          ? _instance.updateListPosition
          : (updateListPosition as Fragment$ListFragment),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$ListFragment<TRes> get updateListPosition {
    final local$updateListPosition = _instance.updateListPosition;
    return CopyWith$Fragment$ListFragment(
      local$updateListPosition,
      (e) => call(updateListPosition: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$UpdateListPosition<TRes>
    implements CopyWith$Mutation$UpdateListPosition<TRes> {
  _CopyWithStubImpl$Mutation$UpdateListPosition(this._res);

  TRes _res;

  call({Fragment$ListFragment? updateListPosition, String? $__typename}) =>
      _res;

  CopyWith$Fragment$ListFragment<TRes> get updateListPosition =>
      CopyWith$Fragment$ListFragment.stub(_res);
}

const documentNodeMutationUpdateListPosition = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateListPosition'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
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
            name: NameNode(value: 'updateListPosition'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
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
Mutation$UpdateListPosition _parserFn$Mutation$UpdateListPosition(
  Map<String, dynamic> data,
) => Mutation$UpdateListPosition.fromJson(data);
typedef OnMutationCompleted$Mutation$UpdateListPosition =
    FutureOr<void> Function(
      Map<String, dynamic>?,
      Mutation$UpdateListPosition?,
    );

class Options$Mutation$UpdateListPosition
    extends graphql.MutationOptions<Mutation$UpdateListPosition> {
  Options$Mutation$UpdateListPosition({
    String? operationName,
    required Variables$Mutation$UpdateListPosition variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateListPosition? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateListPosition? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateListPosition>? update,
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
                 data == null
                     ? null
                     : _parserFn$Mutation$UpdateListPosition(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateListPosition,
         parserFn: _parserFn$Mutation$UpdateListPosition,
       );

  final OnMutationCompleted$Mutation$UpdateListPosition? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$UpdateListPosition
    extends graphql.WatchQueryOptions<Mutation$UpdateListPosition> {
  WatchOptions$Mutation$UpdateListPosition({
    String? operationName,
    required Variables$Mutation$UpdateListPosition variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateListPosition? typedOptimisticResult,
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
         document: documentNodeMutationUpdateListPosition,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$UpdateListPosition,
       );
}

extension ClientExtension$Mutation$UpdateListPosition on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UpdateListPosition>>
  mutate$UpdateListPosition(
    Options$Mutation$UpdateListPosition options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<Mutation$UpdateListPosition>
  watchMutation$UpdateListPosition(
    WatchOptions$Mutation$UpdateListPosition options,
  ) => this.watchMutation(options);
}

class Mutation$UpdateListPosition$HookResult {
  Mutation$UpdateListPosition$HookResult(this.runMutation, this.result);

  final RunMutation$Mutation$UpdateListPosition runMutation;

  final graphql.QueryResult<Mutation$UpdateListPosition> result;
}

Mutation$UpdateListPosition$HookResult useMutation$UpdateListPosition([
  WidgetOptions$Mutation$UpdateListPosition? options,
]) {
  final result = graphql_flutter.useMutation(
    options ?? WidgetOptions$Mutation$UpdateListPosition(),
  );
  return Mutation$UpdateListPosition$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
          variables.toJson(),
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
        ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$UpdateListPosition>
useWatchMutation$UpdateListPosition(
  WatchOptions$Mutation$UpdateListPosition options,
) => graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$UpdateListPosition
    extends graphql.MutationOptions<Mutation$UpdateListPosition> {
  WidgetOptions$Mutation$UpdateListPosition({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateListPosition? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateListPosition? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateListPosition>? update,
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
                 data == null
                     ? null
                     : _parserFn$Mutation$UpdateListPosition(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateListPosition,
         parserFn: _parserFn$Mutation$UpdateListPosition,
       );

  final OnMutationCompleted$Mutation$UpdateListPosition? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

typedef RunMutation$Mutation$UpdateListPosition =
    graphql.MultiSourceResult<Mutation$UpdateListPosition> Function(
      Variables$Mutation$UpdateListPosition, {
      Object? optimisticResult,
      Mutation$UpdateListPosition? typedOptimisticResult,
    });
typedef Builder$Mutation$UpdateListPosition =
    widgets.Widget Function(
      RunMutation$Mutation$UpdateListPosition,
      graphql.QueryResult<Mutation$UpdateListPosition>?,
    );

class Mutation$UpdateListPosition$Widget
    extends graphql_flutter.Mutation<Mutation$UpdateListPosition> {
  Mutation$UpdateListPosition$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$UpdateListPosition? options,
    required Builder$Mutation$UpdateListPosition builder,
  }) : super(
         key: key,
         options: options ?? WidgetOptions$Mutation$UpdateListPosition(),
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
