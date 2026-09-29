// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SavedItemsTable extends SavedItems
    with TableInfo<$SavedItemsTable, SavedItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userKeyMeta = const VerificationMeta(
    'userKey',
  );
  @override
  late final GeneratedColumn<String> userKey = GeneratedColumn<String>(
    'user_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _storeOriginMeta = const VerificationMeta(
    'storeOrigin',
  );
  @override
  late final GeneratedColumn<String> storeOrigin = GeneratedColumn<String>(
    'store_origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userKey,
    storeOrigin,
    productId,
    name,
    image,
    category,
    price,
    savedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_key')) {
      context.handle(
        _userKeyMeta,
        userKey.isAcceptableOrUnknown(data['user_key']!, _userKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_userKeyMeta);
    }
    if (data.containsKey('store_origin')) {
      context.handle(
        _storeOriginMeta,
        storeOrigin.isAcceptableOrUnknown(
          data['store_origin']!,
          _storeOriginMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_storeOriginMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {userKey, storeOrigin, productId},
  ];
  @override
  SavedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_key'],
      )!,
      storeOrigin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}store_origin'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      ),
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $SavedItemsTable createAlias(String alias) {
    return $SavedItemsTable(attachedDatabase, alias);
  }
}

class SavedItem extends DataClass implements Insertable<SavedItem> {
  final int id;

  /// The signed-in user's id, or [AppDatabase.guestUserKey] when signed out.
  final String userKey;
  final String storeOrigin;
  final String productId;
  final String name;
  final String? image;
  final String? category;
  final double? price;
  final DateTime savedAt;
  const SavedItem({
    required this.id,
    required this.userKey,
    required this.storeOrigin,
    required this.productId,
    required this.name,
    this.image,
    this.category,
    this.price,
    required this.savedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_key'] = Variable<String>(userKey);
    map['store_origin'] = Variable<String>(storeOrigin);
    map['product_id'] = Variable<String>(productId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  SavedItemsCompanion toCompanion(bool nullToAbsent) {
    return SavedItemsCompanion(
      id: Value(id),
      userKey: Value(userKey),
      storeOrigin: Value(storeOrigin),
      productId: Value(productId),
      name: Value(name),
      image: image == null && nullToAbsent
          ? const Value.absent()
          : Value(image),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      price: price == null && nullToAbsent
          ? const Value.absent()
          : Value(price),
      savedAt: Value(savedAt),
    );
  }

  factory SavedItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedItem(
      id: serializer.fromJson<int>(json['id']),
      userKey: serializer.fromJson<String>(json['userKey']),
      storeOrigin: serializer.fromJson<String>(json['storeOrigin']),
      productId: serializer.fromJson<String>(json['productId']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String?>(json['image']),
      category: serializer.fromJson<String?>(json['category']),
      price: serializer.fromJson<double?>(json['price']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userKey': serializer.toJson<String>(userKey),
      'storeOrigin': serializer.toJson<String>(storeOrigin),
      'productId': serializer.toJson<String>(productId),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String?>(image),
      'category': serializer.toJson<String?>(category),
      'price': serializer.toJson<double?>(price),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  SavedItem copyWith({
    int? id,
    String? userKey,
    String? storeOrigin,
    String? productId,
    String? name,
    Value<String?> image = const Value.absent(),
    Value<String?> category = const Value.absent(),
    Value<double?> price = const Value.absent(),
    DateTime? savedAt,
  }) => SavedItem(
    id: id ?? this.id,
    userKey: userKey ?? this.userKey,
    storeOrigin: storeOrigin ?? this.storeOrigin,
    productId: productId ?? this.productId,
    name: name ?? this.name,
    image: image.present ? image.value : this.image,
    category: category.present ? category.value : this.category,
    price: price.present ? price.value : this.price,
    savedAt: savedAt ?? this.savedAt,
  );
  SavedItem copyWithCompanion(SavedItemsCompanion data) {
    return SavedItem(
      id: data.id.present ? data.id.value : this.id,
      userKey: data.userKey.present ? data.userKey.value : this.userKey,
      storeOrigin: data.storeOrigin.present
          ? data.storeOrigin.value
          : this.storeOrigin,
      productId: data.productId.present ? data.productId.value : this.productId,
      name: data.name.present ? data.name.value : this.name,
      image: data.image.present ? data.image.value : this.image,
      category: data.category.present ? data.category.value : this.category,
      price: data.price.present ? data.price.value : this.price,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedItem(')
          ..write('id: $id, ')
          ..write('userKey: $userKey, ')
          ..write('storeOrigin: $storeOrigin, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userKey,
    storeOrigin,
    productId,
    name,
    image,
    category,
    price,
    savedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedItem &&
          other.id == this.id &&
          other.userKey == this.userKey &&
          other.storeOrigin == this.storeOrigin &&
          other.productId == this.productId &&
          other.name == this.name &&
          other.image == this.image &&
          other.category == this.category &&
          other.price == this.price &&
          other.savedAt == this.savedAt);
}

class SavedItemsCompanion extends UpdateCompanion<SavedItem> {
  final Value<int> id;
  final Value<String> userKey;
  final Value<String> storeOrigin;
  final Value<String> productId;
  final Value<String> name;
  final Value<String?> image;
  final Value<String?> category;
  final Value<double?> price;
  final Value<DateTime> savedAt;
  const SavedItemsCompanion({
    this.id = const Value.absent(),
    this.userKey = const Value.absent(),
    this.storeOrigin = const Value.absent(),
    this.productId = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.category = const Value.absent(),
    this.price = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  SavedItemsCompanion.insert({
    this.id = const Value.absent(),
    required String userKey,
    required String storeOrigin,
    required String productId,
    required String name,
    this.image = const Value.absent(),
    this.category = const Value.absent(),
    this.price = const Value.absent(),
    this.savedAt = const Value.absent(),
  }) : userKey = Value(userKey),
       storeOrigin = Value(storeOrigin),
       productId = Value(productId),
       name = Value(name);
  static Insertable<SavedItem> custom({
    Expression<int>? id,
    Expression<String>? userKey,
    Expression<String>? storeOrigin,
    Expression<String>? productId,
    Expression<String>? name,
    Expression<String>? image,
    Expression<String>? category,
    Expression<double>? price,
    Expression<DateTime>? savedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userKey != null) 'user_key': userKey,
      if (storeOrigin != null) 'store_origin': storeOrigin,
      if (productId != null) 'product_id': productId,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (category != null) 'category': category,
      if (price != null) 'price': price,
      if (savedAt != null) 'saved_at': savedAt,
    });
  }

  SavedItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? userKey,
    Value<String>? storeOrigin,
    Value<String>? productId,
    Value<String>? name,
    Value<String?>? image,
    Value<String?>? category,
    Value<double?>? price,
    Value<DateTime>? savedAt,
  }) {
    return SavedItemsCompanion(
      id: id ?? this.id,
      userKey: userKey ?? this.userKey,
      storeOrigin: storeOrigin ?? this.storeOrigin,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      image: image ?? this.image,
      category: category ?? this.category,
      price: price ?? this.price,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userKey.present) {
      map['user_key'] = Variable<String>(userKey.value);
    }
    if (storeOrigin.present) {
      map['store_origin'] = Variable<String>(storeOrigin.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedItemsCompanion(')
          ..write('id: $id, ')
          ..write('userKey: $userKey, ')
          ..write('storeOrigin: $storeOrigin, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SavedItemsTable savedItems = $SavedItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [savedItems];
}

typedef $$SavedItemsTableCreateCompanionBuilder =
    SavedItemsCompanion Function({
      Value<int> id,
      required String userKey,
      required String storeOrigin,
      required String productId,
      required String name,
      Value<String?> image,
      Value<String?> category,
      Value<double?> price,
      Value<DateTime> savedAt,
    });
typedef $$SavedItemsTableUpdateCompanionBuilder =
    SavedItemsCompanion Function({
      Value<int> id,
      Value<String> userKey,
      Value<String> storeOrigin,
      Value<String> productId,
      Value<String> name,
      Value<String?> image,
      Value<String?> category,
      Value<double?> price,
      Value<DateTime> savedAt,
    });

class $$SavedItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SavedItemsTable> {
  $$SavedItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userKey => $composableBuilder(
    column: $table.userKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storeOrigin => $composableBuilder(
    column: $table.storeOrigin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedItemsTable> {
  $$SavedItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userKey => $composableBuilder(
    column: $table.userKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storeOrigin => $composableBuilder(
    column: $table.storeOrigin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedItemsTable> {
  $$SavedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userKey =>
      $composableBuilder(column: $table.userKey, builder: (column) => column);

  GeneratedColumn<String> get storeOrigin => $composableBuilder(
    column: $table.storeOrigin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$SavedItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedItemsTable,
          SavedItem,
          $$SavedItemsTableFilterComposer,
          $$SavedItemsTableOrderingComposer,
          $$SavedItemsTableAnnotationComposer,
          $$SavedItemsTableCreateCompanionBuilder,
          $$SavedItemsTableUpdateCompanionBuilder,
          (
            SavedItem,
            BaseReferences<_$AppDatabase, $SavedItemsTable, SavedItem>,
          ),
          SavedItem,
          PrefetchHooks Function()
        > {
  $$SavedItemsTableTableManager(_$AppDatabase db, $SavedItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userKey = const Value.absent(),
                Value<String> storeOrigin = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<double?> price = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
              }) => SavedItemsCompanion(
                id: id,
                userKey: userKey,
                storeOrigin: storeOrigin,
                productId: productId,
                name: name,
                image: image,
                category: category,
                price: price,
                savedAt: savedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userKey,
                required String storeOrigin,
                required String productId,
                required String name,
                Value<String?> image = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<double?> price = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
              }) => SavedItemsCompanion.insert(
                id: id,
                userKey: userKey,
                storeOrigin: storeOrigin,
                productId: productId,
                name: name,
                image: image,
                category: category,
                price: price,
                savedAt: savedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SavedItemsTable, SavedItem>(table),
                  BaseReferences<_$AppDatabase, $SavedItemsTable, SavedItem>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedItemsTable,
      SavedItem,
      $$SavedItemsTableFilterComposer,
      $$SavedItemsTableOrderingComposer,
      $$SavedItemsTableAnnotationComposer,
      $$SavedItemsTableCreateCompanionBuilder,
      $$SavedItemsTableUpdateCompanionBuilder,
      (SavedItem, BaseReferences<_$AppDatabase, $SavedItemsTable, SavedItem>),
      SavedItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SavedItemsTableTableManager get savedItems =>
      $$SavedItemsTableTableManager(_db, _db.savedItems);
}
