import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// Catalog items a shopper bookmarked. There is no API for this, so items are
/// kept on device and scoped to the user and the store they were saved from.
@DataClassName('SavedItem')
class SavedItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// The signed-in user's id, or [AppDatabase.guestUserKey] when signed out.
  TextColumn get userKey => text()();
  TextColumn get storeOrigin => text()();
  TextColumn get productId => text()();
  TextColumn get name => text()();
  TextColumn get image => text().nullable()();
  TextColumn get category => text().nullable()();
  RealColumn get price => real().nullable()();
  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {userKey, storeOrigin, productId},
  ];
}

@DriftDatabase(tables: [SavedItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'wakover'));

  static const guestUserKey = 'guest';

  @override
  int get schemaVersion => 1;

  Stream<List<SavedItem>> watchSavedItems(String userKey, String storeOrigin) {
    return (select(savedItems)
          ..where(
            (t) =>
                t.userKey.equals(userKey) & t.storeOrigin.equals(storeOrigin),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.savedAt)]))
        .watch();
  }

  Future<SavedItem?> findSavedItem(
    String userKey,
    String storeOrigin,
    String productId,
  ) {
    return (select(savedItems)..where(
          (t) =>
              t.userKey.equals(userKey) &
              t.storeOrigin.equals(storeOrigin) &
              t.productId.equals(productId),
        ))
        .getSingleOrNull();
  }

  Future<void> saveItem(SavedItemsCompanion item) {
    return into(savedItems).insert(
      item,
      onConflict: DoUpdate(
        (_) => item,
        target: [
          savedItems.userKey,
          savedItems.storeOrigin,
          savedItems.productId,
        ],
      ),
    );
  }

  Future<void> removeSavedItem(
    String userKey,
    String storeOrigin,
    String productId,
  ) {
    return (delete(savedItems)..where(
          (t) =>
              t.userKey.equals(userKey) &
              t.storeOrigin.equals(storeOrigin) &
              t.productId.equals(productId),
        ))
        .go();
  }

  Future<void> clearSavedItems(String userKey, String storeOrigin) {
    return (delete(savedItems)..where(
          (t) => t.userKey.equals(userKey) & t.storeOrigin.equals(storeOrigin),
        ))
        .go();
  }
}
