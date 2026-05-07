import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$BoardFragment {
  Fragment$BoardFragment({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.isEditable,
    required this.createdAt,
    this.updatedAt,
    this.$__typename = 'BoardObject',
  });

  factory Fragment$BoardFragment.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$slug = json['slug'];
    final l$description = json['description'];
    final l$isEditable = json['isEditable'];
    final l$createdAt = json['createdAt'];
    final l$updatedAt = json['updatedAt'];
    final l$$__typename = json['__typename'];
    return Fragment$BoardFragment(
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
    return Object.hashAll([
      l$id,
      l$name,
      l$slug,
      l$description,
      l$isEditable,
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
    if (other is! Fragment$BoardFragment || runtimeType != other.runtimeType) {
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
    return true;
  }
}

extension UtilityExtension$Fragment$BoardFragment on Fragment$BoardFragment {
  CopyWith$Fragment$BoardFragment<Fragment$BoardFragment> get copyWith =>
      CopyWith$Fragment$BoardFragment(this, (i) => i);
}

abstract class CopyWith$Fragment$BoardFragment<TRes> {
  factory CopyWith$Fragment$BoardFragment(
    Fragment$BoardFragment instance,
    TRes Function(Fragment$BoardFragment) then,
  ) = _CopyWithImpl$Fragment$BoardFragment;

  factory CopyWith$Fragment$BoardFragment.stub(TRes res) =
      _CopyWithStubImpl$Fragment$BoardFragment;

  TRes call({
    String? id,
    String? name,
    String? slug,
    String? description,
    bool? isEditable,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$BoardFragment<TRes>
    implements CopyWith$Fragment$BoardFragment<TRes> {
  _CopyWithImpl$Fragment$BoardFragment(this._instance, this._then);

  final Fragment$BoardFragment _instance;

  final TRes Function(Fragment$BoardFragment) _then;

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
  }) => _then(
    Fragment$BoardFragment(
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
    ),
  );
}

class _CopyWithStubImpl$Fragment$BoardFragment<TRes>
    implements CopyWith$Fragment$BoardFragment<TRes> {
  _CopyWithStubImpl$Fragment$BoardFragment(this._res);

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
  }) => _res;
}

const fragmentDefinitionBoardFragment = FragmentDefinitionNode(
  name: NameNode(value: 'BoardFragment'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'BoardObject'), isNonNull: false),
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
        name: NameNode(value: 'name'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'slug'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'description'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'isEditable'),
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
const documentNodeFragmentBoardFragment = DocumentNode(
  definitions: [fragmentDefinitionBoardFragment],
);

extension ClientExtension$Fragment$BoardFragment on graphql.GraphQLClient {
  void writeFragment$BoardFragment({
    required Fragment$BoardFragment data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'BoardFragment',
        document: documentNodeFragmentBoardFragment,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$BoardFragment? readFragment$BoardFragment({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'BoardFragment',
          document: documentNodeFragmentBoardFragment,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$BoardFragment.fromJson(result);
  }
}
