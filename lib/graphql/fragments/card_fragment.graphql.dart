import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$CardFragment {
  Fragment$CardFragment({
    required this.id,
    required this.content,
    required this.position,
    required this.createdAt,
    this.updatedAt,
    this.$__typename = 'CardObject',
  });

  factory Fragment$CardFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$content = json['content'];
    final l$position = json['position'];
    final l$createdAt = json['createdAt'];
    final l$updatedAt = json['updatedAt'];
    final l$$__typename = json['__typename'];
    return Fragment$CardFragment(
      id: (l$id as String),
      content: (l$content as String),
      position: (l$position as int),
      createdAt: DateTime.parse((l$createdAt as String)),
      updatedAt: l$updatedAt == null
          ? null
          : DateTime.parse((l$updatedAt as String)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String content;

  final int position;

  final DateTime createdAt;

  final DateTime? updatedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$content = content;
    _resultData['content'] = l$content;
    final l$position = position;
    _resultData['position'] = l$position;
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
    final l$content = content;
    final l$position = position;
    final l$createdAt = createdAt;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$content,
      l$position,
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
    if (other is! Fragment$CardFragment || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$content = content;
    final lOther$content = other.content;
    if (l$content != lOther$content) {
      return false;
    }
    final l$position = position;
    final lOther$position = other.position;
    if (l$position != lOther$position) {
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

extension UtilityExtension$Fragment$CardFragment on Fragment$CardFragment {
  CopyWith$Fragment$CardFragment<Fragment$CardFragment> get copyWith =>
      CopyWith$Fragment$CardFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$CardFragment<TRes> {
  factory CopyWith$Fragment$CardFragment(
    Fragment$CardFragment instance,
    TRes Function(Fragment$CardFragment) then,
  ) = _CopyWithImpl$Fragment$CardFragment;

  factory CopyWith$Fragment$CardFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$CardFragment;

  TRes call({
    String? id,
    String? content,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$CardFragment<TRes>
    implements CopyWith$Fragment$CardFragment<TRes> {
  _CopyWithImpl$Fragment$CardFragment(this._instance, this._then);

  final Fragment$CardFragment _instance;

  final TRes Function(Fragment$CardFragment) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? content = _undefined,
    Object? position = _undefined,
    Object? createdAt = _undefined,
    Object? updatedAt = _undefined,
    Object? $__typename = _undefined,
  }) => _then(
    Fragment$CardFragment(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      content: content == _undefined || content == null
          ? _instance.content
          : (content as String),
      position: position == _undefined || position == null
          ? _instance.position
          : (position as int),
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
}

class _CopyWithStubImpl$Fragment$CardFragment<TRes>
    implements CopyWith$Fragment$CardFragment<TRes> {
  _CopyWithStubImpl$Fragment$CardFragment(this._res);

  TRes _res;

  call({
    String? id,
    String? content,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? $__typename,
  }) => _res;
}

const fragmentDefinitionCardFragment = FragmentDefinitionNode(
  name: NameNode(value: 'CardFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'CardObject'), isNonNull: false),
  ),
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
        name: NameNode(value: 'content'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'position'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
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
);
const documentNodeFragmentCardFragment = DocumentNode(
  definitions: [fragmentDefinitionCardFragment],
);

extension ClientExtension$Fragment$CardFragment on graphql.GraphQLClient {
  void writeFragment$CardFragment({
    required Fragment$CardFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'CardFragment',
        document: documentNodeFragmentCardFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$CardFragment? readFragment$CardFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'CardFragment',
          document: documentNodeFragmentCardFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$CardFragment.fromJson(result);
  }
}
