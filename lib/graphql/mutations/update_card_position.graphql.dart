import '../fragments/card_fragment.graphql.dart';
import 'dart:async';
import 'package:flutter/widgets.dart' as widgets;
import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;
import 'package:graphql_flutter/graphql_flutter.dart' as graphql_flutter;

class Variables$Mutation$UpdateCardPosition {
  factory Variables$Mutation$UpdateCardPosition({
    required String id,
    required int position,
  }) => Variables$Mutation$UpdateCardPosition._({
    r'id': id,
    r'position': position,
  });

  Variables$Mutation$UpdateCardPosition._(this._$data);

  factory Variables$Mutation$UpdateCardPosition.fromJson(
    Map<String, dynamic> data,
  ) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    final l$position = data['position'];
    result$data['position'] = (l$position as int);
    return Variables$Mutation$UpdateCardPosition._(result$data);
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

  CopyWith$Variables$Mutation$UpdateCardPosition<
    Variables$Mutation$UpdateCardPosition
  >
  get copyWith =>
      CopyWith$Variables$Mutation$UpdateCardPosition(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$UpdateCardPosition ||
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

abstract class CopyWith$Variables$Mutation$UpdateCardPosition<TRes> {
  factory CopyWith$Variables$Mutation$UpdateCardPosition(
    Variables$Mutation$UpdateCardPosition instance,
    TRes Function(Variables$Mutation$UpdateCardPosition) then,
  ) = _CopyWithImpl$Variables$Mutation$UpdateCardPosition;

  factory CopyWith$Variables$Mutation$UpdateCardPosition.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$UpdateCardPosition;

  TRes call({String? id, int? position});
}

class _CopyWithImpl$Variables$Mutation$UpdateCardPosition<TRes>
    implements CopyWith$Variables$Mutation$UpdateCardPosition<TRes> {
  _CopyWithImpl$Variables$Mutation$UpdateCardPosition(
    this._instance,
    this._then,
  );

  final Variables$Mutation$UpdateCardPosition _instance;

  final TRes Function(Variables$Mutation$UpdateCardPosition) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined, Object? position = _undefined}) => _then(
    Variables$Mutation$UpdateCardPosition._({
      ..._instance._$data,
      if (id != _undefined && id != null) 'id': (id as String),
      if (position != _undefined && position != null)
        'position': (position as int),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$UpdateCardPosition<TRes>
    implements CopyWith$Variables$Mutation$UpdateCardPosition<TRes> {
  _CopyWithStubImpl$Variables$Mutation$UpdateCardPosition(this._res);

  TRes _res;

  call({String? id, int? position}) => _res;
}

class Mutation$UpdateCardPosition {
  Mutation$UpdateCardPosition({
    required this.updateCardPosition,
    this.$__typename = 'MutationRoot',
  });

  factory Mutation$UpdateCardPosition.fromJson(Map<String, dynamic> json) {
    final l$updateCardPosition = json['updateCardPosition'];
    final l$$__typename = json['__typename'];
    return Mutation$UpdateCardPosition(
      updateCardPosition: Fragment$CardFragment.fromJson(
        (l$updateCardPosition as Map<String, dynamic>),
      ),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$CardFragment updateCardPosition;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$updateCardPosition = updateCardPosition;
    _resultData['updateCardPosition'] = l$updateCardPosition.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$updateCardPosition = updateCardPosition;
    final l$$__typename = $__typename;
    return Object.hashAll([l$updateCardPosition, l$$__typename]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$UpdateCardPosition ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$updateCardPosition = updateCardPosition;
    final lOther$updateCardPosition = other.updateCardPosition;
    if (l$updateCardPosition != lOther$updateCardPosition) {
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

extension UtilityExtension$Mutation$UpdateCardPosition
    on Mutation$UpdateCardPosition {
  CopyWith$Mutation$UpdateCardPosition<Mutation$UpdateCardPosition>
  get copyWith => CopyWith$Mutation$UpdateCardPosition(this, (i) => i);
}

abstract class CopyWith$Mutation$UpdateCardPosition<TRes> {
  factory CopyWith$Mutation$UpdateCardPosition(
    Mutation$UpdateCardPosition instance,
    TRes Function(Mutation$UpdateCardPosition) then,
  ) = _CopyWithImpl$Mutation$UpdateCardPosition;

  factory CopyWith$Mutation$UpdateCardPosition.stub(TRes res) =
      _CopyWithStubImpl$Mutation$UpdateCardPosition;

  TRes call({Fragment$CardFragment? updateCardPosition, String? $__typename});
  CopyWith$Fragment$CardFragment<TRes> get updateCardPosition;
}

class _CopyWithImpl$Mutation$UpdateCardPosition<TRes>
    implements CopyWith$Mutation$UpdateCardPosition<TRes> {
  _CopyWithImpl$Mutation$UpdateCardPosition(this._instance, this._then);

  final Mutation$UpdateCardPosition _instance;

  final TRes Function(Mutation$UpdateCardPosition) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? updateCardPosition = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Mutation$UpdateCardPosition(
      updateCardPosition:
          updateCardPosition == _undefined || updateCardPosition == null
          ? _instance.updateCardPosition
          : (updateCardPosition as Fragment$CardFragment),
      $__typename: $__typename == _undefined || $__typename == null
          ? _instance.$__typename
          : ($__typename as String),
    ),
  );

  CopyWith$Fragment$CardFragment<TRes> get updateCardPosition {
    final local$updateCardPosition = _instance.updateCardPosition;
    return CopyWith$Fragment$CardFragment(
      local$updateCardPosition,
      (e) => call(updateCardPosition: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$UpdateCardPosition<TRes>
    implements CopyWith$Mutation$UpdateCardPosition<TRes> {
  _CopyWithStubImpl$Mutation$UpdateCardPosition(this._res);

  TRes _res;

  call({Fragment$CardFragment? updateCardPosition, String? $__typename}) =>
      _res;

  CopyWith$Fragment$CardFragment<TRes> get updateCardPosition =>
      CopyWith$Fragment$CardFragment.stub(_res);
}

const documentNodeMutationUpdateCardPosition = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateCardPosition'),
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
            name: NameNode(value: 'updateCardPosition'),
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
Mutation$UpdateCardPosition _parserFn$Mutation$UpdateCardPosition(
  Map<String, dynamic> data,
) => Mutation$UpdateCardPosition.fromJson(data);
typedef OnMutationCompleted$Mutation$UpdateCardPosition =
    FutureOr<void> Function(
      Map<String, dynamic>?,
      Mutation$UpdateCardPosition?,
    );

class Options$Mutation$UpdateCardPosition
    extends graphql.MutationOptions<Mutation$UpdateCardPosition> {
  Options$Mutation$UpdateCardPosition({
    String? operationName,
    required Variables$Mutation$UpdateCardPosition variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateCardPosition? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateCardPosition? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateCardPosition>? update,
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
                     : _parserFn$Mutation$UpdateCardPosition(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateCardPosition,
         parserFn: _parserFn$Mutation$UpdateCardPosition,
       );

  final OnMutationCompleted$Mutation$UpdateCardPosition? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$UpdateCardPosition
    extends graphql.WatchQueryOptions<Mutation$UpdateCardPosition> {
  WatchOptions$Mutation$UpdateCardPosition({
    String? operationName,
    required Variables$Mutation$UpdateCardPosition variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateCardPosition? typedOptimisticResult,
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
         document: documentNodeMutationUpdateCardPosition,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$UpdateCardPosition,
       );
}

extension ClientExtension$Mutation$UpdateCardPosition on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$UpdateCardPosition>>
  mutate$UpdateCardPosition(
    Options$Mutation$UpdateCardPosition options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<Mutation$UpdateCardPosition>
  watchMutation$UpdateCardPosition(
    WatchOptions$Mutation$UpdateCardPosition options,
  ) => this.watchMutation(options);
}

class Mutation$UpdateCardPosition$HookResult {
  Mutation$UpdateCardPosition$HookResult(this.runMutation, this.result);

  final RunMutation$Mutation$UpdateCardPosition runMutation;

  final graphql.QueryResult<Mutation$UpdateCardPosition> result;
}

Mutation$UpdateCardPosition$HookResult useMutation$UpdateCardPosition([
  WidgetOptions$Mutation$UpdateCardPosition? options,
]) {
  final result = graphql_flutter.useMutation(
    options ?? WidgetOptions$Mutation$UpdateCardPosition(),
  );
  return Mutation$UpdateCardPosition$HookResult(
    (variables, {optimisticResult, typedOptimisticResult}) =>
        result.runMutation(
          variables.toJson(),
          optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
        ),
    result.result,
  );
}

graphql.ObservableQuery<Mutation$UpdateCardPosition>
useWatchMutation$UpdateCardPosition(
  WatchOptions$Mutation$UpdateCardPosition options,
) => graphql_flutter.useWatchMutation(options);

class WidgetOptions$Mutation$UpdateCardPosition
    extends graphql.MutationOptions<Mutation$UpdateCardPosition> {
  WidgetOptions$Mutation$UpdateCardPosition({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$UpdateCardPosition? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$UpdateCardPosition? onCompleted,
    graphql.OnMutationUpdate<Mutation$UpdateCardPosition>? update,
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
                     : _parserFn$Mutation$UpdateCardPosition(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationUpdateCardPosition,
         parserFn: _parserFn$Mutation$UpdateCardPosition,
       );

  final OnMutationCompleted$Mutation$UpdateCardPosition? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

typedef RunMutation$Mutation$UpdateCardPosition =
    graphql.MultiSourceResult<Mutation$UpdateCardPosition> Function(
      Variables$Mutation$UpdateCardPosition, {
      Object? optimisticResult,
      Mutation$UpdateCardPosition? typedOptimisticResult,
    });
typedef Builder$Mutation$UpdateCardPosition =
    widgets.Widget Function(
      RunMutation$Mutation$UpdateCardPosition,
      graphql.QueryResult<Mutation$UpdateCardPosition>?,
    );

class Mutation$UpdateCardPosition$Widget
    extends graphql_flutter.Mutation<Mutation$UpdateCardPosition> {
  Mutation$UpdateCardPosition$Widget({
    widgets.Key? key,
    WidgetOptions$Mutation$UpdateCardPosition? options,
    required Builder$Mutation$UpdateCardPosition builder,
  }) : super(
         key: key,
         options: options ?? WidgetOptions$Mutation$UpdateCardPosition(),
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
