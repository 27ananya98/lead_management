// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $LeadDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $LeadDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $LeadDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<LeadDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorLeadDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $LeadDatabaseBuilderContract databaseBuilder(String name) =>
      _$LeadDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $LeadDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$LeadDatabaseBuilder(null);
}

class _$LeadDatabaseBuilder implements $LeadDatabaseBuilderContract {
  _$LeadDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $LeadDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $LeadDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<LeadDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$LeadDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$LeadDatabase extends LeadDatabase {
  _$LeadDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  LeadDao? _leadDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `leads` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `phone` TEXT NOT NULL, `source` TEXT NOT NULL, `status` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  LeadDao get leadDao {
    return _leadDaoInstance ??= _$LeadDao(database, changeListener);
  }
}

class _$LeadDao extends LeadDao {
  _$LeadDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _leadInsertionAdapter = InsertionAdapter(
            database,
            'leads',
            (Lead item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'phone': item.phone,
                  'source': item.source,
                  'status': item.status
                }),
        _leadUpdateAdapter = UpdateAdapter(
            database,
            'leads',
            ['id'],
            (Lead item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'phone': item.phone,
                  'source': item.source,
                  'status': item.status
                }),
        _leadDeletionAdapter = DeletionAdapter(
            database,
            'leads',
            ['id'],
            (Lead item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'phone': item.phone,
                  'source': item.source,
                  'status': item.status
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Lead> _leadInsertionAdapter;

  final UpdateAdapter<Lead> _leadUpdateAdapter;

  final DeletionAdapter<Lead> _leadDeletionAdapter;

  @override
  Future<List<Lead>> getAllLeads() async {
    return _queryAdapter.queryList('SELECT * FROM leads',
        mapper: (Map<String, Object?> row) => Lead(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            phone: row['phone'] as String,
            source: row['source'] as String,
            status: row['status'] as String));
  }

  @override
  Future<List<Lead>> getLeadsByStatus(String status) async {
    return _queryAdapter.queryList('SELECT * FROM leads WHERE status = ?1',
        mapper: (Map<String, Object?> row) => Lead(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            phone: row['phone'] as String,
            source: row['source'] as String,
            status: row['status'] as String),
        arguments: [status]);
  }

  @override
  Future<List<Lead>> getLeadsBySource(String source) async {
    return _queryAdapter.queryList('SELECT * FROM leads WHERE source = ?1',
        mapper: (Map<String, Object?> row) => Lead(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            phone: row['phone'] as String,
            source: row['source'] as String,
            status: row['status'] as String),
        arguments: [source]);
  }

  @override
  Future<List<Lead>> getLeadsByStatusAndSource(
    String status,
    String source,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM leads WHERE status = ?1 AND source = ?2',
        mapper: (Map<String, Object?> row) => Lead(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            phone: row['phone'] as String,
            source: row['source'] as String,
            status: row['status'] as String),
        arguments: [status, source]);
  }

  @override
  Future<void> insertLead(Lead lead) async {
    await _leadInsertionAdapter.insert(lead, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateLead(Lead lead) async {
    await _leadUpdateAdapter.update(lead, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteLead(Lead lead) async {
    await _leadDeletionAdapter.delete(lead);
  }
}
