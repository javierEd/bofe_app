class Input$BoardParams {
  factory Input$BoardParams({
    required String name,
    required String slug,
    required String description,
    required Enum$BoardVisibility visibility,
  }) => Input$BoardParams._({
    r'name': name,
    r'slug': slug,
    r'description': description,
    r'visibility': visibility,
  });

  Input$BoardParams._(this._$data);

  factory Input$BoardParams.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$slug = data['slug'];
    result$data['slug'] = (l$slug as String);
    final l$description = data['description'];
    result$data['description'] = (l$description as String);
    final l$visibility = data['visibility'];
    result$data['visibility'] = fromJson$Enum$BoardVisibility(
      (l$visibility as String),
    );
    return Input$BoardParams._(result$data);
  }

  Map<String, dynamic> _$data;

  String get name => (_$data['name'] as String);

  String get slug => (_$data['slug'] as String);

  String get description => (_$data['description'] as String);

  Enum$BoardVisibility get visibility =>
      (_$data['visibility'] as Enum$BoardVisibility);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$name = name;
    result$data['name'] = l$name;
    final l$slug = slug;
    result$data['slug'] = l$slug;
    final l$description = description;
    result$data['description'] = l$description;
    final l$visibility = visibility;
    result$data['visibility'] = toJson$Enum$BoardVisibility(l$visibility);
    return result$data;
  }

  CopyWith$Input$BoardParams<Input$BoardParams> get copyWith =>
      CopyWith$Input$BoardParams(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$BoardParams || runtimeType != other.runtimeType) {
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
    final l$visibility = visibility;
    final lOther$visibility = other.visibility;
    if (l$visibility != lOther$visibility) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$slug = slug;
    final l$description = description;
    final l$visibility = visibility;
    return Object.hashAll([l$name, l$slug, l$description, l$visibility]);
  }
}

abstract class CopyWith$Input$BoardParams<TRes> {
  factory CopyWith$Input$BoardParams(
    Input$BoardParams instance,
    TRes Function(Input$BoardParams) then,
  ) = _CopyWithImpl$Input$BoardParams;

  factory CopyWith$Input$BoardParams.stub(TRes res) =
      _CopyWithStubImpl$Input$BoardParams;

  TRes call({
    String? name,
    String? slug,
    String? description,
    Enum$BoardVisibility? visibility,
  });
}

class _CopyWithImpl$Input$BoardParams<TRes>
    implements CopyWith$Input$BoardParams<TRes> {
  _CopyWithImpl$Input$BoardParams(this._instance, this._then);

  final Input$BoardParams _instance;

  final TRes Function(Input$BoardParams) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? name = _undefined,
    Object? slug = _undefined,
    Object? description = _undefined,
    Object? visibility = _undefined,
  }) => _then(
    Input$BoardParams._({
      ..._instance._$data,
      if (name != _undefined && name != null) 'name': (name as String),
      if (slug != _undefined && slug != null) 'slug': (slug as String),
      if (description != _undefined && description != null)
        'description': (description as String),
      if (visibility != _undefined && visibility != null)
        'visibility': (visibility as Enum$BoardVisibility),
    }),
  );
}

class _CopyWithStubImpl$Input$BoardParams<TRes>
    implements CopyWith$Input$BoardParams<TRes> {
  _CopyWithStubImpl$Input$BoardParams(this._res);

  TRes _res;

  call({
    String? name,
    String? slug,
    String? description,
    Enum$BoardVisibility? visibility,
  }) => _res;
}

class Input$ListParams {
  factory Input$ListParams({required String boardId, required String name}) =>
      Input$ListParams._({r'boardId': boardId, r'name': name});

  Input$ListParams._(this._$data);

  factory Input$ListParams.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$boardId = data['boardId'];
    result$data['boardId'] = (l$boardId as String);
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    return Input$ListParams._(result$data);
  }

  Map<String, dynamic> _$data;

  String get boardId => (_$data['boardId'] as String);

  String get name => (_$data['name'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$boardId = boardId;
    result$data['boardId'] = l$boardId;
    final l$name = name;
    result$data['name'] = l$name;
    return result$data;
  }

  CopyWith$Input$ListParams<Input$ListParams> get copyWith =>
      CopyWith$Input$ListParams(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$ListParams || runtimeType != other.runtimeType) {
      return false;
    }
    final l$boardId = boardId;
    final lOther$boardId = other.boardId;
    if (l$boardId != lOther$boardId) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$boardId = boardId;
    final l$name = name;
    return Object.hashAll([l$boardId, l$name]);
  }
}

abstract class CopyWith$Input$ListParams<TRes> {
  factory CopyWith$Input$ListParams(
    Input$ListParams instance,
    TRes Function(Input$ListParams) then,
  ) = _CopyWithImpl$Input$ListParams;

  factory CopyWith$Input$ListParams.stub(TRes res) =
      _CopyWithStubImpl$Input$ListParams;

  TRes call({String? boardId, String? name});
}

class _CopyWithImpl$Input$ListParams<TRes>
    implements CopyWith$Input$ListParams<TRes> {
  _CopyWithImpl$Input$ListParams(this._instance, this._then);

  final Input$ListParams _instance;

  final TRes Function(Input$ListParams) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? boardId = _undefined, Object? name = _undefined}) => _then(
    Input$ListParams._({
      ..._instance._$data,
      if (boardId != _undefined && boardId != null)
        'boardId': (boardId as String),
      if (name != _undefined && name != null) 'name': (name as String),
    }),
  );
}

class _CopyWithStubImpl$Input$ListParams<TRes>
    implements CopyWith$Input$ListParams<TRes> {
  _CopyWithStubImpl$Input$ListParams(this._res);

  TRes _res;

  call({String? boardId, String? name}) => _res;
}

enum Enum$BoardVisibility {
  PRIVATE,
  USERS,
  PUBLIC,
  $unknown;

  factory Enum$BoardVisibility.fromJson(String value) =>
      fromJson$Enum$BoardVisibility(value);

  String toJson() => toJson$Enum$BoardVisibility(this);
}

String toJson$Enum$BoardVisibility(Enum$BoardVisibility e) {
  switch (e) {
    case Enum$BoardVisibility.PRIVATE:
      return r'PRIVATE';
    case Enum$BoardVisibility.USERS:
      return r'USERS';
    case Enum$BoardVisibility.PUBLIC:
      return r'PUBLIC';
    case Enum$BoardVisibility.$unknown:
      return r'$unknown';
  }
}

Enum$BoardVisibility fromJson$Enum$BoardVisibility(String value) {
  switch (value) {
    case r'PRIVATE':
      return Enum$BoardVisibility.PRIVATE;
    case r'USERS':
      return Enum$BoardVisibility.USERS;
    case r'PUBLIC':
      return Enum$BoardVisibility.PUBLIC;
    default:
      return Enum$BoardVisibility.$unknown;
  }
}

enum Enum$__TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL,
  $unknown;

  factory Enum$__TypeKind.fromJson(String value) =>
      fromJson$Enum$__TypeKind(value);

  String toJson() => toJson$Enum$__TypeKind(this);
}

String toJson$Enum$__TypeKind(Enum$__TypeKind e) {
  switch (e) {
    case Enum$__TypeKind.SCALAR:
      return r'SCALAR';
    case Enum$__TypeKind.OBJECT:
      return r'OBJECT';
    case Enum$__TypeKind.INTERFACE:
      return r'INTERFACE';
    case Enum$__TypeKind.UNION:
      return r'UNION';
    case Enum$__TypeKind.ENUM:
      return r'ENUM';
    case Enum$__TypeKind.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__TypeKind.LIST:
      return r'LIST';
    case Enum$__TypeKind.NON_NULL:
      return r'NON_NULL';
    case Enum$__TypeKind.$unknown:
      return r'$unknown';
  }
}

Enum$__TypeKind fromJson$Enum$__TypeKind(String value) {
  switch (value) {
    case r'SCALAR':
      return Enum$__TypeKind.SCALAR;
    case r'OBJECT':
      return Enum$__TypeKind.OBJECT;
    case r'INTERFACE':
      return Enum$__TypeKind.INTERFACE;
    case r'UNION':
      return Enum$__TypeKind.UNION;
    case r'ENUM':
      return Enum$__TypeKind.ENUM;
    case r'INPUT_OBJECT':
      return Enum$__TypeKind.INPUT_OBJECT;
    case r'LIST':
      return Enum$__TypeKind.LIST;
    case r'NON_NULL':
      return Enum$__TypeKind.NON_NULL;
    default:
      return Enum$__TypeKind.$unknown;
  }
}

enum Enum$__DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
  $unknown;

  factory Enum$__DirectiveLocation.fromJson(String value) =>
      fromJson$Enum$__DirectiveLocation(value);

  String toJson() => toJson$Enum$__DirectiveLocation(this);
}

String toJson$Enum$__DirectiveLocation(Enum$__DirectiveLocation e) {
  switch (e) {
    case Enum$__DirectiveLocation.QUERY:
      return r'QUERY';
    case Enum$__DirectiveLocation.MUTATION:
      return r'MUTATION';
    case Enum$__DirectiveLocation.SUBSCRIPTION:
      return r'SUBSCRIPTION';
    case Enum$__DirectiveLocation.FIELD:
      return r'FIELD';
    case Enum$__DirectiveLocation.FRAGMENT_DEFINITION:
      return r'FRAGMENT_DEFINITION';
    case Enum$__DirectiveLocation.FRAGMENT_SPREAD:
      return r'FRAGMENT_SPREAD';
    case Enum$__DirectiveLocation.INLINE_FRAGMENT:
      return r'INLINE_FRAGMENT';
    case Enum$__DirectiveLocation.VARIABLE_DEFINITION:
      return r'VARIABLE_DEFINITION';
    case Enum$__DirectiveLocation.SCHEMA:
      return r'SCHEMA';
    case Enum$__DirectiveLocation.SCALAR:
      return r'SCALAR';
    case Enum$__DirectiveLocation.OBJECT:
      return r'OBJECT';
    case Enum$__DirectiveLocation.FIELD_DEFINITION:
      return r'FIELD_DEFINITION';
    case Enum$__DirectiveLocation.ARGUMENT_DEFINITION:
      return r'ARGUMENT_DEFINITION';
    case Enum$__DirectiveLocation.INTERFACE:
      return r'INTERFACE';
    case Enum$__DirectiveLocation.UNION:
      return r'UNION';
    case Enum$__DirectiveLocation.ENUM:
      return r'ENUM';
    case Enum$__DirectiveLocation.ENUM_VALUE:
      return r'ENUM_VALUE';
    case Enum$__DirectiveLocation.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION:
      return r'INPUT_FIELD_DEFINITION';
    case Enum$__DirectiveLocation.$unknown:
      return r'$unknown';
  }
}

Enum$__DirectiveLocation fromJson$Enum$__DirectiveLocation(String value) {
  switch (value) {
    case r'QUERY':
      return Enum$__DirectiveLocation.QUERY;
    case r'MUTATION':
      return Enum$__DirectiveLocation.MUTATION;
    case r'SUBSCRIPTION':
      return Enum$__DirectiveLocation.SUBSCRIPTION;
    case r'FIELD':
      return Enum$__DirectiveLocation.FIELD;
    case r'FRAGMENT_DEFINITION':
      return Enum$__DirectiveLocation.FRAGMENT_DEFINITION;
    case r'FRAGMENT_SPREAD':
      return Enum$__DirectiveLocation.FRAGMENT_SPREAD;
    case r'INLINE_FRAGMENT':
      return Enum$__DirectiveLocation.INLINE_FRAGMENT;
    case r'VARIABLE_DEFINITION':
      return Enum$__DirectiveLocation.VARIABLE_DEFINITION;
    case r'SCHEMA':
      return Enum$__DirectiveLocation.SCHEMA;
    case r'SCALAR':
      return Enum$__DirectiveLocation.SCALAR;
    case r'OBJECT':
      return Enum$__DirectiveLocation.OBJECT;
    case r'FIELD_DEFINITION':
      return Enum$__DirectiveLocation.FIELD_DEFINITION;
    case r'ARGUMENT_DEFINITION':
      return Enum$__DirectiveLocation.ARGUMENT_DEFINITION;
    case r'INTERFACE':
      return Enum$__DirectiveLocation.INTERFACE;
    case r'UNION':
      return Enum$__DirectiveLocation.UNION;
    case r'ENUM':
      return Enum$__DirectiveLocation.ENUM;
    case r'ENUM_VALUE':
      return Enum$__DirectiveLocation.ENUM_VALUE;
    case r'INPUT_OBJECT':
      return Enum$__DirectiveLocation.INPUT_OBJECT;
    case r'INPUT_FIELD_DEFINITION':
      return Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION;
    default:
      return Enum$__DirectiveLocation.$unknown;
  }
}

const possibleTypesMap = <String, Set<String>>{};
