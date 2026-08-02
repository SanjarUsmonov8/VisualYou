// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HabitDefinitionsTable extends HabitDefinitions
    with TableInfo<$HabitDefinitionsTable, HabitDefinition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitDefinitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameKeyMeta = const VerificationMeta(
    'nameKey',
  );
  @override
  late final GeneratedColumn<String> nameKey = GeneratedColumn<String>(
    'name_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameKey,
    category,
    isActive,
    isFavorite,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitDefinition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_key')) {
      context.handle(
        _nameKeyMeta,
        nameKey.isAcceptableOrUnknown(data['name_key']!, _nameKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_nameKeyMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitDefinition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitDefinition(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_key'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $HabitDefinitionsTable createAlias(String alias) {
    return $HabitDefinitionsTable(attachedDatabase, alias);
  }
}

class HabitDefinition extends DataClass implements Insertable<HabitDefinition> {
  final String id;
  final String nameKey;
  final String category;
  final bool isActive;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  final DateTime? deletedAt;
  const HabitDefinition({
    required this.id,
    required this.nameKey,
    required this.category,
    required this.isActive,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_key'] = Variable<String>(nameKey);
    map['category'] = Variable<String>(category);
    map['is_active'] = Variable<bool>(isActive);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  HabitDefinitionsCompanion toCompanion(bool nullToAbsent) {
    return HabitDefinitionsCompanion(
      id: Value(id),
      nameKey: Value(nameKey),
      category: Value(category),
      isActive: Value(isActive),
      isFavorite: Value(isFavorite),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory HabitDefinition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitDefinition(
      id: serializer.fromJson<String>(json['id']),
      nameKey: serializer.fromJson<String>(json['nameKey']),
      category: serializer.fromJson<String>(json['category']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameKey': serializer.toJson<String>(nameKey),
      'category': serializer.toJson<String>(category),
      'isActive': serializer.toJson<bool>(isActive),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  HabitDefinition copyWith({
    String? id,
    String? nameKey,
    String? category,
    bool? isActive,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => HabitDefinition(
    id: id ?? this.id,
    nameKey: nameKey ?? this.nameKey,
    category: category ?? this.category,
    isActive: isActive ?? this.isActive,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  HabitDefinition copyWithCompanion(HabitDefinitionsCompanion data) {
    return HabitDefinition(
      id: data.id.present ? data.id.value : this.id,
      nameKey: data.nameKey.present ? data.nameKey.value : this.nameKey,
      category: data.category.present ? data.category.value : this.category,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitDefinition(')
          ..write('id: $id, ')
          ..write('nameKey: $nameKey, ')
          ..write('category: $category, ')
          ..write('isActive: $isActive, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameKey,
    category,
    isActive,
    isFavorite,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitDefinition &&
          other.id == this.id &&
          other.nameKey == this.nameKey &&
          other.category == this.category &&
          other.isActive == this.isActive &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class HabitDefinitionsCompanion extends UpdateCompanion<HabitDefinition> {
  final Value<String> id;
  final Value<String> nameKey;
  final Value<String> category;
  final Value<bool> isActive;
  final Value<bool> isFavorite;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const HabitDefinitionsCompanion({
    this.id = const Value.absent(),
    this.nameKey = const Value.absent(),
    this.category = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitDefinitionsCompanion.insert({
    required String id,
    required String nameKey,
    required String category,
    this.isActive = const Value.absent(),
    this.isFavorite = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameKey = Value(nameKey),
       category = Value(category),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<HabitDefinition> custom({
    Expression<String>? id,
    Expression<String>? nameKey,
    Expression<String>? category,
    Expression<bool>? isActive,
    Expression<bool>? isFavorite,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameKey != null) 'name_key': nameKey,
      if (category != null) 'category': category,
      if (isActive != null) 'is_active': isActive,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitDefinitionsCompanion copyWith({
    Value<String>? id,
    Value<String>? nameKey,
    Value<String>? category,
    Value<bool>? isActive,
    Value<bool>? isFavorite,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return HabitDefinitionsCompanion(
      id: id ?? this.id,
      nameKey: nameKey ?? this.nameKey,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameKey.present) {
      map['name_key'] = Variable<String>(nameKey.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitDefinitionsCompanion(')
          ..write('id: $id, ')
          ..write('nameKey: $nameKey, ')
          ..write('category: $category, ')
          ..write('isActive: $isActive, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitLogEntriesTable extends HabitLogEntries
    with TableInfo<$HabitLogEntriesTable, HabitLogEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitLogEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habit_definitions (id)',
    ),
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localDayMeta = const VerificationMeta(
    'localDay',
  );
  @override
  late final GeneratedColumn<DateTime> localDay = GeneratedColumn<DateTime>(
    'local_day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    loggedAt,
    localDay,
    quantity,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_log_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitLogEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('local_day')) {
      context.handle(
        _localDayMeta,
        localDay.isAcceptableOrUnknown(data['local_day']!, _localDayMeta),
      );
    } else if (isInserting) {
      context.missing(_localDayMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitLogEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitLogEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
      localDay: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}local_day'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $HabitLogEntriesTable createAlias(String alias) {
    return $HabitLogEntriesTable(attachedDatabase, alias);
  }
}

class HabitLogEntry extends DataClass implements Insertable<HabitLogEntry> {
  final String id;
  final String habitId;
  final DateTime loggedAt;
  final DateTime localDay;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  final DateTime? deletedAt;
  const HabitLogEntry({
    required this.id,
    required this.habitId,
    required this.loggedAt,
    required this.localDay,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['local_day'] = Variable<DateTime>(localDay);
    map['quantity'] = Variable<int>(quantity);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  HabitLogEntriesCompanion toCompanion(bool nullToAbsent) {
    return HabitLogEntriesCompanion(
      id: Value(id),
      habitId: Value(habitId),
      loggedAt: Value(loggedAt),
      localDay: Value(localDay),
      quantity: Value(quantity),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory HabitLogEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitLogEntry(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      localDay: serializer.fromJson<DateTime>(json['localDay']),
      quantity: serializer.fromJson<int>(json['quantity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'localDay': serializer.toJson<DateTime>(localDay),
      'quantity': serializer.toJson<int>(quantity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  HabitLogEntry copyWith({
    String? id,
    String? habitId,
    DateTime? loggedAt,
    DateTime? localDay,
    int? quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => HabitLogEntry(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    loggedAt: loggedAt ?? this.loggedAt,
    localDay: localDay ?? this.localDay,
    quantity: quantity ?? this.quantity,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  HabitLogEntry copyWithCompanion(HabitLogEntriesCompanion data) {
    return HabitLogEntry(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      localDay: data.localDay.present ? data.localDay.value : this.localDay,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogEntry(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('localDay: $localDay, ')
          ..write('quantity: $quantity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    habitId,
    loggedAt,
    localDay,
    quantity,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitLogEntry &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.loggedAt == this.loggedAt &&
          other.localDay == this.localDay &&
          other.quantity == this.quantity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class HabitLogEntriesCompanion extends UpdateCompanion<HabitLogEntry> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<DateTime> loggedAt;
  final Value<DateTime> localDay;
  final Value<int> quantity;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const HabitLogEntriesCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.localDay = const Value.absent(),
    this.quantity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitLogEntriesCompanion.insert({
    required String id,
    required String habitId,
    required DateTime loggedAt,
    required DateTime localDay,
    this.quantity = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       habitId = Value(habitId),
       loggedAt = Value(loggedAt),
       localDay = Value(localDay),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<HabitLogEntry> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<DateTime>? loggedAt,
    Expression<DateTime>? localDay,
    Expression<int>? quantity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (localDay != null) 'local_day': localDay,
      if (quantity != null) 'quantity': quantity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitLogEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? habitId,
    Value<DateTime>? loggedAt,
    Value<DateTime>? localDay,
    Value<int>? quantity,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return HabitLogEntriesCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      loggedAt: loggedAt ?? this.loggedAt,
      localDay: localDay ?? this.localDay,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (localDay.present) {
      map['local_day'] = Variable<DateTime>(localDay.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogEntriesCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('localDay: $localDay, ')
          ..write('quantity: $quantity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BodyPartStatesTable extends BodyPartStates
    with TableInfo<$BodyPartStatesTable, BodyPartState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyPartStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _partKeyMeta = const VerificationMeta(
    'partKey',
  );
  @override
  late final GeneratedColumn<String> partKey = GeneratedColumn<String>(
    'part_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    partKey,
    level,
    colorValue,
    updatedAt,
    syncStatus,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_part_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<BodyPartState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('part_key')) {
      context.handle(
        _partKeyMeta,
        partKey.isAcceptableOrUnknown(data['part_key']!, _partKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_partKeyMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {partKey};
  @override
  BodyPartState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BodyPartState(
      partKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_key'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
    );
  }

  @override
  $BodyPartStatesTable createAlias(String alias) {
    return $BodyPartStatesTable(attachedDatabase, alias);
  }
}

class BodyPartState extends DataClass implements Insertable<BodyPartState> {
  final String partKey;
  final int level;
  final int? colorValue;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  const BodyPartState({
    required this.partKey,
    required this.level,
    this.colorValue,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['part_key'] = Variable<String>(partKey);
    map['level'] = Variable<int>(level);
    if (!nullToAbsent || colorValue != null) {
      map['color_value'] = Variable<int>(colorValue);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  BodyPartStatesCompanion toCompanion(bool nullToAbsent) {
    return BodyPartStatesCompanion(
      partKey: Value(partKey),
      level: Value(level),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory BodyPartState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BodyPartState(
      partKey: serializer.fromJson<String>(json['partKey']),
      level: serializer.fromJson<int>(json['level']),
      colorValue: serializer.fromJson<int?>(json['colorValue']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'partKey': serializer.toJson<String>(partKey),
      'level': serializer.toJson<int>(level),
      'colorValue': serializer.toJson<int?>(colorValue),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  BodyPartState copyWith({
    String? partKey,
    int? level,
    Value<int?> colorValue = const Value.absent(),
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
  }) => BodyPartState(
    partKey: partKey ?? this.partKey,
    level: level ?? this.level,
    colorValue: colorValue.present ? colorValue.value : this.colorValue,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  BodyPartState copyWithCompanion(BodyPartStatesCompanion data) {
    return BodyPartState(
      partKey: data.partKey.present ? data.partKey.value : this.partKey,
      level: data.level.present ? data.level.value : this.level,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BodyPartState(')
          ..write('partKey: $partKey, ')
          ..write('level: $level, ')
          ..write('colorValue: $colorValue, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(partKey, level, colorValue, updatedAt, syncStatus, remoteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyPartState &&
          other.partKey == this.partKey &&
          other.level == this.level &&
          other.colorValue == this.colorValue &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId);
}

class BodyPartStatesCompanion extends UpdateCompanion<BodyPartState> {
  final Value<String> partKey;
  final Value<int> level;
  final Value<int?> colorValue;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> rowid;
  const BodyPartStatesCompanion({
    this.partKey = const Value.absent(),
    this.level = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BodyPartStatesCompanion.insert({
    required String partKey,
    this.level = const Value.absent(),
    this.colorValue = const Value.absent(),
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : partKey = Value(partKey),
       updatedAt = Value(updatedAt);
  static Insertable<BodyPartState> custom({
    Expression<String>? partKey,
    Expression<int>? level,
    Expression<int>? colorValue,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (partKey != null) 'part_key': partKey,
      if (level != null) 'level': level,
      if (colorValue != null) 'color_value': colorValue,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BodyPartStatesCompanion copyWith({
    Value<String>? partKey,
    Value<int>? level,
    Value<int?>? colorValue,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<int>? rowid,
  }) {
    return BodyPartStatesCompanion(
      partKey: partKey ?? this.partKey,
      level: level ?? this.level,
      colorValue: colorValue ?? this.colorValue,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (partKey.present) {
      map['part_key'] = Variable<String>(partKey.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BodyPartStatesCompanion(')
          ..write('partKey: $partKey, ')
          ..write('level: $level, ')
          ..write('colorValue: $colorValue, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GraphHistoryEntriesTable extends GraphHistoryEntries
    with TableInfo<$GraphHistoryEntriesTable, GraphHistoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GraphHistoryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metricKeyMeta = const VerificationMeta(
    'metricKey',
  );
  @override
  late final GeneratedColumn<String> metricKey = GeneratedColumn<String>(
    'metric_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habit_definitions (id)',
    ),
  );
  static const VerificationMeta _localDayMeta = const VerificationMeta(
    'localDay',
  );
  @override
  late final GeneratedColumn<DateTime> localDay = GeneratedColumn<DateTime>(
    'local_day',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    metricKey,
    habitId,
    localDay,
    value,
    recordedAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'graph_history_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<GraphHistoryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('metric_key')) {
      context.handle(
        _metricKeyMeta,
        metricKey.isAcceptableOrUnknown(data['metric_key']!, _metricKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_metricKeyMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    }
    if (data.containsKey('local_day')) {
      context.handle(
        _localDayMeta,
        localDay.isAcceptableOrUnknown(data['local_day']!, _localDayMeta),
      );
    } else if (isInserting) {
      context.missing(_localDayMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GraphHistoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GraphHistoryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      metricKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metric_key'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      ),
      localDay: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}local_day'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $GraphHistoryEntriesTable createAlias(String alias) {
    return $GraphHistoryEntriesTable(attachedDatabase, alias);
  }
}

class GraphHistoryEntry extends DataClass
    implements Insertable<GraphHistoryEntry> {
  final String id;
  final String metricKey;
  final String? habitId;
  final DateTime localDay;
  final double value;
  final DateTime recordedAt;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  final DateTime? deletedAt;
  const GraphHistoryEntry({
    required this.id,
    required this.metricKey,
    this.habitId,
    required this.localDay,
    required this.value,
    required this.recordedAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['metric_key'] = Variable<String>(metricKey);
    if (!nullToAbsent || habitId != null) {
      map['habit_id'] = Variable<String>(habitId);
    }
    map['local_day'] = Variable<DateTime>(localDay);
    map['value'] = Variable<double>(value);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  GraphHistoryEntriesCompanion toCompanion(bool nullToAbsent) {
    return GraphHistoryEntriesCompanion(
      id: Value(id),
      metricKey: Value(metricKey),
      habitId: habitId == null && nullToAbsent
          ? const Value.absent()
          : Value(habitId),
      localDay: Value(localDay),
      value: Value(value),
      recordedAt: Value(recordedAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory GraphHistoryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GraphHistoryEntry(
      id: serializer.fromJson<String>(json['id']),
      metricKey: serializer.fromJson<String>(json['metricKey']),
      habitId: serializer.fromJson<String?>(json['habitId']),
      localDay: serializer.fromJson<DateTime>(json['localDay']),
      value: serializer.fromJson<double>(json['value']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'metricKey': serializer.toJson<String>(metricKey),
      'habitId': serializer.toJson<String?>(habitId),
      'localDay': serializer.toJson<DateTime>(localDay),
      'value': serializer.toJson<double>(value),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  GraphHistoryEntry copyWith({
    String? id,
    String? metricKey,
    Value<String?> habitId = const Value.absent(),
    DateTime? localDay,
    double? value,
    DateTime? recordedAt,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => GraphHistoryEntry(
    id: id ?? this.id,
    metricKey: metricKey ?? this.metricKey,
    habitId: habitId.present ? habitId.value : this.habitId,
    localDay: localDay ?? this.localDay,
    value: value ?? this.value,
    recordedAt: recordedAt ?? this.recordedAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  GraphHistoryEntry copyWithCompanion(GraphHistoryEntriesCompanion data) {
    return GraphHistoryEntry(
      id: data.id.present ? data.id.value : this.id,
      metricKey: data.metricKey.present ? data.metricKey.value : this.metricKey,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      localDay: data.localDay.present ? data.localDay.value : this.localDay,
      value: data.value.present ? data.value.value : this.value,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GraphHistoryEntry(')
          ..write('id: $id, ')
          ..write('metricKey: $metricKey, ')
          ..write('habitId: $habitId, ')
          ..write('localDay: $localDay, ')
          ..write('value: $value, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    metricKey,
    habitId,
    localDay,
    value,
    recordedAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GraphHistoryEntry &&
          other.id == this.id &&
          other.metricKey == this.metricKey &&
          other.habitId == this.habitId &&
          other.localDay == this.localDay &&
          other.value == this.value &&
          other.recordedAt == this.recordedAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class GraphHistoryEntriesCompanion extends UpdateCompanion<GraphHistoryEntry> {
  final Value<String> id;
  final Value<String> metricKey;
  final Value<String?> habitId;
  final Value<DateTime> localDay;
  final Value<double> value;
  final Value<DateTime> recordedAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const GraphHistoryEntriesCompanion({
    this.id = const Value.absent(),
    this.metricKey = const Value.absent(),
    this.habitId = const Value.absent(),
    this.localDay = const Value.absent(),
    this.value = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GraphHistoryEntriesCompanion.insert({
    required String id,
    required String metricKey,
    this.habitId = const Value.absent(),
    required DateTime localDay,
    required double value,
    required DateTime recordedAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       metricKey = Value(metricKey),
       localDay = Value(localDay),
       value = Value(value),
       recordedAt = Value(recordedAt),
       updatedAt = Value(updatedAt);
  static Insertable<GraphHistoryEntry> custom({
    Expression<String>? id,
    Expression<String>? metricKey,
    Expression<String>? habitId,
    Expression<DateTime>? localDay,
    Expression<double>? value,
    Expression<DateTime>? recordedAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (metricKey != null) 'metric_key': metricKey,
      if (habitId != null) 'habit_id': habitId,
      if (localDay != null) 'local_day': localDay,
      if (value != null) 'value': value,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GraphHistoryEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? metricKey,
    Value<String?>? habitId,
    Value<DateTime>? localDay,
    Value<double>? value,
    Value<DateTime>? recordedAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return GraphHistoryEntriesCompanion(
      id: id ?? this.id,
      metricKey: metricKey ?? this.metricKey,
      habitId: habitId ?? this.habitId,
      localDay: localDay ?? this.localDay,
      value: value ?? this.value,
      recordedAt: recordedAt ?? this.recordedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (metricKey.present) {
      map['metric_key'] = Variable<String>(metricKey.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (localDay.present) {
      map['local_day'] = Variable<DateTime>(localDay.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GraphHistoryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('metricKey: $metricKey, ')
          ..write('habitId: $habitId, ')
          ..write('localDay: $localDay, ')
          ..write('value: $value, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomGraphRulesTable extends CustomGraphRules
    with TableInfo<$CustomGraphRulesTable, CustomGraphRuleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomGraphRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habit_definitions (id)',
    ),
  );
  static const VerificationMeta _completedPointsMeta = const VerificationMeta(
    'completedPoints',
  );
  @override
  late final GeneratedColumn<int> completedPoints = GeneratedColumn<int>(
    'completed_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _missedPointsMeta = const VerificationMeta(
    'missedPoints',
  );
  @override
  late final GeneratedColumn<int> missedPoints = GeneratedColumn<int>(
    'missed_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    slot,
    habitId,
    completedPoints,
    missedPoints,
    updatedAt,
    syncStatus,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_graph_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomGraphRuleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('completed_points')) {
      context.handle(
        _completedPointsMeta,
        completedPoints.isAcceptableOrUnknown(
          data['completed_points']!,
          _completedPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedPointsMeta);
    }
    if (data.containsKey('missed_points')) {
      context.handle(
        _missedPointsMeta,
        missedPoints.isAcceptableOrUnknown(
          data['missed_points']!,
          _missedPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_missedPointsMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slot};
  @override
  CustomGraphRuleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomGraphRuleRow(
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      completedPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_points'],
      )!,
      missedPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}missed_points'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
    );
  }

  @override
  $CustomGraphRulesTable createAlias(String alias) {
    return $CustomGraphRulesTable(attachedDatabase, alias);
  }
}

class CustomGraphRuleRow extends DataClass
    implements Insertable<CustomGraphRuleRow> {
  final int slot;
  final String habitId;
  final int completedPoints;
  final int missedPoints;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  const CustomGraphRuleRow({
    required this.slot,
    required this.habitId,
    required this.completedPoints,
    required this.missedPoints,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slot'] = Variable<int>(slot);
    map['habit_id'] = Variable<String>(habitId);
    map['completed_points'] = Variable<int>(completedPoints);
    map['missed_points'] = Variable<int>(missedPoints);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  CustomGraphRulesCompanion toCompanion(bool nullToAbsent) {
    return CustomGraphRulesCompanion(
      slot: Value(slot),
      habitId: Value(habitId),
      completedPoints: Value(completedPoints),
      missedPoints: Value(missedPoints),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory CustomGraphRuleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomGraphRuleRow(
      slot: serializer.fromJson<int>(json['slot']),
      habitId: serializer.fromJson<String>(json['habitId']),
      completedPoints: serializer.fromJson<int>(json['completedPoints']),
      missedPoints: serializer.fromJson<int>(json['missedPoints']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slot': serializer.toJson<int>(slot),
      'habitId': serializer.toJson<String>(habitId),
      'completedPoints': serializer.toJson<int>(completedPoints),
      'missedPoints': serializer.toJson<int>(missedPoints),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  CustomGraphRuleRow copyWith({
    int? slot,
    String? habitId,
    int? completedPoints,
    int? missedPoints,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
  }) => CustomGraphRuleRow(
    slot: slot ?? this.slot,
    habitId: habitId ?? this.habitId,
    completedPoints: completedPoints ?? this.completedPoints,
    missedPoints: missedPoints ?? this.missedPoints,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  CustomGraphRuleRow copyWithCompanion(CustomGraphRulesCompanion data) {
    return CustomGraphRuleRow(
      slot: data.slot.present ? data.slot.value : this.slot,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      completedPoints: data.completedPoints.present
          ? data.completedPoints.value
          : this.completedPoints,
      missedPoints: data.missedPoints.present
          ? data.missedPoints.value
          : this.missedPoints,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomGraphRuleRow(')
          ..write('slot: $slot, ')
          ..write('habitId: $habitId, ')
          ..write('completedPoints: $completedPoints, ')
          ..write('missedPoints: $missedPoints, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    slot,
    habitId,
    completedPoints,
    missedPoints,
    updatedAt,
    syncStatus,
    remoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomGraphRuleRow &&
          other.slot == this.slot &&
          other.habitId == this.habitId &&
          other.completedPoints == this.completedPoints &&
          other.missedPoints == this.missedPoints &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId);
}

class CustomGraphRulesCompanion extends UpdateCompanion<CustomGraphRuleRow> {
  final Value<int> slot;
  final Value<String> habitId;
  final Value<int> completedPoints;
  final Value<int> missedPoints;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  const CustomGraphRulesCompanion({
    this.slot = const Value.absent(),
    this.habitId = const Value.absent(),
    this.completedPoints = const Value.absent(),
    this.missedPoints = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
  });
  CustomGraphRulesCompanion.insert({
    this.slot = const Value.absent(),
    required String habitId,
    required int completedPoints,
    required int missedPoints,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
  }) : habitId = Value(habitId),
       completedPoints = Value(completedPoints),
       missedPoints = Value(missedPoints),
       updatedAt = Value(updatedAt);
  static Insertable<CustomGraphRuleRow> custom({
    Expression<int>? slot,
    Expression<String>? habitId,
    Expression<int>? completedPoints,
    Expression<int>? missedPoints,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
  }) {
    return RawValuesInsertable({
      if (slot != null) 'slot': slot,
      if (habitId != null) 'habit_id': habitId,
      if (completedPoints != null) 'completed_points': completedPoints,
      if (missedPoints != null) 'missed_points': missedPoints,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
    });
  }

  CustomGraphRulesCompanion copyWith({
    Value<int>? slot,
    Value<String>? habitId,
    Value<int>? completedPoints,
    Value<int>? missedPoints,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
  }) {
    return CustomGraphRulesCompanion(
      slot: slot ?? this.slot,
      habitId: habitId ?? this.habitId,
      completedPoints: completedPoints ?? this.completedPoints,
      missedPoints: missedPoints ?? this.missedPoints,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (completedPoints.present) {
      map['completed_points'] = Variable<int>(completedPoints.value);
    }
    if (missedPoints.present) {
      map['missed_points'] = Variable<int>(missedPoints.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomGraphRulesCompanion(')
          ..write('slot: $slot, ')
          ..write('habitId: $habitId, ')
          ..write('completedPoints: $completedPoints, ')
          ..write('missedPoints: $missedPoints, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }
}

class $SpecialHabitGraphsTable extends SpecialHabitGraphs
    with TableInfo<$SpecialHabitGraphsTable, SpecialHabitGraphRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpecialHabitGraphsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habit_definitions (id)',
    ),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    slot,
    habitId,
    updatedAt,
    syncStatus,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'special_habit_graphs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpecialHabitGraphRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slot};
  @override
  SpecialHabitGraphRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpecialHabitGraphRow(
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
    );
  }

  @override
  $SpecialHabitGraphsTable createAlias(String alias) {
    return $SpecialHabitGraphsTable(attachedDatabase, alias);
  }
}

class SpecialHabitGraphRow extends DataClass
    implements Insertable<SpecialHabitGraphRow> {
  final int slot;
  final String habitId;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  const SpecialHabitGraphRow({
    required this.slot,
    required this.habitId,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slot'] = Variable<int>(slot);
    map['habit_id'] = Variable<String>(habitId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  SpecialHabitGraphsCompanion toCompanion(bool nullToAbsent) {
    return SpecialHabitGraphsCompanion(
      slot: Value(slot),
      habitId: Value(habitId),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory SpecialHabitGraphRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpecialHabitGraphRow(
      slot: serializer.fromJson<int>(json['slot']),
      habitId: serializer.fromJson<String>(json['habitId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slot': serializer.toJson<int>(slot),
      'habitId': serializer.toJson<String>(habitId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  SpecialHabitGraphRow copyWith({
    int? slot,
    String? habitId,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
  }) => SpecialHabitGraphRow(
    slot: slot ?? this.slot,
    habitId: habitId ?? this.habitId,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  SpecialHabitGraphRow copyWithCompanion(SpecialHabitGraphsCompanion data) {
    return SpecialHabitGraphRow(
      slot: data.slot.present ? data.slot.value : this.slot,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpecialHabitGraphRow(')
          ..write('slot: $slot, ')
          ..write('habitId: $habitId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(slot, habitId, updatedAt, syncStatus, remoteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpecialHabitGraphRow &&
          other.slot == this.slot &&
          other.habitId == this.habitId &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId);
}

class SpecialHabitGraphsCompanion
    extends UpdateCompanion<SpecialHabitGraphRow> {
  final Value<int> slot;
  final Value<String> habitId;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  const SpecialHabitGraphsCompanion({
    this.slot = const Value.absent(),
    this.habitId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
  });
  SpecialHabitGraphsCompanion.insert({
    this.slot = const Value.absent(),
    required String habitId,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
  }) : habitId = Value(habitId),
       updatedAt = Value(updatedAt);
  static Insertable<SpecialHabitGraphRow> custom({
    Expression<int>? slot,
    Expression<String>? habitId,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
  }) {
    return RawValuesInsertable({
      if (slot != null) 'slot': slot,
      if (habitId != null) 'habit_id': habitId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
    });
  }

  SpecialHabitGraphsCompanion copyWith({
    Value<int>? slot,
    Value<String>? habitId,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
  }) {
    return SpecialHabitGraphsCompanion(
      slot: slot ?? this.slot,
      habitId: habitId ?? this.habitId,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpecialHabitGraphsCompanion(')
          ..write('slot: $slot, ')
          ..write('habitId: $habitId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }
}

class $ReductionPlansTable extends ReductionPlans
    with TableInfo<$ReductionPlansTable, ReductionPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReductionPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habit_definitions (id)',
    ),
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedOnMeta = const VerificationMeta(
    'startedOn',
  );
  @override
  late final GeneratedColumn<DateTime> startedOn = GeneratedColumn<DateTime>(
    'started_on',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    mode,
    startedOn,
    isActive,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reduction_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReductionPlanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('started_on')) {
      context.handle(
        _startedOnMeta,
        startedOn.isAcceptableOrUnknown(data['started_on']!, _startedOnMeta),
      );
    } else if (isInserting) {
      context.missing(_startedOnMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReductionPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReductionPlanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      startedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_on'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ReductionPlansTable createAlias(String alias) {
    return $ReductionPlansTable(attachedDatabase, alias);
  }
}

class ReductionPlanRow extends DataClass
    implements Insertable<ReductionPlanRow> {
  final String id;
  final String habitId;
  final String mode;
  final DateTime startedOn;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  final DateTime? deletedAt;
  const ReductionPlanRow({
    required this.id,
    required this.habitId,
    required this.mode,
    required this.startedOn,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['mode'] = Variable<String>(mode);
    map['started_on'] = Variable<DateTime>(startedOn);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ReductionPlansCompanion toCompanion(bool nullToAbsent) {
    return ReductionPlansCompanion(
      id: Value(id),
      habitId: Value(habitId),
      mode: Value(mode),
      startedOn: Value(startedOn),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ReductionPlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReductionPlanRow(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      mode: serializer.fromJson<String>(json['mode']),
      startedOn: serializer.fromJson<DateTime>(json['startedOn']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'mode': serializer.toJson<String>(mode),
      'startedOn': serializer.toJson<DateTime>(startedOn),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  ReductionPlanRow copyWith({
    String? id,
    String? habitId,
    String? mode,
    DateTime? startedOn,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => ReductionPlanRow(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    mode: mode ?? this.mode,
    startedOn: startedOn ?? this.startedOn,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  ReductionPlanRow copyWithCompanion(ReductionPlansCompanion data) {
    return ReductionPlanRow(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      mode: data.mode.present ? data.mode.value : this.mode,
      startedOn: data.startedOn.present ? data.startedOn.value : this.startedOn,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReductionPlanRow(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('mode: $mode, ')
          ..write('startedOn: $startedOn, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    habitId,
    mode,
    startedOn,
    isActive,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReductionPlanRow &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.mode == this.mode &&
          other.startedOn == this.startedOn &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class ReductionPlansCompanion extends UpdateCompanion<ReductionPlanRow> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<String> mode;
  final Value<DateTime> startedOn;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ReductionPlansCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.mode = const Value.absent(),
    this.startedOn = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReductionPlansCompanion.insert({
    required String id,
    required String habitId,
    required String mode,
    required DateTime startedOn,
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       habitId = Value(habitId),
       mode = Value(mode),
       startedOn = Value(startedOn),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ReductionPlanRow> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<String>? mode,
    Expression<DateTime>? startedOn,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (mode != null) 'mode': mode,
      if (startedOn != null) 'started_on': startedOn,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReductionPlansCompanion copyWith({
    Value<String>? id,
    Value<String>? habitId,
    Value<String>? mode,
    Value<DateTime>? startedOn,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ReductionPlansCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      mode: mode ?? this.mode,
      startedOn: startedOn ?? this.startedOn,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (startedOn.present) {
      map['started_on'] = Variable<DateTime>(startedOn.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReductionPlansCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('mode: $mode, ')
          ..write('startedOn: $startedOn, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitDefinitionsTable habitDefinitions = $HabitDefinitionsTable(
    this,
  );
  late final $HabitLogEntriesTable habitLogEntries = $HabitLogEntriesTable(
    this,
  );
  late final $BodyPartStatesTable bodyPartStates = $BodyPartStatesTable(this);
  late final $GraphHistoryEntriesTable graphHistoryEntries =
      $GraphHistoryEntriesTable(this);
  late final $CustomGraphRulesTable customGraphRules = $CustomGraphRulesTable(
    this,
  );
  late final $SpecialHabitGraphsTable specialHabitGraphs =
      $SpecialHabitGraphsTable(this);
  late final $ReductionPlansTable reductionPlans = $ReductionPlansTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    habitDefinitions,
    habitLogEntries,
    bodyPartStates,
    graphHistoryEntries,
    customGraphRules,
    specialHabitGraphs,
    reductionPlans,
  ];
}

typedef $$HabitDefinitionsTableCreateCompanionBuilder =
    HabitDefinitionsCompanion Function({
      required String id,
      required String nameKey,
      required String category,
      Value<bool> isActive,
      Value<bool> isFavorite,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$HabitDefinitionsTableUpdateCompanionBuilder =
    HabitDefinitionsCompanion Function({
      Value<String> id,
      Value<String> nameKey,
      Value<String> category,
      Value<bool> isActive,
      Value<bool> isFavorite,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$HabitDefinitionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $HabitDefinitionsTable, HabitDefinition> {
  $$HabitDefinitionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$HabitLogEntriesTable, List<HabitLogEntry>>
  _habitLogEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitLogEntries,
    aliasName: 'habit_definitions__id__habit_log_entries__habit_id',
  );

  $$HabitLogEntriesTableProcessedTableManager get habitLogEntriesRefs {
    final manager = $$HabitLogEntriesTableTableManager(
      $_db,
      $_db.habitLogEntries,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _habitLogEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GraphHistoryEntriesTable, List<GraphHistoryEntry>>
  _graphHistoryEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.graphHistoryEntries,
        aliasName: 'habit_definitions__id__graph_history_entries__habit_id',
      );

  $$GraphHistoryEntriesTableProcessedTableManager get graphHistoryEntriesRefs {
    final manager = $$GraphHistoryEntriesTableTableManager(
      $_db,
      $_db.graphHistoryEntries,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _graphHistoryEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CustomGraphRulesTable, List<CustomGraphRuleRow>>
  _customGraphRulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.customGraphRules,
    aliasName: 'habit_definitions__id__custom_graph_rules__habit_id',
  );

  $$CustomGraphRulesTableProcessedTableManager get customGraphRulesRefs {
    final manager = $$CustomGraphRulesTableTableManager(
      $_db,
      $_db.customGraphRules,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _customGraphRulesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SpecialHabitGraphsTable,
    List<SpecialHabitGraphRow>
  >
  _specialHabitGraphsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.specialHabitGraphs,
        aliasName: 'habit_definitions__id__special_habit_graphs__habit_id',
      );

  $$SpecialHabitGraphsTableProcessedTableManager get specialHabitGraphsRefs {
    final manager = $$SpecialHabitGraphsTableTableManager(
      $_db,
      $_db.specialHabitGraphs,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _specialHabitGraphsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReductionPlansTable, List<ReductionPlanRow>>
  _reductionPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reductionPlans,
    aliasName: 'habit_definitions__id__reduction_plans__habit_id',
  );

  $$ReductionPlansTableProcessedTableManager get reductionPlansRefs {
    final manager = $$ReductionPlansTableTableManager(
      $_db,
      $_db.reductionPlans,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reductionPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitDefinitionsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitDefinitionsTable> {
  $$HabitDefinitionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameKey => $composableBuilder(
    column: $table.nameKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitLogEntriesRefs(
    Expression<bool> Function($$HabitLogEntriesTableFilterComposer f) f,
  ) {
    final $$HabitLogEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogEntries,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogEntriesTableFilterComposer(
            $db: $db,
            $table: $db.habitLogEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> graphHistoryEntriesRefs(
    Expression<bool> Function($$GraphHistoryEntriesTableFilterComposer f) f,
  ) {
    final $$GraphHistoryEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.graphHistoryEntries,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GraphHistoryEntriesTableFilterComposer(
            $db: $db,
            $table: $db.graphHistoryEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customGraphRulesRefs(
    Expression<bool> Function($$CustomGraphRulesTableFilterComposer f) f,
  ) {
    final $$CustomGraphRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customGraphRules,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomGraphRulesTableFilterComposer(
            $db: $db,
            $table: $db.customGraphRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> specialHabitGraphsRefs(
    Expression<bool> Function($$SpecialHabitGraphsTableFilterComposer f) f,
  ) {
    final $$SpecialHabitGraphsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.specialHabitGraphs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpecialHabitGraphsTableFilterComposer(
            $db: $db,
            $table: $db.specialHabitGraphs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reductionPlansRefs(
    Expression<bool> Function($$ReductionPlansTableFilterComposer f) f,
  ) {
    final $$ReductionPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reductionPlans,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReductionPlansTableFilterComposer(
            $db: $db,
            $table: $db.reductionPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitDefinitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitDefinitionsTable> {
  $$HabitDefinitionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameKey => $composableBuilder(
    column: $table.nameKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitDefinitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitDefinitionsTable> {
  $$HabitDefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameKey =>
      $composableBuilder(column: $table.nameKey, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> habitLogEntriesRefs<T extends Object>(
    Expression<T> Function($$HabitLogEntriesTableAnnotationComposer a) f,
  ) {
    final $$HabitLogEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogEntries,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.habitLogEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> graphHistoryEntriesRefs<T extends Object>(
    Expression<T> Function($$GraphHistoryEntriesTableAnnotationComposer a) f,
  ) {
    final $$GraphHistoryEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.graphHistoryEntries,
          getReferencedColumn: (t) => t.habitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GraphHistoryEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.graphHistoryEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> customGraphRulesRefs<T extends Object>(
    Expression<T> Function($$CustomGraphRulesTableAnnotationComposer a) f,
  ) {
    final $$CustomGraphRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customGraphRules,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomGraphRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.customGraphRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> specialHabitGraphsRefs<T extends Object>(
    Expression<T> Function($$SpecialHabitGraphsTableAnnotationComposer a) f,
  ) {
    final $$SpecialHabitGraphsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.specialHabitGraphs,
          getReferencedColumn: (t) => t.habitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SpecialHabitGraphsTableAnnotationComposer(
                $db: $db,
                $table: $db.specialHabitGraphs,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> reductionPlansRefs<T extends Object>(
    Expression<T> Function($$ReductionPlansTableAnnotationComposer a) f,
  ) {
    final $$ReductionPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reductionPlans,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReductionPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.reductionPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitDefinitionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitDefinitionsTable,
          HabitDefinition,
          $$HabitDefinitionsTableFilterComposer,
          $$HabitDefinitionsTableOrderingComposer,
          $$HabitDefinitionsTableAnnotationComposer,
          $$HabitDefinitionsTableCreateCompanionBuilder,
          $$HabitDefinitionsTableUpdateCompanionBuilder,
          (HabitDefinition, $$HabitDefinitionsTableReferences),
          HabitDefinition,
          PrefetchHooks Function({
            bool habitLogEntriesRefs,
            bool graphHistoryEntriesRefs,
            bool customGraphRulesRefs,
            bool specialHabitGraphsRefs,
            bool reductionPlansRefs,
          })
        > {
  $$HabitDefinitionsTableTableManager(
    _$AppDatabase db,
    $HabitDefinitionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitDefinitionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitDefinitionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitDefinitionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameKey = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitDefinitionsCompanion(
                id: id,
                nameKey: nameKey,
                category: category,
                isActive: isActive,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameKey,
                required String category,
                Value<bool> isActive = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitDefinitionsCompanion.insert(
                id: id,
                nameKey: nameKey,
                category: category,
                isActive: isActive,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitDefinitionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                habitLogEntriesRefs = false,
                graphHistoryEntriesRefs = false,
                customGraphRulesRefs = false,
                specialHabitGraphsRefs = false,
                reductionPlansRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (habitLogEntriesRefs) db.habitLogEntries,
                    if (graphHistoryEntriesRefs) db.graphHistoryEntries,
                    if (customGraphRulesRefs) db.customGraphRules,
                    if (specialHabitGraphsRefs) db.specialHabitGraphs,
                    if (reductionPlansRefs) db.reductionPlans,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (habitLogEntriesRefs)
                        await $_getPrefetchedData<
                          HabitDefinition,
                          $HabitDefinitionsTable,
                          HabitLogEntry
                        >(
                          currentTable: table,
                          referencedTable: $$HabitDefinitionsTableReferences
                              ._habitLogEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitDefinitionsTableReferences(
                                db,
                                table,
                                p0,
                              ).habitLogEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (graphHistoryEntriesRefs)
                        await $_getPrefetchedData<
                          HabitDefinition,
                          $HabitDefinitionsTable,
                          GraphHistoryEntry
                        >(
                          currentTable: table,
                          referencedTable: $$HabitDefinitionsTableReferences
                              ._graphHistoryEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitDefinitionsTableReferences(
                                db,
                                table,
                                p0,
                              ).graphHistoryEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (customGraphRulesRefs)
                        await $_getPrefetchedData<
                          HabitDefinition,
                          $HabitDefinitionsTable,
                          CustomGraphRuleRow
                        >(
                          currentTable: table,
                          referencedTable: $$HabitDefinitionsTableReferences
                              ._customGraphRulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitDefinitionsTableReferences(
                                db,
                                table,
                                p0,
                              ).customGraphRulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (specialHabitGraphsRefs)
                        await $_getPrefetchedData<
                          HabitDefinition,
                          $HabitDefinitionsTable,
                          SpecialHabitGraphRow
                        >(
                          currentTable: table,
                          referencedTable: $$HabitDefinitionsTableReferences
                              ._specialHabitGraphsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitDefinitionsTableReferences(
                                db,
                                table,
                                p0,
                              ).specialHabitGraphsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reductionPlansRefs)
                        await $_getPrefetchedData<
                          HabitDefinition,
                          $HabitDefinitionsTable,
                          ReductionPlanRow
                        >(
                          currentTable: table,
                          referencedTable: $$HabitDefinitionsTableReferences
                              ._reductionPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitDefinitionsTableReferences(
                                db,
                                table,
                                p0,
                              ).reductionPlansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HabitDefinitionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitDefinitionsTable,
      HabitDefinition,
      $$HabitDefinitionsTableFilterComposer,
      $$HabitDefinitionsTableOrderingComposer,
      $$HabitDefinitionsTableAnnotationComposer,
      $$HabitDefinitionsTableCreateCompanionBuilder,
      $$HabitDefinitionsTableUpdateCompanionBuilder,
      (HabitDefinition, $$HabitDefinitionsTableReferences),
      HabitDefinition,
      PrefetchHooks Function({
        bool habitLogEntriesRefs,
        bool graphHistoryEntriesRefs,
        bool customGraphRulesRefs,
        bool specialHabitGraphsRefs,
        bool reductionPlansRefs,
      })
    >;
typedef $$HabitLogEntriesTableCreateCompanionBuilder =
    HabitLogEntriesCompanion Function({
      required String id,
      required String habitId,
      required DateTime loggedAt,
      required DateTime localDay,
      Value<int> quantity,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$HabitLogEntriesTableUpdateCompanionBuilder =
    HabitLogEntriesCompanion Function({
      Value<String> id,
      Value<String> habitId,
      Value<DateTime> loggedAt,
      Value<DateTime> localDay,
      Value<int> quantity,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$HabitLogEntriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $HabitLogEntriesTable, HabitLogEntry> {
  $$HabitLogEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitDefinitionsTable _habitIdTable(_$AppDatabase db) => db
      .habitDefinitions
      .createAlias('habit_log_entries__habit_id__habit_definitions__id');

  $$HabitDefinitionsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<String>('habit_id')!;

    final manager = $$HabitDefinitionsTableTableManager(
      $_db,
      $_db.habitDefinitions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitLogEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $HabitLogEntriesTable> {
  $$HabitLogEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get localDay => $composableBuilder(
    column: $table.localDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitDefinitionsTableFilterComposer get habitId {
    final $$HabitDefinitionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableFilterComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitLogEntriesTable> {
  $$HabitLogEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get localDay => $composableBuilder(
    column: $table.localDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitDefinitionsTableOrderingComposer get habitId {
    final $$HabitDefinitionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableOrderingComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitLogEntriesTable> {
  $$HabitLogEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get localDay =>
      $composableBuilder(column: $table.localDay, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$HabitDefinitionsTableAnnotationComposer get habitId {
    final $$HabitDefinitionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitLogEntriesTable,
          HabitLogEntry,
          $$HabitLogEntriesTableFilterComposer,
          $$HabitLogEntriesTableOrderingComposer,
          $$HabitLogEntriesTableAnnotationComposer,
          $$HabitLogEntriesTableCreateCompanionBuilder,
          $$HabitLogEntriesTableUpdateCompanionBuilder,
          (HabitLogEntry, $$HabitLogEntriesTableReferences),
          HabitLogEntry,
          PrefetchHooks Function({bool habitId})
        > {
  $$HabitLogEntriesTableTableManager(
    _$AppDatabase db,
    $HabitLogEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitLogEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitLogEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitLogEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<DateTime> localDay = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitLogEntriesCompanion(
                id: id,
                habitId: habitId,
                loggedAt: loggedAt,
                localDay: localDay,
                quantity: quantity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String habitId,
                required DateTime loggedAt,
                required DateTime localDay,
                Value<int> quantity = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitLogEntriesCompanion.insert(
                id: id,
                habitId: habitId,
                loggedAt: loggedAt,
                localDay: localDay,
                quantity: quantity,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitLogEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable:
                                    $$HabitLogEntriesTableReferences
                                        ._habitIdTable(db),
                                referencedColumn:
                                    $$HabitLogEntriesTableReferences
                                        ._habitIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitLogEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitLogEntriesTable,
      HabitLogEntry,
      $$HabitLogEntriesTableFilterComposer,
      $$HabitLogEntriesTableOrderingComposer,
      $$HabitLogEntriesTableAnnotationComposer,
      $$HabitLogEntriesTableCreateCompanionBuilder,
      $$HabitLogEntriesTableUpdateCompanionBuilder,
      (HabitLogEntry, $$HabitLogEntriesTableReferences),
      HabitLogEntry,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$BodyPartStatesTableCreateCompanionBuilder =
    BodyPartStatesCompanion Function({
      required String partKey,
      Value<int> level,
      Value<int?> colorValue,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<int> rowid,
    });
typedef $$BodyPartStatesTableUpdateCompanionBuilder =
    BodyPartStatesCompanion Function({
      Value<String> partKey,
      Value<int> level,
      Value<int?> colorValue,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<int> rowid,
    });

class $$BodyPartStatesTableFilterComposer
    extends Composer<_$AppDatabase, $BodyPartStatesTable> {
  $$BodyPartStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get partKey => $composableBuilder(
    column: $table.partKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BodyPartStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $BodyPartStatesTable> {
  $$BodyPartStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get partKey => $composableBuilder(
    column: $table.partKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BodyPartStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BodyPartStatesTable> {
  $$BodyPartStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get partKey =>
      $composableBuilder(column: $table.partKey, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);
}

class $$BodyPartStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BodyPartStatesTable,
          BodyPartState,
          $$BodyPartStatesTableFilterComposer,
          $$BodyPartStatesTableOrderingComposer,
          $$BodyPartStatesTableAnnotationComposer,
          $$BodyPartStatesTableCreateCompanionBuilder,
          $$BodyPartStatesTableUpdateCompanionBuilder,
          (
            BodyPartState,
            BaseReferences<_$AppDatabase, $BodyPartStatesTable, BodyPartState>,
          ),
          BodyPartState,
          PrefetchHooks Function()
        > {
  $$BodyPartStatesTableTableManager(
    _$AppDatabase db,
    $BodyPartStatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BodyPartStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BodyPartStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BodyPartStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> partKey = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BodyPartStatesCompanion(
                partKey: partKey,
                level: level,
                colorValue: colorValue,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String partKey,
                Value<int> level = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BodyPartStatesCompanion.insert(
                partKey: partKey,
                level: level,
                colorValue: colorValue,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BodyPartStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BodyPartStatesTable,
      BodyPartState,
      $$BodyPartStatesTableFilterComposer,
      $$BodyPartStatesTableOrderingComposer,
      $$BodyPartStatesTableAnnotationComposer,
      $$BodyPartStatesTableCreateCompanionBuilder,
      $$BodyPartStatesTableUpdateCompanionBuilder,
      (
        BodyPartState,
        BaseReferences<_$AppDatabase, $BodyPartStatesTable, BodyPartState>,
      ),
      BodyPartState,
      PrefetchHooks Function()
    >;
typedef $$GraphHistoryEntriesTableCreateCompanionBuilder =
    GraphHistoryEntriesCompanion Function({
      required String id,
      required String metricKey,
      Value<String?> habitId,
      required DateTime localDay,
      required double value,
      required DateTime recordedAt,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$GraphHistoryEntriesTableUpdateCompanionBuilder =
    GraphHistoryEntriesCompanion Function({
      Value<String> id,
      Value<String> metricKey,
      Value<String?> habitId,
      Value<DateTime> localDay,
      Value<double> value,
      Value<DateTime> recordedAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$GraphHistoryEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GraphHistoryEntriesTable,
          GraphHistoryEntry
        > {
  $$GraphHistoryEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitDefinitionsTable _habitIdTable(_$AppDatabase db) => db
      .habitDefinitions
      .createAlias('graph_history_entries__habit_id__habit_definitions__id');

  $$HabitDefinitionsTableProcessedTableManager? get habitId {
    final $_column = $_itemColumn<String>('habit_id');
    if ($_column == null) return null;
    final manager = $$HabitDefinitionsTableTableManager(
      $_db,
      $_db.habitDefinitions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GraphHistoryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $GraphHistoryEntriesTable> {
  $$GraphHistoryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metricKey => $composableBuilder(
    column: $table.metricKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get localDay => $composableBuilder(
    column: $table.localDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitDefinitionsTableFilterComposer get habitId {
    final $$HabitDefinitionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableFilterComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GraphHistoryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $GraphHistoryEntriesTable> {
  $$GraphHistoryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metricKey => $composableBuilder(
    column: $table.metricKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get localDay => $composableBuilder(
    column: $table.localDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitDefinitionsTableOrderingComposer get habitId {
    final $$HabitDefinitionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableOrderingComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GraphHistoryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GraphHistoryEntriesTable> {
  $$GraphHistoryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get metricKey =>
      $composableBuilder(column: $table.metricKey, builder: (column) => column);

  GeneratedColumn<DateTime> get localDay =>
      $composableBuilder(column: $table.localDay, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$HabitDefinitionsTableAnnotationComposer get habitId {
    final $$HabitDefinitionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GraphHistoryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GraphHistoryEntriesTable,
          GraphHistoryEntry,
          $$GraphHistoryEntriesTableFilterComposer,
          $$GraphHistoryEntriesTableOrderingComposer,
          $$GraphHistoryEntriesTableAnnotationComposer,
          $$GraphHistoryEntriesTableCreateCompanionBuilder,
          $$GraphHistoryEntriesTableUpdateCompanionBuilder,
          (GraphHistoryEntry, $$GraphHistoryEntriesTableReferences),
          GraphHistoryEntry,
          PrefetchHooks Function({bool habitId})
        > {
  $$GraphHistoryEntriesTableTableManager(
    _$AppDatabase db,
    $GraphHistoryEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GraphHistoryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GraphHistoryEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GraphHistoryEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> metricKey = const Value.absent(),
                Value<String?> habitId = const Value.absent(),
                Value<DateTime> localDay = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GraphHistoryEntriesCompanion(
                id: id,
                metricKey: metricKey,
                habitId: habitId,
                localDay: localDay,
                value: value,
                recordedAt: recordedAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String metricKey,
                Value<String?> habitId = const Value.absent(),
                required DateTime localDay,
                required double value,
                required DateTime recordedAt,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GraphHistoryEntriesCompanion.insert(
                id: id,
                metricKey: metricKey,
                habitId: habitId,
                localDay: localDay,
                value: value,
                recordedAt: recordedAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GraphHistoryEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable:
                                    $$GraphHistoryEntriesTableReferences
                                        ._habitIdTable(db),
                                referencedColumn:
                                    $$GraphHistoryEntriesTableReferences
                                        ._habitIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GraphHistoryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GraphHistoryEntriesTable,
      GraphHistoryEntry,
      $$GraphHistoryEntriesTableFilterComposer,
      $$GraphHistoryEntriesTableOrderingComposer,
      $$GraphHistoryEntriesTableAnnotationComposer,
      $$GraphHistoryEntriesTableCreateCompanionBuilder,
      $$GraphHistoryEntriesTableUpdateCompanionBuilder,
      (GraphHistoryEntry, $$GraphHistoryEntriesTableReferences),
      GraphHistoryEntry,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$CustomGraphRulesTableCreateCompanionBuilder =
    CustomGraphRulesCompanion Function({
      Value<int> slot,
      required String habitId,
      required int completedPoints,
      required int missedPoints,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
    });
typedef $$CustomGraphRulesTableUpdateCompanionBuilder =
    CustomGraphRulesCompanion Function({
      Value<int> slot,
      Value<String> habitId,
      Value<int> completedPoints,
      Value<int> missedPoints,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
    });

final class $$CustomGraphRulesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CustomGraphRulesTable,
          CustomGraphRuleRow
        > {
  $$CustomGraphRulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitDefinitionsTable _habitIdTable(_$AppDatabase db) => db
      .habitDefinitions
      .createAlias('custom_graph_rules__habit_id__habit_definitions__id');

  $$HabitDefinitionsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<String>('habit_id')!;

    final manager = $$HabitDefinitionsTableTableManager(
      $_db,
      $_db.habitDefinitions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CustomGraphRulesTableFilterComposer
    extends Composer<_$AppDatabase, $CustomGraphRulesTable> {
  $$CustomGraphRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedPoints => $composableBuilder(
    column: $table.completedPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get missedPoints => $composableBuilder(
    column: $table.missedPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitDefinitionsTableFilterComposer get habitId {
    final $$HabitDefinitionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableFilterComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomGraphRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomGraphRulesTable> {
  $$CustomGraphRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedPoints => $composableBuilder(
    column: $table.completedPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get missedPoints => $composableBuilder(
    column: $table.missedPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitDefinitionsTableOrderingComposer get habitId {
    final $$HabitDefinitionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableOrderingComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomGraphRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomGraphRulesTable> {
  $$CustomGraphRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<int> get completedPoints => $composableBuilder(
    column: $table.completedPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get missedPoints => $composableBuilder(
    column: $table.missedPoints,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  $$HabitDefinitionsTableAnnotationComposer get habitId {
    final $$HabitDefinitionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomGraphRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomGraphRulesTable,
          CustomGraphRuleRow,
          $$CustomGraphRulesTableFilterComposer,
          $$CustomGraphRulesTableOrderingComposer,
          $$CustomGraphRulesTableAnnotationComposer,
          $$CustomGraphRulesTableCreateCompanionBuilder,
          $$CustomGraphRulesTableUpdateCompanionBuilder,
          (CustomGraphRuleRow, $$CustomGraphRulesTableReferences),
          CustomGraphRuleRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$CustomGraphRulesTableTableManager(
    _$AppDatabase db,
    $CustomGraphRulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomGraphRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomGraphRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomGraphRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> slot = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<int> completedPoints = const Value.absent(),
                Value<int> missedPoints = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => CustomGraphRulesCompanion(
                slot: slot,
                habitId: habitId,
                completedPoints: completedPoints,
                missedPoints: missedPoints,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> slot = const Value.absent(),
                required String habitId,
                required int completedPoints,
                required int missedPoints,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => CustomGraphRulesCompanion.insert(
                slot: slot,
                habitId: habitId,
                completedPoints: completedPoints,
                missedPoints: missedPoints,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomGraphRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable:
                                    $$CustomGraphRulesTableReferences
                                        ._habitIdTable(db),
                                referencedColumn:
                                    $$CustomGraphRulesTableReferences
                                        ._habitIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CustomGraphRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomGraphRulesTable,
      CustomGraphRuleRow,
      $$CustomGraphRulesTableFilterComposer,
      $$CustomGraphRulesTableOrderingComposer,
      $$CustomGraphRulesTableAnnotationComposer,
      $$CustomGraphRulesTableCreateCompanionBuilder,
      $$CustomGraphRulesTableUpdateCompanionBuilder,
      (CustomGraphRuleRow, $$CustomGraphRulesTableReferences),
      CustomGraphRuleRow,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$SpecialHabitGraphsTableCreateCompanionBuilder =
    SpecialHabitGraphsCompanion Function({
      Value<int> slot,
      required String habitId,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
    });
typedef $$SpecialHabitGraphsTableUpdateCompanionBuilder =
    SpecialHabitGraphsCompanion Function({
      Value<int> slot,
      Value<String> habitId,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
    });

final class $$SpecialHabitGraphsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SpecialHabitGraphsTable,
          SpecialHabitGraphRow
        > {
  $$SpecialHabitGraphsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitDefinitionsTable _habitIdTable(_$AppDatabase db) => db
      .habitDefinitions
      .createAlias('special_habit_graphs__habit_id__habit_definitions__id');

  $$HabitDefinitionsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<String>('habit_id')!;

    final manager = $$HabitDefinitionsTableTableManager(
      $_db,
      $_db.habitDefinitions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SpecialHabitGraphsTableFilterComposer
    extends Composer<_$AppDatabase, $SpecialHabitGraphsTable> {
  $$SpecialHabitGraphsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitDefinitionsTableFilterComposer get habitId {
    final $$HabitDefinitionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableFilterComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpecialHabitGraphsTableOrderingComposer
    extends Composer<_$AppDatabase, $SpecialHabitGraphsTable> {
  $$SpecialHabitGraphsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitDefinitionsTableOrderingComposer get habitId {
    final $$HabitDefinitionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableOrderingComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpecialHabitGraphsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpecialHabitGraphsTable> {
  $$SpecialHabitGraphsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  $$HabitDefinitionsTableAnnotationComposer get habitId {
    final $$HabitDefinitionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpecialHabitGraphsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpecialHabitGraphsTable,
          SpecialHabitGraphRow,
          $$SpecialHabitGraphsTableFilterComposer,
          $$SpecialHabitGraphsTableOrderingComposer,
          $$SpecialHabitGraphsTableAnnotationComposer,
          $$SpecialHabitGraphsTableCreateCompanionBuilder,
          $$SpecialHabitGraphsTableUpdateCompanionBuilder,
          (SpecialHabitGraphRow, $$SpecialHabitGraphsTableReferences),
          SpecialHabitGraphRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$SpecialHabitGraphsTableTableManager(
    _$AppDatabase db,
    $SpecialHabitGraphsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpecialHabitGraphsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpecialHabitGraphsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpecialHabitGraphsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> slot = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => SpecialHabitGraphsCompanion(
                slot: slot,
                habitId: habitId,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> slot = const Value.absent(),
                required String habitId,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => SpecialHabitGraphsCompanion.insert(
                slot: slot,
                habitId: habitId,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SpecialHabitGraphsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable:
                                    $$SpecialHabitGraphsTableReferences
                                        ._habitIdTable(db),
                                referencedColumn:
                                    $$SpecialHabitGraphsTableReferences
                                        ._habitIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SpecialHabitGraphsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpecialHabitGraphsTable,
      SpecialHabitGraphRow,
      $$SpecialHabitGraphsTableFilterComposer,
      $$SpecialHabitGraphsTableOrderingComposer,
      $$SpecialHabitGraphsTableAnnotationComposer,
      $$SpecialHabitGraphsTableCreateCompanionBuilder,
      $$SpecialHabitGraphsTableUpdateCompanionBuilder,
      (SpecialHabitGraphRow, $$SpecialHabitGraphsTableReferences),
      SpecialHabitGraphRow,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$ReductionPlansTableCreateCompanionBuilder =
    ReductionPlansCompanion Function({
      required String id,
      required String habitId,
      required String mode,
      required DateTime startedOn,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$ReductionPlansTableUpdateCompanionBuilder =
    ReductionPlansCompanion Function({
      Value<String> id,
      Value<String> habitId,
      Value<String> mode,
      Value<DateTime> startedOn,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$ReductionPlansTableReferences
    extends
        BaseReferences<_$AppDatabase, $ReductionPlansTable, ReductionPlanRow> {
  $$ReductionPlansTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitDefinitionsTable _habitIdTable(_$AppDatabase db) => db
      .habitDefinitions
      .createAlias('reduction_plans__habit_id__habit_definitions__id');

  $$HabitDefinitionsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<String>('habit_id')!;

    final manager = $$HabitDefinitionsTableTableManager(
      $_db,
      $_db.habitDefinitions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReductionPlansTableFilterComposer
    extends Composer<_$AppDatabase, $ReductionPlansTable> {
  $$ReductionPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedOn => $composableBuilder(
    column: $table.startedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitDefinitionsTableFilterComposer get habitId {
    final $$HabitDefinitionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableFilterComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReductionPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $ReductionPlansTable> {
  $$ReductionPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedOn => $composableBuilder(
    column: $table.startedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitDefinitionsTableOrderingComposer get habitId {
    final $$HabitDefinitionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableOrderingComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReductionPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReductionPlansTable> {
  $$ReductionPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<DateTime> get startedOn =>
      $composableBuilder(column: $table.startedOn, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$HabitDefinitionsTableAnnotationComposer get habitId {
    final $$HabitDefinitionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habitDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitDefinitionsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReductionPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReductionPlansTable,
          ReductionPlanRow,
          $$ReductionPlansTableFilterComposer,
          $$ReductionPlansTableOrderingComposer,
          $$ReductionPlansTableAnnotationComposer,
          $$ReductionPlansTableCreateCompanionBuilder,
          $$ReductionPlansTableUpdateCompanionBuilder,
          (ReductionPlanRow, $$ReductionPlansTableReferences),
          ReductionPlanRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$ReductionPlansTableTableManager(
    _$AppDatabase db,
    $ReductionPlansTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReductionPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReductionPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReductionPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<DateTime> startedOn = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReductionPlansCompanion(
                id: id,
                habitId: habitId,
                mode: mode,
                startedOn: startedOn,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String habitId,
                required String mode,
                required DateTime startedOn,
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReductionPlansCompanion.insert(
                id: id,
                habitId: habitId,
                mode: mode,
                startedOn: startedOn,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReductionPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable: $$ReductionPlansTableReferences
                                    ._habitIdTable(db),
                                referencedColumn:
                                    $$ReductionPlansTableReferences
                                        ._habitIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReductionPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReductionPlansTable,
      ReductionPlanRow,
      $$ReductionPlansTableFilterComposer,
      $$ReductionPlansTableOrderingComposer,
      $$ReductionPlansTableAnnotationComposer,
      $$ReductionPlansTableCreateCompanionBuilder,
      $$ReductionPlansTableUpdateCompanionBuilder,
      (ReductionPlanRow, $$ReductionPlansTableReferences),
      ReductionPlanRow,
      PrefetchHooks Function({bool habitId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitDefinitionsTableTableManager get habitDefinitions =>
      $$HabitDefinitionsTableTableManager(_db, _db.habitDefinitions);
  $$HabitLogEntriesTableTableManager get habitLogEntries =>
      $$HabitLogEntriesTableTableManager(_db, _db.habitLogEntries);
  $$BodyPartStatesTableTableManager get bodyPartStates =>
      $$BodyPartStatesTableTableManager(_db, _db.bodyPartStates);
  $$GraphHistoryEntriesTableTableManager get graphHistoryEntries =>
      $$GraphHistoryEntriesTableTableManager(_db, _db.graphHistoryEntries);
  $$CustomGraphRulesTableTableManager get customGraphRules =>
      $$CustomGraphRulesTableTableManager(_db, _db.customGraphRules);
  $$SpecialHabitGraphsTableTableManager get specialHabitGraphs =>
      $$SpecialHabitGraphsTableTableManager(_db, _db.specialHabitGraphs);
  $$ReductionPlansTableTableManager get reductionPlans =>
      $$ReductionPlansTableTableManager(_db, _db.reductionPlans);
}
