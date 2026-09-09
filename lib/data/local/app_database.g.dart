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
  static const VerificationMeta _numericalTrackingEnabledMeta =
      const VerificationMeta('numericalTrackingEnabled');
  @override
  late final GeneratedColumn<bool> numericalTrackingEnabled =
      GeneratedColumn<bool>(
        'numerical_tracking_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("numerical_tracking_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _numericalTargetMeta = const VerificationMeta(
    'numericalTarget',
  );
  @override
  late final GeneratedColumn<int> numericalTarget = GeneratedColumn<int>(
    'numerical_target',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _numericalUnitMeta = const VerificationMeta(
    'numericalUnit',
  );
  @override
  late final GeneratedColumn<String> numericalUnit = GeneratedColumn<String>(
    'numerical_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    numericalTrackingEnabled,
    numericalTarget,
    numericalUnit,
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
    if (data.containsKey('numerical_tracking_enabled')) {
      context.handle(
        _numericalTrackingEnabledMeta,
        numericalTrackingEnabled.isAcceptableOrUnknown(
          data['numerical_tracking_enabled']!,
          _numericalTrackingEnabledMeta,
        ),
      );
    }
    if (data.containsKey('numerical_target')) {
      context.handle(
        _numericalTargetMeta,
        numericalTarget.isAcceptableOrUnknown(
          data['numerical_target']!,
          _numericalTargetMeta,
        ),
      );
    }
    if (data.containsKey('numerical_unit')) {
      context.handle(
        _numericalUnitMeta,
        numericalUnit.isAcceptableOrUnknown(
          data['numerical_unit']!,
          _numericalUnitMeta,
        ),
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
      numericalTrackingEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}numerical_tracking_enabled'],
      )!,
      numericalTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numerical_target'],
      ),
      numericalUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numerical_unit'],
      ),
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
  final bool numericalTrackingEnabled;
  final int? numericalTarget;
  final String? numericalUnit;
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
    required this.numericalTrackingEnabled,
    this.numericalTarget,
    this.numericalUnit,
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
    map['numerical_tracking_enabled'] = Variable<bool>(
      numericalTrackingEnabled,
    );
    if (!nullToAbsent || numericalTarget != null) {
      map['numerical_target'] = Variable<int>(numericalTarget);
    }
    if (!nullToAbsent || numericalUnit != null) {
      map['numerical_unit'] = Variable<String>(numericalUnit);
    }
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
      numericalTrackingEnabled: Value(numericalTrackingEnabled),
      numericalTarget: numericalTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(numericalTarget),
      numericalUnit: numericalUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(numericalUnit),
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
      numericalTrackingEnabled: serializer.fromJson<bool>(
        json['numericalTrackingEnabled'],
      ),
      numericalTarget: serializer.fromJson<int?>(json['numericalTarget']),
      numericalUnit: serializer.fromJson<String?>(json['numericalUnit']),
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
      'numericalTrackingEnabled': serializer.toJson<bool>(
        numericalTrackingEnabled,
      ),
      'numericalTarget': serializer.toJson<int?>(numericalTarget),
      'numericalUnit': serializer.toJson<String?>(numericalUnit),
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
    bool? numericalTrackingEnabled,
    Value<int?> numericalTarget = const Value.absent(),
    Value<String?> numericalUnit = const Value.absent(),
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
    numericalTrackingEnabled:
        numericalTrackingEnabled ?? this.numericalTrackingEnabled,
    numericalTarget: numericalTarget.present
        ? numericalTarget.value
        : this.numericalTarget,
    numericalUnit: numericalUnit.present
        ? numericalUnit.value
        : this.numericalUnit,
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
      numericalTrackingEnabled: data.numericalTrackingEnabled.present
          ? data.numericalTrackingEnabled.value
          : this.numericalTrackingEnabled,
      numericalTarget: data.numericalTarget.present
          ? data.numericalTarget.value
          : this.numericalTarget,
      numericalUnit: data.numericalUnit.present
          ? data.numericalUnit.value
          : this.numericalUnit,
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
          ..write('numericalTrackingEnabled: $numericalTrackingEnabled, ')
          ..write('numericalTarget: $numericalTarget, ')
          ..write('numericalUnit: $numericalUnit, ')
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
    numericalTrackingEnabled,
    numericalTarget,
    numericalUnit,
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
          other.numericalTrackingEnabled == this.numericalTrackingEnabled &&
          other.numericalTarget == this.numericalTarget &&
          other.numericalUnit == this.numericalUnit &&
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
  final Value<bool> numericalTrackingEnabled;
  final Value<int?> numericalTarget;
  final Value<String?> numericalUnit;
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
    this.numericalTrackingEnabled = const Value.absent(),
    this.numericalTarget = const Value.absent(),
    this.numericalUnit = const Value.absent(),
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
    this.numericalTrackingEnabled = const Value.absent(),
    this.numericalTarget = const Value.absent(),
    this.numericalUnit = const Value.absent(),
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
    Expression<bool>? numericalTrackingEnabled,
    Expression<int>? numericalTarget,
    Expression<String>? numericalUnit,
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
      if (numericalTrackingEnabled != null)
        'numerical_tracking_enabled': numericalTrackingEnabled,
      if (numericalTarget != null) 'numerical_target': numericalTarget,
      if (numericalUnit != null) 'numerical_unit': numericalUnit,
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
    Value<bool>? numericalTrackingEnabled,
    Value<int?>? numericalTarget,
    Value<String?>? numericalUnit,
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
      numericalTrackingEnabled:
          numericalTrackingEnabled ?? this.numericalTrackingEnabled,
      numericalTarget: numericalTarget ?? this.numericalTarget,
      numericalUnit: numericalUnit ?? this.numericalUnit,
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
    if (numericalTrackingEnabled.present) {
      map['numerical_tracking_enabled'] = Variable<bool>(
        numericalTrackingEnabled.value,
      );
    }
    if (numericalTarget.present) {
      map['numerical_target'] = Variable<int>(numericalTarget.value);
    }
    if (numericalUnit.present) {
      map['numerical_unit'] = Variable<String>(numericalUnit.value);
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
          ..write('numericalTrackingEnabled: $numericalTrackingEnabled, ')
          ..write('numericalTarget: $numericalTarget, ')
          ..write('numericalUnit: $numericalUnit, ')
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
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
    'score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
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
    score,
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
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
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
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}score'],
      ),
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
  final double? score;
  final int? colorValue;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  const BodyPartState({
    required this.partKey,
    required this.level,
    this.score,
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
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<double>(score);
    }
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
      score: score == null && nullToAbsent
          ? const Value.absent()
          : Value(score),
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
      score: serializer.fromJson<double?>(json['score']),
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
      'score': serializer.toJson<double?>(score),
      'colorValue': serializer.toJson<int?>(colorValue),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  BodyPartState copyWith({
    String? partKey,
    int? level,
    Value<double?> score = const Value.absent(),
    Value<int?> colorValue = const Value.absent(),
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
  }) => BodyPartState(
    partKey: partKey ?? this.partKey,
    level: level ?? this.level,
    score: score.present ? score.value : this.score,
    colorValue: colorValue.present ? colorValue.value : this.colorValue,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  BodyPartState copyWithCompanion(BodyPartStatesCompanion data) {
    return BodyPartState(
      partKey: data.partKey.present ? data.partKey.value : this.partKey,
      level: data.level.present ? data.level.value : this.level,
      score: data.score.present ? data.score.value : this.score,
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
          ..write('score: $score, ')
          ..write('colorValue: $colorValue, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    partKey,
    level,
    score,
    colorValue,
    updatedAt,
    syncStatus,
    remoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyPartState &&
          other.partKey == this.partKey &&
          other.level == this.level &&
          other.score == this.score &&
          other.colorValue == this.colorValue &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId);
}

class BodyPartStatesCompanion extends UpdateCompanion<BodyPartState> {
  final Value<String> partKey;
  final Value<int> level;
  final Value<double?> score;
  final Value<int?> colorValue;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> rowid;
  const BodyPartStatesCompanion({
    this.partKey = const Value.absent(),
    this.level = const Value.absent(),
    this.score = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BodyPartStatesCompanion.insert({
    required String partKey,
    this.level = const Value.absent(),
    this.score = const Value.absent(),
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
    Expression<double>? score,
    Expression<int>? colorValue,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (partKey != null) 'part_key': partKey,
      if (level != null) 'level': level,
      if (score != null) 'score': score,
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
    Value<double?>? score,
    Value<int?>? colorValue,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<int>? rowid,
  }) {
    return BodyPartStatesCompanion(
      partKey: partKey ?? this.partKey,
      level: level ?? this.level,
      score: score ?? this.score,
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
    if (score.present) {
      map['score'] = Variable<double>(score.value);
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
          ..write('score: $score, ')
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
  static const VerificationMeta _completedValueMeta = const VerificationMeta(
    'completedValue',
  );
  @override
  late final GeneratedColumn<int> completedValue = GeneratedColumn<int>(
    'completed_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _missedValueMeta = const VerificationMeta(
    'missedValue',
  );
  @override
  late final GeneratedColumn<int> missedValue = GeneratedColumn<int>(
    'missed_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(-1),
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
    completedValue,
    missedValue,
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
    if (data.containsKey('completed_value')) {
      context.handle(
        _completedValueMeta,
        completedValue.isAcceptableOrUnknown(
          data['completed_value']!,
          _completedValueMeta,
        ),
      );
    }
    if (data.containsKey('missed_value')) {
      context.handle(
        _missedValueMeta,
        missedValue.isAcceptableOrUnknown(
          data['missed_value']!,
          _missedValueMeta,
        ),
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
      completedValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_value'],
      )!,
      missedValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}missed_value'],
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
  final int completedValue;
  final int missedValue;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  const SpecialHabitGraphRow({
    required this.slot,
    required this.habitId,
    required this.completedValue,
    required this.missedValue,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slot'] = Variable<int>(slot);
    map['habit_id'] = Variable<String>(habitId);
    map['completed_value'] = Variable<int>(completedValue);
    map['missed_value'] = Variable<int>(missedValue);
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
      completedValue: Value(completedValue),
      missedValue: Value(missedValue),
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
      completedValue: serializer.fromJson<int>(json['completedValue']),
      missedValue: serializer.fromJson<int>(json['missedValue']),
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
      'completedValue': serializer.toJson<int>(completedValue),
      'missedValue': serializer.toJson<int>(missedValue),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  SpecialHabitGraphRow copyWith({
    int? slot,
    String? habitId,
    int? completedValue,
    int? missedValue,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
  }) => SpecialHabitGraphRow(
    slot: slot ?? this.slot,
    habitId: habitId ?? this.habitId,
    completedValue: completedValue ?? this.completedValue,
    missedValue: missedValue ?? this.missedValue,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  SpecialHabitGraphRow copyWithCompanion(SpecialHabitGraphsCompanion data) {
    return SpecialHabitGraphRow(
      slot: data.slot.present ? data.slot.value : this.slot,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      completedValue: data.completedValue.present
          ? data.completedValue.value
          : this.completedValue,
      missedValue: data.missedValue.present
          ? data.missedValue.value
          : this.missedValue,
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
          ..write('completedValue: $completedValue, ')
          ..write('missedValue: $missedValue, ')
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
    completedValue,
    missedValue,
    updatedAt,
    syncStatus,
    remoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpecialHabitGraphRow &&
          other.slot == this.slot &&
          other.habitId == this.habitId &&
          other.completedValue == this.completedValue &&
          other.missedValue == this.missedValue &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId);
}

class SpecialHabitGraphsCompanion
    extends UpdateCompanion<SpecialHabitGraphRow> {
  final Value<int> slot;
  final Value<String> habitId;
  final Value<int> completedValue;
  final Value<int> missedValue;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  const SpecialHabitGraphsCompanion({
    this.slot = const Value.absent(),
    this.habitId = const Value.absent(),
    this.completedValue = const Value.absent(),
    this.missedValue = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
  });
  SpecialHabitGraphsCompanion.insert({
    this.slot = const Value.absent(),
    required String habitId,
    this.completedValue = const Value.absent(),
    this.missedValue = const Value.absent(),
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
  }) : habitId = Value(habitId),
       updatedAt = Value(updatedAt);
  static Insertable<SpecialHabitGraphRow> custom({
    Expression<int>? slot,
    Expression<String>? habitId,
    Expression<int>? completedValue,
    Expression<int>? missedValue,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
  }) {
    return RawValuesInsertable({
      if (slot != null) 'slot': slot,
      if (habitId != null) 'habit_id': habitId,
      if (completedValue != null) 'completed_value': completedValue,
      if (missedValue != null) 'missed_value': missedValue,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
    });
  }

  SpecialHabitGraphsCompanion copyWith({
    Value<int>? slot,
    Value<String>? habitId,
    Value<int>? completedValue,
    Value<int>? missedValue,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
  }) {
    return SpecialHabitGraphsCompanion(
      slot: slot ?? this.slot,
      habitId: habitId ?? this.habitId,
      completedValue: completedValue ?? this.completedValue,
      missedValue: missedValue ?? this.missedValue,
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
    if (completedValue.present) {
      map['completed_value'] = Variable<int>(completedValue.value);
    }
    if (missedValue.present) {
      map['missed_value'] = Variable<int>(missedValue.value);
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
          ..write('completedValue: $completedValue, ')
          ..write('missedValue: $missedValue, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }
}

class $NamedCustomGraphsTable extends NamedCustomGraphs
    with TableInfo<$NamedCustomGraphsTable, NamedCustomGraphRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NamedCustomGraphsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    name,
    updatedAt,
    syncStatus,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'named_custom_graphs';
  @override
  VerificationContext validateIntegrity(
    Insertable<NamedCustomGraphRow> instance, {
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
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  NamedCustomGraphRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NamedCustomGraphRow(
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
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
  $NamedCustomGraphsTable createAlias(String alias) {
    return $NamedCustomGraphsTable(attachedDatabase, alias);
  }
}

class NamedCustomGraphRow extends DataClass
    implements Insertable<NamedCustomGraphRow> {
  final int slot;
  final String name;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  const NamedCustomGraphRow({
    required this.slot,
    required this.name,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slot'] = Variable<int>(slot);
    map['name'] = Variable<String>(name);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  NamedCustomGraphsCompanion toCompanion(bool nullToAbsent) {
    return NamedCustomGraphsCompanion(
      slot: Value(slot),
      name: Value(name),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory NamedCustomGraphRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NamedCustomGraphRow(
      slot: serializer.fromJson<int>(json['slot']),
      name: serializer.fromJson<String>(json['name']),
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
      'name': serializer.toJson<String>(name),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  NamedCustomGraphRow copyWith({
    int? slot,
    String? name,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
  }) => NamedCustomGraphRow(
    slot: slot ?? this.slot,
    name: name ?? this.name,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  NamedCustomGraphRow copyWithCompanion(NamedCustomGraphsCompanion data) {
    return NamedCustomGraphRow(
      slot: data.slot.present ? data.slot.value : this.slot,
      name: data.name.present ? data.name.value : this.name,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NamedCustomGraphRow(')
          ..write('slot: $slot, ')
          ..write('name: $name, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(slot, name, updatedAt, syncStatus, remoteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NamedCustomGraphRow &&
          other.slot == this.slot &&
          other.name == this.name &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId);
}

class NamedCustomGraphsCompanion extends UpdateCompanion<NamedCustomGraphRow> {
  final Value<int> slot;
  final Value<String> name;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  const NamedCustomGraphsCompanion({
    this.slot = const Value.absent(),
    this.name = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
  });
  NamedCustomGraphsCompanion.insert({
    this.slot = const Value.absent(),
    required String name,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
  }) : name = Value(name),
       updatedAt = Value(updatedAt);
  static Insertable<NamedCustomGraphRow> custom({
    Expression<int>? slot,
    Expression<String>? name,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
  }) {
    return RawValuesInsertable({
      if (slot != null) 'slot': slot,
      if (name != null) 'name': name,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
    });
  }

  NamedCustomGraphsCompanion copyWith({
    Value<int>? slot,
    Value<String>? name,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
  }) {
    return NamedCustomGraphsCompanion(
      slot: slot ?? this.slot,
      name: name ?? this.name,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
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
    return (StringBuffer('NamedCustomGraphsCompanion(')
          ..write('slot: $slot, ')
          ..write('name: $name, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }
}

class $NamedCustomGraphRulesTable extends NamedCustomGraphRules
    with TableInfo<$NamedCustomGraphRulesTable, NamedCustomGraphRuleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NamedCustomGraphRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _graphSlotMeta = const VerificationMeta(
    'graphSlot',
  );
  @override
  late final GeneratedColumn<int> graphSlot = GeneratedColumn<int>(
    'graph_slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES named_custom_graphs (slot)',
    ),
  );
  static const VerificationMeta _ruleSlotMeta = const VerificationMeta(
    'ruleSlot',
  );
  @override
  late final GeneratedColumn<int> ruleSlot = GeneratedColumn<int>(
    'rule_slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
    graphSlot,
    ruleSlot,
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
  static const String $name = 'named_custom_graph_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<NamedCustomGraphRuleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('graph_slot')) {
      context.handle(
        _graphSlotMeta,
        graphSlot.isAcceptableOrUnknown(data['graph_slot']!, _graphSlotMeta),
      );
    } else if (isInserting) {
      context.missing(_graphSlotMeta);
    }
    if (data.containsKey('rule_slot')) {
      context.handle(
        _ruleSlotMeta,
        ruleSlot.isAcceptableOrUnknown(data['rule_slot']!, _ruleSlotMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleSlotMeta);
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
  Set<GeneratedColumn> get $primaryKey => {graphSlot, ruleSlot};
  @override
  NamedCustomGraphRuleRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NamedCustomGraphRuleRow(
      graphSlot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}graph_slot'],
      )!,
      ruleSlot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rule_slot'],
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
  $NamedCustomGraphRulesTable createAlias(String alias) {
    return $NamedCustomGraphRulesTable(attachedDatabase, alias);
  }
}

class NamedCustomGraphRuleRow extends DataClass
    implements Insertable<NamedCustomGraphRuleRow> {
  final int graphSlot;
  final int ruleSlot;
  final String habitId;
  final int completedPoints;
  final int missedPoints;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  const NamedCustomGraphRuleRow({
    required this.graphSlot,
    required this.ruleSlot,
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
    map['graph_slot'] = Variable<int>(graphSlot);
    map['rule_slot'] = Variable<int>(ruleSlot);
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

  NamedCustomGraphRulesCompanion toCompanion(bool nullToAbsent) {
    return NamedCustomGraphRulesCompanion(
      graphSlot: Value(graphSlot),
      ruleSlot: Value(ruleSlot),
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

  factory NamedCustomGraphRuleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NamedCustomGraphRuleRow(
      graphSlot: serializer.fromJson<int>(json['graphSlot']),
      ruleSlot: serializer.fromJson<int>(json['ruleSlot']),
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
      'graphSlot': serializer.toJson<int>(graphSlot),
      'ruleSlot': serializer.toJson<int>(ruleSlot),
      'habitId': serializer.toJson<String>(habitId),
      'completedPoints': serializer.toJson<int>(completedPoints),
      'missedPoints': serializer.toJson<int>(missedPoints),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  NamedCustomGraphRuleRow copyWith({
    int? graphSlot,
    int? ruleSlot,
    String? habitId,
    int? completedPoints,
    int? missedPoints,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
  }) => NamedCustomGraphRuleRow(
    graphSlot: graphSlot ?? this.graphSlot,
    ruleSlot: ruleSlot ?? this.ruleSlot,
    habitId: habitId ?? this.habitId,
    completedPoints: completedPoints ?? this.completedPoints,
    missedPoints: missedPoints ?? this.missedPoints,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  NamedCustomGraphRuleRow copyWithCompanion(
    NamedCustomGraphRulesCompanion data,
  ) {
    return NamedCustomGraphRuleRow(
      graphSlot: data.graphSlot.present ? data.graphSlot.value : this.graphSlot,
      ruleSlot: data.ruleSlot.present ? data.ruleSlot.value : this.ruleSlot,
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
    return (StringBuffer('NamedCustomGraphRuleRow(')
          ..write('graphSlot: $graphSlot, ')
          ..write('ruleSlot: $ruleSlot, ')
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
    graphSlot,
    ruleSlot,
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
      (other is NamedCustomGraphRuleRow &&
          other.graphSlot == this.graphSlot &&
          other.ruleSlot == this.ruleSlot &&
          other.habitId == this.habitId &&
          other.completedPoints == this.completedPoints &&
          other.missedPoints == this.missedPoints &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId);
}

class NamedCustomGraphRulesCompanion
    extends UpdateCompanion<NamedCustomGraphRuleRow> {
  final Value<int> graphSlot;
  final Value<int> ruleSlot;
  final Value<String> habitId;
  final Value<int> completedPoints;
  final Value<int> missedPoints;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> rowid;
  const NamedCustomGraphRulesCompanion({
    this.graphSlot = const Value.absent(),
    this.ruleSlot = const Value.absent(),
    this.habitId = const Value.absent(),
    this.completedPoints = const Value.absent(),
    this.missedPoints = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NamedCustomGraphRulesCompanion.insert({
    required int graphSlot,
    required int ruleSlot,
    required String habitId,
    required int completedPoints,
    required int missedPoints,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : graphSlot = Value(graphSlot),
       ruleSlot = Value(ruleSlot),
       habitId = Value(habitId),
       completedPoints = Value(completedPoints),
       missedPoints = Value(missedPoints),
       updatedAt = Value(updatedAt);
  static Insertable<NamedCustomGraphRuleRow> custom({
    Expression<int>? graphSlot,
    Expression<int>? ruleSlot,
    Expression<String>? habitId,
    Expression<int>? completedPoints,
    Expression<int>? missedPoints,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (graphSlot != null) 'graph_slot': graphSlot,
      if (ruleSlot != null) 'rule_slot': ruleSlot,
      if (habitId != null) 'habit_id': habitId,
      if (completedPoints != null) 'completed_points': completedPoints,
      if (missedPoints != null) 'missed_points': missedPoints,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NamedCustomGraphRulesCompanion copyWith({
    Value<int>? graphSlot,
    Value<int>? ruleSlot,
    Value<String>? habitId,
    Value<int>? completedPoints,
    Value<int>? missedPoints,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<int>? rowid,
  }) {
    return NamedCustomGraphRulesCompanion(
      graphSlot: graphSlot ?? this.graphSlot,
      ruleSlot: ruleSlot ?? this.ruleSlot,
      habitId: habitId ?? this.habitId,
      completedPoints: completedPoints ?? this.completedPoints,
      missedPoints: missedPoints ?? this.missedPoints,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (graphSlot.present) {
      map['graph_slot'] = Variable<int>(graphSlot.value);
    }
    if (ruleSlot.present) {
      map['rule_slot'] = Variable<int>(ruleSlot.value);
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NamedCustomGraphRulesCompanion(')
          ..write('graphSlot: $graphSlot, ')
          ..write('ruleSlot: $ruleSlot, ')
          ..write('habitId: $habitId, ')
          ..write('completedPoints: $completedPoints, ')
          ..write('missedPoints: $missedPoints, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('rowid: $rowid')
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

class $GrowthPlansTable extends GrowthPlans
    with TableInfo<$GrowthPlansTable, GrowthPlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrowthPlansTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _targetDaysPerWeekMeta = const VerificationMeta(
    'targetDaysPerWeek',
  );
  @override
  late final GeneratedColumn<int> targetDaysPerWeek = GeneratedColumn<int>(
    'target_days_per_week',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetRepetitionsPerDayMeta =
      const VerificationMeta('targetRepetitionsPerDay');
  @override
  late final GeneratedColumn<int> targetRepetitionsPerDay =
      GeneratedColumn<int>(
        'target_repetitions_per_day',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _offWeekdaysMeta = const VerificationMeta(
    'offWeekdays',
  );
  @override
  late final GeneratedColumn<String> offWeekdays = GeneratedColumn<String>(
    'off_weekdays',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _weekdayRepetitionsMeta =
      const VerificationMeta('weekdayRepetitions');
  @override
  late final GeneratedColumn<String> weekdayRepetitions =
      GeneratedColumn<String>(
        'weekday_repetitions',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _measurementUnitMeta = const VerificationMeta(
    'measurementUnit',
  );
  @override
  late final GeneratedColumn<String> measurementUnit = GeneratedColumn<String>(
    'measurement_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('times'),
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
    targetDaysPerWeek,
    targetRepetitionsPerDay,
    offWeekdays,
    weekdayRepetitions,
    measurementUnit,
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
  static const String $name = 'growth_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<GrowthPlanRow> instance, {
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
    if (data.containsKey('target_days_per_week')) {
      context.handle(
        _targetDaysPerWeekMeta,
        targetDaysPerWeek.isAcceptableOrUnknown(
          data['target_days_per_week']!,
          _targetDaysPerWeekMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetDaysPerWeekMeta);
    }
    if (data.containsKey('target_repetitions_per_day')) {
      context.handle(
        _targetRepetitionsPerDayMeta,
        targetRepetitionsPerDay.isAcceptableOrUnknown(
          data['target_repetitions_per_day']!,
          _targetRepetitionsPerDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetRepetitionsPerDayMeta);
    }
    if (data.containsKey('off_weekdays')) {
      context.handle(
        _offWeekdaysMeta,
        offWeekdays.isAcceptableOrUnknown(
          data['off_weekdays']!,
          _offWeekdaysMeta,
        ),
      );
    }
    if (data.containsKey('weekday_repetitions')) {
      context.handle(
        _weekdayRepetitionsMeta,
        weekdayRepetitions.isAcceptableOrUnknown(
          data['weekday_repetitions']!,
          _weekdayRepetitionsMeta,
        ),
      );
    }
    if (data.containsKey('measurement_unit')) {
      context.handle(
        _measurementUnitMeta,
        measurementUnit.isAcceptableOrUnknown(
          data['measurement_unit']!,
          _measurementUnitMeta,
        ),
      );
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
  GrowthPlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrowthPlanRow(
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
      targetDaysPerWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_days_per_week'],
      )!,
      targetRepetitionsPerDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_repetitions_per_day'],
      )!,
      offWeekdays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}off_weekdays'],
      )!,
      weekdayRepetitions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weekday_repetitions'],
      )!,
      measurementUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}measurement_unit'],
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
  $GrowthPlansTable createAlias(String alias) {
    return $GrowthPlansTable(attachedDatabase, alias);
  }
}

class GrowthPlanRow extends DataClass implements Insertable<GrowthPlanRow> {
  final String id;
  final String habitId;
  final String mode;
  final DateTime startedOn;
  final int targetDaysPerWeek;
  final int targetRepetitionsPerDay;
  final String offWeekdays;
  final String weekdayRepetitions;
  final String measurementUnit;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  final DateTime? deletedAt;
  const GrowthPlanRow({
    required this.id,
    required this.habitId,
    required this.mode,
    required this.startedOn,
    required this.targetDaysPerWeek,
    required this.targetRepetitionsPerDay,
    required this.offWeekdays,
    required this.weekdayRepetitions,
    required this.measurementUnit,
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
    map['target_days_per_week'] = Variable<int>(targetDaysPerWeek);
    map['target_repetitions_per_day'] = Variable<int>(targetRepetitionsPerDay);
    map['off_weekdays'] = Variable<String>(offWeekdays);
    map['weekday_repetitions'] = Variable<String>(weekdayRepetitions);
    map['measurement_unit'] = Variable<String>(measurementUnit);
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

  GrowthPlansCompanion toCompanion(bool nullToAbsent) {
    return GrowthPlansCompanion(
      id: Value(id),
      habitId: Value(habitId),
      mode: Value(mode),
      startedOn: Value(startedOn),
      targetDaysPerWeek: Value(targetDaysPerWeek),
      targetRepetitionsPerDay: Value(targetRepetitionsPerDay),
      offWeekdays: Value(offWeekdays),
      weekdayRepetitions: Value(weekdayRepetitions),
      measurementUnit: Value(measurementUnit),
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

  factory GrowthPlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrowthPlanRow(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      mode: serializer.fromJson<String>(json['mode']),
      startedOn: serializer.fromJson<DateTime>(json['startedOn']),
      targetDaysPerWeek: serializer.fromJson<int>(json['targetDaysPerWeek']),
      targetRepetitionsPerDay: serializer.fromJson<int>(
        json['targetRepetitionsPerDay'],
      ),
      offWeekdays: serializer.fromJson<String>(json['offWeekdays']),
      weekdayRepetitions: serializer.fromJson<String>(
        json['weekdayRepetitions'],
      ),
      measurementUnit: serializer.fromJson<String>(json['measurementUnit']),
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
      'targetDaysPerWeek': serializer.toJson<int>(targetDaysPerWeek),
      'targetRepetitionsPerDay': serializer.toJson<int>(
        targetRepetitionsPerDay,
      ),
      'offWeekdays': serializer.toJson<String>(offWeekdays),
      'weekdayRepetitions': serializer.toJson<String>(weekdayRepetitions),
      'measurementUnit': serializer.toJson<String>(measurementUnit),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  GrowthPlanRow copyWith({
    String? id,
    String? habitId,
    String? mode,
    DateTime? startedOn,
    int? targetDaysPerWeek,
    int? targetRepetitionsPerDay,
    String? offWeekdays,
    String? weekdayRepetitions,
    String? measurementUnit,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => GrowthPlanRow(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    mode: mode ?? this.mode,
    startedOn: startedOn ?? this.startedOn,
    targetDaysPerWeek: targetDaysPerWeek ?? this.targetDaysPerWeek,
    targetRepetitionsPerDay:
        targetRepetitionsPerDay ?? this.targetRepetitionsPerDay,
    offWeekdays: offWeekdays ?? this.offWeekdays,
    weekdayRepetitions: weekdayRepetitions ?? this.weekdayRepetitions,
    measurementUnit: measurementUnit ?? this.measurementUnit,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  GrowthPlanRow copyWithCompanion(GrowthPlansCompanion data) {
    return GrowthPlanRow(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      mode: data.mode.present ? data.mode.value : this.mode,
      startedOn: data.startedOn.present ? data.startedOn.value : this.startedOn,
      targetDaysPerWeek: data.targetDaysPerWeek.present
          ? data.targetDaysPerWeek.value
          : this.targetDaysPerWeek,
      targetRepetitionsPerDay: data.targetRepetitionsPerDay.present
          ? data.targetRepetitionsPerDay.value
          : this.targetRepetitionsPerDay,
      offWeekdays: data.offWeekdays.present
          ? data.offWeekdays.value
          : this.offWeekdays,
      weekdayRepetitions: data.weekdayRepetitions.present
          ? data.weekdayRepetitions.value
          : this.weekdayRepetitions,
      measurementUnit: data.measurementUnit.present
          ? data.measurementUnit.value
          : this.measurementUnit,
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
    return (StringBuffer('GrowthPlanRow(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('mode: $mode, ')
          ..write('startedOn: $startedOn, ')
          ..write('targetDaysPerWeek: $targetDaysPerWeek, ')
          ..write('targetRepetitionsPerDay: $targetRepetitionsPerDay, ')
          ..write('offWeekdays: $offWeekdays, ')
          ..write('weekdayRepetitions: $weekdayRepetitions, ')
          ..write('measurementUnit: $measurementUnit, ')
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
    targetDaysPerWeek,
    targetRepetitionsPerDay,
    offWeekdays,
    weekdayRepetitions,
    measurementUnit,
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
      (other is GrowthPlanRow &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.mode == this.mode &&
          other.startedOn == this.startedOn &&
          other.targetDaysPerWeek == this.targetDaysPerWeek &&
          other.targetRepetitionsPerDay == this.targetRepetitionsPerDay &&
          other.offWeekdays == this.offWeekdays &&
          other.weekdayRepetitions == this.weekdayRepetitions &&
          other.measurementUnit == this.measurementUnit &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class GrowthPlansCompanion extends UpdateCompanion<GrowthPlanRow> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<String> mode;
  final Value<DateTime> startedOn;
  final Value<int> targetDaysPerWeek;
  final Value<int> targetRepetitionsPerDay;
  final Value<String> offWeekdays;
  final Value<String> weekdayRepetitions;
  final Value<String> measurementUnit;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const GrowthPlansCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.mode = const Value.absent(),
    this.startedOn = const Value.absent(),
    this.targetDaysPerWeek = const Value.absent(),
    this.targetRepetitionsPerDay = const Value.absent(),
    this.offWeekdays = const Value.absent(),
    this.weekdayRepetitions = const Value.absent(),
    this.measurementUnit = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GrowthPlansCompanion.insert({
    required String id,
    required String habitId,
    required String mode,
    required DateTime startedOn,
    required int targetDaysPerWeek,
    required int targetRepetitionsPerDay,
    this.offWeekdays = const Value.absent(),
    this.weekdayRepetitions = const Value.absent(),
    this.measurementUnit = const Value.absent(),
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
       targetDaysPerWeek = Value(targetDaysPerWeek),
       targetRepetitionsPerDay = Value(targetRepetitionsPerDay),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<GrowthPlanRow> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<String>? mode,
    Expression<DateTime>? startedOn,
    Expression<int>? targetDaysPerWeek,
    Expression<int>? targetRepetitionsPerDay,
    Expression<String>? offWeekdays,
    Expression<String>? weekdayRepetitions,
    Expression<String>? measurementUnit,
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
      if (targetDaysPerWeek != null) 'target_days_per_week': targetDaysPerWeek,
      if (targetRepetitionsPerDay != null)
        'target_repetitions_per_day': targetRepetitionsPerDay,
      if (offWeekdays != null) 'off_weekdays': offWeekdays,
      if (weekdayRepetitions != null) 'weekday_repetitions': weekdayRepetitions,
      if (measurementUnit != null) 'measurement_unit': measurementUnit,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GrowthPlansCompanion copyWith({
    Value<String>? id,
    Value<String>? habitId,
    Value<String>? mode,
    Value<DateTime>? startedOn,
    Value<int>? targetDaysPerWeek,
    Value<int>? targetRepetitionsPerDay,
    Value<String>? offWeekdays,
    Value<String>? weekdayRepetitions,
    Value<String>? measurementUnit,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return GrowthPlansCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      mode: mode ?? this.mode,
      startedOn: startedOn ?? this.startedOn,
      targetDaysPerWeek: targetDaysPerWeek ?? this.targetDaysPerWeek,
      targetRepetitionsPerDay:
          targetRepetitionsPerDay ?? this.targetRepetitionsPerDay,
      offWeekdays: offWeekdays ?? this.offWeekdays,
      weekdayRepetitions: weekdayRepetitions ?? this.weekdayRepetitions,
      measurementUnit: measurementUnit ?? this.measurementUnit,
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
    if (targetDaysPerWeek.present) {
      map['target_days_per_week'] = Variable<int>(targetDaysPerWeek.value);
    }
    if (targetRepetitionsPerDay.present) {
      map['target_repetitions_per_day'] = Variable<int>(
        targetRepetitionsPerDay.value,
      );
    }
    if (offWeekdays.present) {
      map['off_weekdays'] = Variable<String>(offWeekdays.value);
    }
    if (weekdayRepetitions.present) {
      map['weekday_repetitions'] = Variable<String>(weekdayRepetitions.value);
    }
    if (measurementUnit.present) {
      map['measurement_unit'] = Variable<String>(measurementUnit.value);
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
    return (StringBuffer('GrowthPlansCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('mode: $mode, ')
          ..write('startedOn: $startedOn, ')
          ..write('targetDaysPerWeek: $targetDaysPerWeek, ')
          ..write('targetRepetitionsPerDay: $targetRepetitionsPerDay, ')
          ..write('offWeekdays: $offWeekdays, ')
          ..write('weekdayRepetitions: $weekdayRepetitions, ')
          ..write('measurementUnit: $measurementUnit, ')
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

class $GrowthPlanEntriesTable extends GrowthPlanEntries
    with TableInfo<$GrowthPlanEntriesTable, GrowthPlanEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrowthPlanEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES growth_plans (id)',
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
  static const VerificationMeta _completedCountMeta = const VerificationMeta(
    'completedCount',
  );
  @override
  late final GeneratedColumn<int> completedCount = GeneratedColumn<int>(
    'completed_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  @override
  List<GeneratedColumn> get $columns => [
    planId,
    localDay,
    completedCount,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'growth_plan_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<GrowthPlanEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('local_day')) {
      context.handle(
        _localDayMeta,
        localDay.isAcceptableOrUnknown(data['local_day']!, _localDayMeta),
      );
    } else if (isInserting) {
      context.missing(_localDayMeta);
    }
    if (data.containsKey('completed_count')) {
      context.handle(
        _completedCountMeta,
        completedCount.isAcceptableOrUnknown(
          data['completed_count']!,
          _completedCountMeta,
        ),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {planId, localDay};
  @override
  GrowthPlanEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrowthPlanEntryRow(
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      localDay: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}local_day'],
      )!,
      completedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_count'],
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
    );
  }

  @override
  $GrowthPlanEntriesTable createAlias(String alias) {
    return $GrowthPlanEntriesTable(attachedDatabase, alias);
  }
}

class GrowthPlanEntryRow extends DataClass
    implements Insertable<GrowthPlanEntryRow> {
  final String planId;
  final DateTime localDay;
  final int completedCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  const GrowthPlanEntryRow({
    required this.planId,
    required this.localDay,
    required this.completedCount,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['plan_id'] = Variable<String>(planId);
    map['local_day'] = Variable<DateTime>(localDay);
    map['completed_count'] = Variable<int>(completedCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  GrowthPlanEntriesCompanion toCompanion(bool nullToAbsent) {
    return GrowthPlanEntriesCompanion(
      planId: Value(planId),
      localDay: Value(localDay),
      completedCount: Value(completedCount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory GrowthPlanEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrowthPlanEntryRow(
      planId: serializer.fromJson<String>(json['planId']),
      localDay: serializer.fromJson<DateTime>(json['localDay']),
      completedCount: serializer.fromJson<int>(json['completedCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'planId': serializer.toJson<String>(planId),
      'localDay': serializer.toJson<DateTime>(localDay),
      'completedCount': serializer.toJson<int>(completedCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  GrowthPlanEntryRow copyWith({
    String? planId,
    DateTime? localDay,
    int? completedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
  }) => GrowthPlanEntryRow(
    planId: planId ?? this.planId,
    localDay: localDay ?? this.localDay,
    completedCount: completedCount ?? this.completedCount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  GrowthPlanEntryRow copyWithCompanion(GrowthPlanEntriesCompanion data) {
    return GrowthPlanEntryRow(
      planId: data.planId.present ? data.planId.value : this.planId,
      localDay: data.localDay.present ? data.localDay.value : this.localDay,
      completedCount: data.completedCount.present
          ? data.completedCount.value
          : this.completedCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrowthPlanEntryRow(')
          ..write('planId: $planId, ')
          ..write('localDay: $localDay, ')
          ..write('completedCount: $completedCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    planId,
    localDay,
    completedCount,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrowthPlanEntryRow &&
          other.planId == this.planId &&
          other.localDay == this.localDay &&
          other.completedCount == this.completedCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId);
}

class GrowthPlanEntriesCompanion extends UpdateCompanion<GrowthPlanEntryRow> {
  final Value<String> planId;
  final Value<DateTime> localDay;
  final Value<int> completedCount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> rowid;
  const GrowthPlanEntriesCompanion({
    this.planId = const Value.absent(),
    this.localDay = const Value.absent(),
    this.completedCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GrowthPlanEntriesCompanion.insert({
    required String planId,
    required DateTime localDay,
    this.completedCount = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : planId = Value(planId),
       localDay = Value(localDay),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<GrowthPlanEntryRow> custom({
    Expression<String>? planId,
    Expression<DateTime>? localDay,
    Expression<int>? completedCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (planId != null) 'plan_id': planId,
      if (localDay != null) 'local_day': localDay,
      if (completedCount != null) 'completed_count': completedCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GrowthPlanEntriesCompanion copyWith({
    Value<String>? planId,
    Value<DateTime>? localDay,
    Value<int>? completedCount,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<int>? rowid,
  }) {
    return GrowthPlanEntriesCompanion(
      planId: planId ?? this.planId,
      localDay: localDay ?? this.localDay,
      completedCount: completedCount ?? this.completedCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (localDay.present) {
      map['local_day'] = Variable<DateTime>(localDay.value);
    }
    if (completedCount.present) {
      map['completed_count'] = Variable<int>(completedCount.value);
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrowthPlanEntriesCompanion(')
          ..write('planId: $planId, ')
          ..write('localDay: $localDay, ')
          ..write('completedCount: $completedCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitStreaksTable extends HabitStreaks
    with TableInfo<$HabitStreaksTable, HabitStreakRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitStreaksTable(this.attachedDatabase, [this._alias]);
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
  @override
  List<GeneratedColumn> get $columns => [
    habitId,
    colorValue,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_streaks';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitStreakRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {habitId};
  @override
  HabitStreakRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitStreakRow(
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HabitStreaksTable createAlias(String alias) {
    return $HabitStreaksTable(attachedDatabase, alias);
  }
}

class HabitStreakRow extends DataClass implements Insertable<HabitStreakRow> {
  final String habitId;
  final int? colorValue;
  final DateTime createdAt;
  final DateTime updatedAt;
  const HabitStreakRow({
    required this.habitId,
    this.colorValue,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['habit_id'] = Variable<String>(habitId);
    if (!nullToAbsent || colorValue != null) {
      map['color_value'] = Variable<int>(colorValue);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HabitStreaksCompanion toCompanion(bool nullToAbsent) {
    return HabitStreaksCompanion(
      habitId: Value(habitId),
      colorValue: colorValue == null && nullToAbsent
          ? const Value.absent()
          : Value(colorValue),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory HabitStreakRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitStreakRow(
      habitId: serializer.fromJson<String>(json['habitId']),
      colorValue: serializer.fromJson<int?>(json['colorValue']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'habitId': serializer.toJson<String>(habitId),
      'colorValue': serializer.toJson<int?>(colorValue),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HabitStreakRow copyWith({
    String? habitId,
    Value<int?> colorValue = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => HabitStreakRow(
    habitId: habitId ?? this.habitId,
    colorValue: colorValue.present ? colorValue.value : this.colorValue,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  HabitStreakRow copyWithCompanion(HabitStreaksCompanion data) {
    return HabitStreakRow(
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitStreakRow(')
          ..write('habitId: $habitId, ')
          ..write('colorValue: $colorValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(habitId, colorValue, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitStreakRow &&
          other.habitId == this.habitId &&
          other.colorValue == this.colorValue &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HabitStreaksCompanion extends UpdateCompanion<HabitStreakRow> {
  final Value<String> habitId;
  final Value<int?> colorValue;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const HabitStreaksCompanion({
    this.habitId = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitStreaksCompanion.insert({
    required String habitId,
    this.colorValue = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : habitId = Value(habitId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<HabitStreakRow> custom({
    Expression<String>? habitId,
    Expression<int>? colorValue,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (habitId != null) 'habit_id': habitId,
      if (colorValue != null) 'color_value': colorValue,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitStreaksCompanion copyWith({
    Value<String>? habitId,
    Value<int?>? colorValue,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return HabitStreaksCompanion(
      habitId: habitId ?? this.habitId,
      colorValue: colorValue ?? this.colorValue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitStreaksCompanion(')
          ..write('habitId: $habitId, ')
          ..write('colorValue: $colorValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppSetting({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith({String? key, String? value, DateTime? updatedAt}) =>
      AppSetting(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RewardStatesTable extends RewardStates
    with TableInfo<$RewardStatesTable, RewardStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RewardStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _planMeta = const VerificationMeta('plan');
  @override
  late final GeneratedColumn<String> plan = GeneratedColumn<String>(
    'plan',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('free'),
  );
  static const VerificationMeta _planExpiresAtMeta = const VerificationMeta(
    'planExpiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> planExpiresAt =
      GeneratedColumn<DateTime>(
        'plan_expires_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _tokenBalanceMeta = const VerificationMeta(
    'tokenBalance',
  );
  @override
  late final GeneratedColumn<int> tokenBalance = GeneratedColumn<int>(
    'token_balance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(140),
  );
  static const VerificationMeta _currentStreakMeta = const VerificationMeta(
    'currentStreak',
  );
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _profileProgressMeta = const VerificationMeta(
    'profileProgress',
  );
  @override
  late final GeneratedColumn<int> profileProgress = GeneratedColumn<int>(
    'profile_progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(140),
  );
  static const VerificationMeta _bodyProgressMeta = const VerificationMeta(
    'bodyProgress',
  );
  @override
  late final GeneratedColumn<int> bodyProgress = GeneratedColumn<int>(
    'body_progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _calendarProgressMeta = const VerificationMeta(
    'calendarProgress',
  );
  @override
  late final GeneratedColumn<int> calendarProgress = GeneratedColumn<int>(
    'calendar_progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastEvaluatedWeekMeta = const VerificationMeta(
    'lastEvaluatedWeek',
  );
  @override
  late final GeneratedColumn<DateTime> lastEvaluatedWeek =
      GeneratedColumn<DateTime>(
        'last_evaluated_week',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    plan,
    planExpiresAt,
    tokenBalance,
    currentStreak,
    profileProgress,
    bodyProgress,
    calendarProgress,
    lastEvaluatedWeek,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reward_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<RewardStateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan')) {
      context.handle(
        _planMeta,
        plan.isAcceptableOrUnknown(data['plan']!, _planMeta),
      );
    }
    if (data.containsKey('plan_expires_at')) {
      context.handle(
        _planExpiresAtMeta,
        planExpiresAt.isAcceptableOrUnknown(
          data['plan_expires_at']!,
          _planExpiresAtMeta,
        ),
      );
    }
    if (data.containsKey('token_balance')) {
      context.handle(
        _tokenBalanceMeta,
        tokenBalance.isAcceptableOrUnknown(
          data['token_balance']!,
          _tokenBalanceMeta,
        ),
      );
    }
    if (data.containsKey('current_streak')) {
      context.handle(
        _currentStreakMeta,
        currentStreak.isAcceptableOrUnknown(
          data['current_streak']!,
          _currentStreakMeta,
        ),
      );
    }
    if (data.containsKey('profile_progress')) {
      context.handle(
        _profileProgressMeta,
        profileProgress.isAcceptableOrUnknown(
          data['profile_progress']!,
          _profileProgressMeta,
        ),
      );
    }
    if (data.containsKey('body_progress')) {
      context.handle(
        _bodyProgressMeta,
        bodyProgress.isAcceptableOrUnknown(
          data['body_progress']!,
          _bodyProgressMeta,
        ),
      );
    }
    if (data.containsKey('calendar_progress')) {
      context.handle(
        _calendarProgressMeta,
        calendarProgress.isAcceptableOrUnknown(
          data['calendar_progress']!,
          _calendarProgressMeta,
        ),
      );
    }
    if (data.containsKey('last_evaluated_week')) {
      context.handle(
        _lastEvaluatedWeekMeta,
        lastEvaluatedWeek.isAcceptableOrUnknown(
          data['last_evaluated_week']!,
          _lastEvaluatedWeekMeta,
        ),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RewardStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RewardStateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      plan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan'],
      )!,
      planExpiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}plan_expires_at'],
      ),
      tokenBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}token_balance'],
      )!,
      currentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_streak'],
      )!,
      profileProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_progress'],
      )!,
      bodyProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}body_progress'],
      )!,
      calendarProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calendar_progress'],
      )!,
      lastEvaluatedWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_evaluated_week'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RewardStatesTable createAlias(String alias) {
    return $RewardStatesTable(attachedDatabase, alias);
  }
}

class RewardStateRow extends DataClass implements Insertable<RewardStateRow> {
  final int id;
  final String plan;
  final DateTime? planExpiresAt;
  final int tokenBalance;
  final int currentStreak;
  final int profileProgress;
  final int bodyProgress;
  final int calendarProgress;
  final DateTime? lastEvaluatedWeek;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RewardStateRow({
    required this.id,
    required this.plan,
    this.planExpiresAt,
    required this.tokenBalance,
    required this.currentStreak,
    required this.profileProgress,
    required this.bodyProgress,
    required this.calendarProgress,
    this.lastEvaluatedWeek,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan'] = Variable<String>(plan);
    if (!nullToAbsent || planExpiresAt != null) {
      map['plan_expires_at'] = Variable<DateTime>(planExpiresAt);
    }
    map['token_balance'] = Variable<int>(tokenBalance);
    map['current_streak'] = Variable<int>(currentStreak);
    map['profile_progress'] = Variable<int>(profileProgress);
    map['body_progress'] = Variable<int>(bodyProgress);
    map['calendar_progress'] = Variable<int>(calendarProgress);
    if (!nullToAbsent || lastEvaluatedWeek != null) {
      map['last_evaluated_week'] = Variable<DateTime>(lastEvaluatedWeek);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RewardStatesCompanion toCompanion(bool nullToAbsent) {
    return RewardStatesCompanion(
      id: Value(id),
      plan: Value(plan),
      planExpiresAt: planExpiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(planExpiresAt),
      tokenBalance: Value(tokenBalance),
      currentStreak: Value(currentStreak),
      profileProgress: Value(profileProgress),
      bodyProgress: Value(bodyProgress),
      calendarProgress: Value(calendarProgress),
      lastEvaluatedWeek: lastEvaluatedWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(lastEvaluatedWeek),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RewardStateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RewardStateRow(
      id: serializer.fromJson<int>(json['id']),
      plan: serializer.fromJson<String>(json['plan']),
      planExpiresAt: serializer.fromJson<DateTime?>(json['planExpiresAt']),
      tokenBalance: serializer.fromJson<int>(json['tokenBalance']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      profileProgress: serializer.fromJson<int>(json['profileProgress']),
      bodyProgress: serializer.fromJson<int>(json['bodyProgress']),
      calendarProgress: serializer.fromJson<int>(json['calendarProgress']),
      lastEvaluatedWeek: serializer.fromJson<DateTime?>(
        json['lastEvaluatedWeek'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'plan': serializer.toJson<String>(plan),
      'planExpiresAt': serializer.toJson<DateTime?>(planExpiresAt),
      'tokenBalance': serializer.toJson<int>(tokenBalance),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'profileProgress': serializer.toJson<int>(profileProgress),
      'bodyProgress': serializer.toJson<int>(bodyProgress),
      'calendarProgress': serializer.toJson<int>(calendarProgress),
      'lastEvaluatedWeek': serializer.toJson<DateTime?>(lastEvaluatedWeek),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RewardStateRow copyWith({
    int? id,
    String? plan,
    Value<DateTime?> planExpiresAt = const Value.absent(),
    int? tokenBalance,
    int? currentStreak,
    int? profileProgress,
    int? bodyProgress,
    int? calendarProgress,
    Value<DateTime?> lastEvaluatedWeek = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RewardStateRow(
    id: id ?? this.id,
    plan: plan ?? this.plan,
    planExpiresAt: planExpiresAt.present
        ? planExpiresAt.value
        : this.planExpiresAt,
    tokenBalance: tokenBalance ?? this.tokenBalance,
    currentStreak: currentStreak ?? this.currentStreak,
    profileProgress: profileProgress ?? this.profileProgress,
    bodyProgress: bodyProgress ?? this.bodyProgress,
    calendarProgress: calendarProgress ?? this.calendarProgress,
    lastEvaluatedWeek: lastEvaluatedWeek.present
        ? lastEvaluatedWeek.value
        : this.lastEvaluatedWeek,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RewardStateRow copyWithCompanion(RewardStatesCompanion data) {
    return RewardStateRow(
      id: data.id.present ? data.id.value : this.id,
      plan: data.plan.present ? data.plan.value : this.plan,
      planExpiresAt: data.planExpiresAt.present
          ? data.planExpiresAt.value
          : this.planExpiresAt,
      tokenBalance: data.tokenBalance.present
          ? data.tokenBalance.value
          : this.tokenBalance,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      profileProgress: data.profileProgress.present
          ? data.profileProgress.value
          : this.profileProgress,
      bodyProgress: data.bodyProgress.present
          ? data.bodyProgress.value
          : this.bodyProgress,
      calendarProgress: data.calendarProgress.present
          ? data.calendarProgress.value
          : this.calendarProgress,
      lastEvaluatedWeek: data.lastEvaluatedWeek.present
          ? data.lastEvaluatedWeek.value
          : this.lastEvaluatedWeek,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RewardStateRow(')
          ..write('id: $id, ')
          ..write('plan: $plan, ')
          ..write('planExpiresAt: $planExpiresAt, ')
          ..write('tokenBalance: $tokenBalance, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('profileProgress: $profileProgress, ')
          ..write('bodyProgress: $bodyProgress, ')
          ..write('calendarProgress: $calendarProgress, ')
          ..write('lastEvaluatedWeek: $lastEvaluatedWeek, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    plan,
    planExpiresAt,
    tokenBalance,
    currentStreak,
    profileProgress,
    bodyProgress,
    calendarProgress,
    lastEvaluatedWeek,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RewardStateRow &&
          other.id == this.id &&
          other.plan == this.plan &&
          other.planExpiresAt == this.planExpiresAt &&
          other.tokenBalance == this.tokenBalance &&
          other.currentStreak == this.currentStreak &&
          other.profileProgress == this.profileProgress &&
          other.bodyProgress == this.bodyProgress &&
          other.calendarProgress == this.calendarProgress &&
          other.lastEvaluatedWeek == this.lastEvaluatedWeek &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RewardStatesCompanion extends UpdateCompanion<RewardStateRow> {
  final Value<int> id;
  final Value<String> plan;
  final Value<DateTime?> planExpiresAt;
  final Value<int> tokenBalance;
  final Value<int> currentStreak;
  final Value<int> profileProgress;
  final Value<int> bodyProgress;
  final Value<int> calendarProgress;
  final Value<DateTime?> lastEvaluatedWeek;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RewardStatesCompanion({
    this.id = const Value.absent(),
    this.plan = const Value.absent(),
    this.planExpiresAt = const Value.absent(),
    this.tokenBalance = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.profileProgress = const Value.absent(),
    this.bodyProgress = const Value.absent(),
    this.calendarProgress = const Value.absent(),
    this.lastEvaluatedWeek = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RewardStatesCompanion.insert({
    this.id = const Value.absent(),
    this.plan = const Value.absent(),
    this.planExpiresAt = const Value.absent(),
    this.tokenBalance = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.profileProgress = const Value.absent(),
    this.bodyProgress = const Value.absent(),
    this.calendarProgress = const Value.absent(),
    this.lastEvaluatedWeek = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RewardStateRow> custom({
    Expression<int>? id,
    Expression<String>? plan,
    Expression<DateTime>? planExpiresAt,
    Expression<int>? tokenBalance,
    Expression<int>? currentStreak,
    Expression<int>? profileProgress,
    Expression<int>? bodyProgress,
    Expression<int>? calendarProgress,
    Expression<DateTime>? lastEvaluatedWeek,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (plan != null) 'plan': plan,
      if (planExpiresAt != null) 'plan_expires_at': planExpiresAt,
      if (tokenBalance != null) 'token_balance': tokenBalance,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (profileProgress != null) 'profile_progress': profileProgress,
      if (bodyProgress != null) 'body_progress': bodyProgress,
      if (calendarProgress != null) 'calendar_progress': calendarProgress,
      if (lastEvaluatedWeek != null) 'last_evaluated_week': lastEvaluatedWeek,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RewardStatesCompanion copyWith({
    Value<int>? id,
    Value<String>? plan,
    Value<DateTime?>? planExpiresAt,
    Value<int>? tokenBalance,
    Value<int>? currentStreak,
    Value<int>? profileProgress,
    Value<int>? bodyProgress,
    Value<int>? calendarProgress,
    Value<DateTime?>? lastEvaluatedWeek,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RewardStatesCompanion(
      id: id ?? this.id,
      plan: plan ?? this.plan,
      planExpiresAt: planExpiresAt ?? this.planExpiresAt,
      tokenBalance: tokenBalance ?? this.tokenBalance,
      currentStreak: currentStreak ?? this.currentStreak,
      profileProgress: profileProgress ?? this.profileProgress,
      bodyProgress: bodyProgress ?? this.bodyProgress,
      calendarProgress: calendarProgress ?? this.calendarProgress,
      lastEvaluatedWeek: lastEvaluatedWeek ?? this.lastEvaluatedWeek,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (plan.present) {
      map['plan'] = Variable<String>(plan.value);
    }
    if (planExpiresAt.present) {
      map['plan_expires_at'] = Variable<DateTime>(planExpiresAt.value);
    }
    if (tokenBalance.present) {
      map['token_balance'] = Variable<int>(tokenBalance.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (profileProgress.present) {
      map['profile_progress'] = Variable<int>(profileProgress.value);
    }
    if (bodyProgress.present) {
      map['body_progress'] = Variable<int>(bodyProgress.value);
    }
    if (calendarProgress.present) {
      map['calendar_progress'] = Variable<int>(calendarProgress.value);
    }
    if (lastEvaluatedWeek.present) {
      map['last_evaluated_week'] = Variable<DateTime>(lastEvaluatedWeek.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RewardStatesCompanion(')
          ..write('id: $id, ')
          ..write('plan: $plan, ')
          ..write('planExpiresAt: $planExpiresAt, ')
          ..write('tokenBalance: $tokenBalance, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('profileProgress: $profileProgress, ')
          ..write('bodyProgress: $bodyProgress, ')
          ..write('calendarProgress: $calendarProgress, ')
          ..write('lastEvaluatedWeek: $lastEvaluatedWeek, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RewardEventsTable extends RewardEvents
    with TableInfo<$RewardEventsTable, RewardEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RewardEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _badgeKeyMeta = const VerificationMeta(
    'badgeKey',
  );
  @override
  late final GeneratedColumn<String> badgeKey = GeneratedColumn<String>(
    'badge_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredOnMeta = const VerificationMeta(
    'occurredOn',
  );
  @override
  late final GeneratedColumn<DateTime> occurredOn = GeneratedColumn<DateTime>(
    'occurred_on',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    badgeKey,
    amount,
    occurredOn,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reward_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<RewardEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('badge_key')) {
      context.handle(
        _badgeKeyMeta,
        badgeKey.isAcceptableOrUnknown(data['badge_key']!, _badgeKeyMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('occurred_on')) {
      context.handle(
        _occurredOnMeta,
        occurredOn.isAcceptableOrUnknown(data['occurred_on']!, _occurredOnMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredOnMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RewardEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RewardEventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      badgeKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}badge_key'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      occurredOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_on'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RewardEventsTable createAlias(String alias) {
    return $RewardEventsTable(attachedDatabase, alias);
  }
}

class RewardEventRow extends DataClass implements Insertable<RewardEventRow> {
  final String id;
  final String? badgeKey;
  final int amount;
  final DateTime occurredOn;
  final DateTime createdAt;
  const RewardEventRow({
    required this.id,
    this.badgeKey,
    required this.amount,
    required this.occurredOn,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || badgeKey != null) {
      map['badge_key'] = Variable<String>(badgeKey);
    }
    map['amount'] = Variable<int>(amount);
    map['occurred_on'] = Variable<DateTime>(occurredOn);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RewardEventsCompanion toCompanion(bool nullToAbsent) {
    return RewardEventsCompanion(
      id: Value(id),
      badgeKey: badgeKey == null && nullToAbsent
          ? const Value.absent()
          : Value(badgeKey),
      amount: Value(amount),
      occurredOn: Value(occurredOn),
      createdAt: Value(createdAt),
    );
  }

  factory RewardEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RewardEventRow(
      id: serializer.fromJson<String>(json['id']),
      badgeKey: serializer.fromJson<String?>(json['badgeKey']),
      amount: serializer.fromJson<int>(json['amount']),
      occurredOn: serializer.fromJson<DateTime>(json['occurredOn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'badgeKey': serializer.toJson<String?>(badgeKey),
      'amount': serializer.toJson<int>(amount),
      'occurredOn': serializer.toJson<DateTime>(occurredOn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RewardEventRow copyWith({
    String? id,
    Value<String?> badgeKey = const Value.absent(),
    int? amount,
    DateTime? occurredOn,
    DateTime? createdAt,
  }) => RewardEventRow(
    id: id ?? this.id,
    badgeKey: badgeKey.present ? badgeKey.value : this.badgeKey,
    amount: amount ?? this.amount,
    occurredOn: occurredOn ?? this.occurredOn,
    createdAt: createdAt ?? this.createdAt,
  );
  RewardEventRow copyWithCompanion(RewardEventsCompanion data) {
    return RewardEventRow(
      id: data.id.present ? data.id.value : this.id,
      badgeKey: data.badgeKey.present ? data.badgeKey.value : this.badgeKey,
      amount: data.amount.present ? data.amount.value : this.amount,
      occurredOn: data.occurredOn.present
          ? data.occurredOn.value
          : this.occurredOn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RewardEventRow(')
          ..write('id: $id, ')
          ..write('badgeKey: $badgeKey, ')
          ..write('amount: $amount, ')
          ..write('occurredOn: $occurredOn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, badgeKey, amount, occurredOn, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RewardEventRow &&
          other.id == this.id &&
          other.badgeKey == this.badgeKey &&
          other.amount == this.amount &&
          other.occurredOn == this.occurredOn &&
          other.createdAt == this.createdAt);
}

class RewardEventsCompanion extends UpdateCompanion<RewardEventRow> {
  final Value<String> id;
  final Value<String?> badgeKey;
  final Value<int> amount;
  final Value<DateTime> occurredOn;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RewardEventsCompanion({
    this.id = const Value.absent(),
    this.badgeKey = const Value.absent(),
    this.amount = const Value.absent(),
    this.occurredOn = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RewardEventsCompanion.insert({
    required String id,
    this.badgeKey = const Value.absent(),
    required int amount,
    required DateTime occurredOn,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       amount = Value(amount),
       occurredOn = Value(occurredOn),
       createdAt = Value(createdAt);
  static Insertable<RewardEventRow> custom({
    Expression<String>? id,
    Expression<String>? badgeKey,
    Expression<int>? amount,
    Expression<DateTime>? occurredOn,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (badgeKey != null) 'badge_key': badgeKey,
      if (amount != null) 'amount': amount,
      if (occurredOn != null) 'occurred_on': occurredOn,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RewardEventsCompanion copyWith({
    Value<String>? id,
    Value<String?>? badgeKey,
    Value<int>? amount,
    Value<DateTime>? occurredOn,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RewardEventsCompanion(
      id: id ?? this.id,
      badgeKey: badgeKey ?? this.badgeKey,
      amount: amount ?? this.amount,
      occurredOn: occurredOn ?? this.occurredOn,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (badgeKey.present) {
      map['badge_key'] = Variable<String>(badgeKey.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (occurredOn.present) {
      map['occurred_on'] = Variable<DateTime>(occurredOn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RewardEventsCompanion(')
          ..write('id: $id, ')
          ..write('badgeKey: $badgeKey, ')
          ..write('amount: $amount, ')
          ..write('occurredOn: $occurredOn, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FeatureUnlocksTable extends FeatureUnlocks
    with TableInfo<$FeatureUnlocksTable, FeatureUnlockRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeatureUnlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _featureKeyMeta = const VerificationMeta(
    'featureKey',
  );
  @override
  late final GeneratedColumn<String> featureKey = GeneratedColumn<String>(
    'feature_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unlockedUntilMeta = const VerificationMeta(
    'unlockedUntil',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedUntil =
      GeneratedColumn<DateTime>(
        'unlocked_until',
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
  @override
  List<GeneratedColumn> get $columns => [featureKey, unlockedUntil, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feature_unlocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeatureUnlockRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('feature_key')) {
      context.handle(
        _featureKeyMeta,
        featureKey.isAcceptableOrUnknown(data['feature_key']!, _featureKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_featureKeyMeta);
    }
    if (data.containsKey('unlocked_until')) {
      context.handle(
        _unlockedUntilMeta,
        unlockedUntil.isAcceptableOrUnknown(
          data['unlocked_until']!,
          _unlockedUntilMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unlockedUntilMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {featureKey};
  @override
  FeatureUnlockRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeatureUnlockRow(
      featureKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feature_key'],
      )!,
      unlockedUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_until'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FeatureUnlocksTable createAlias(String alias) {
    return $FeatureUnlocksTable(attachedDatabase, alias);
  }
}

class FeatureUnlockRow extends DataClass
    implements Insertable<FeatureUnlockRow> {
  final String featureKey;
  final DateTime unlockedUntil;
  final DateTime updatedAt;
  const FeatureUnlockRow({
    required this.featureKey,
    required this.unlockedUntil,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['feature_key'] = Variable<String>(featureKey);
    map['unlocked_until'] = Variable<DateTime>(unlockedUntil);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FeatureUnlocksCompanion toCompanion(bool nullToAbsent) {
    return FeatureUnlocksCompanion(
      featureKey: Value(featureKey),
      unlockedUntil: Value(unlockedUntil),
      updatedAt: Value(updatedAt),
    );
  }

  factory FeatureUnlockRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeatureUnlockRow(
      featureKey: serializer.fromJson<String>(json['featureKey']),
      unlockedUntil: serializer.fromJson<DateTime>(json['unlockedUntil']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'featureKey': serializer.toJson<String>(featureKey),
      'unlockedUntil': serializer.toJson<DateTime>(unlockedUntil),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FeatureUnlockRow copyWith({
    String? featureKey,
    DateTime? unlockedUntil,
    DateTime? updatedAt,
  }) => FeatureUnlockRow(
    featureKey: featureKey ?? this.featureKey,
    unlockedUntil: unlockedUntil ?? this.unlockedUntil,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FeatureUnlockRow copyWithCompanion(FeatureUnlocksCompanion data) {
    return FeatureUnlockRow(
      featureKey: data.featureKey.present
          ? data.featureKey.value
          : this.featureKey,
      unlockedUntil: data.unlockedUntil.present
          ? data.unlockedUntil.value
          : this.unlockedUntil,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeatureUnlockRow(')
          ..write('featureKey: $featureKey, ')
          ..write('unlockedUntil: $unlockedUntil, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(featureKey, unlockedUntil, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeatureUnlockRow &&
          other.featureKey == this.featureKey &&
          other.unlockedUntil == this.unlockedUntil &&
          other.updatedAt == this.updatedAt);
}

class FeatureUnlocksCompanion extends UpdateCompanion<FeatureUnlockRow> {
  final Value<String> featureKey;
  final Value<DateTime> unlockedUntil;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FeatureUnlocksCompanion({
    this.featureKey = const Value.absent(),
    this.unlockedUntil = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeatureUnlocksCompanion.insert({
    required String featureKey,
    required DateTime unlockedUntil,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : featureKey = Value(featureKey),
       unlockedUntil = Value(unlockedUntil),
       updatedAt = Value(updatedAt);
  static Insertable<FeatureUnlockRow> custom({
    Expression<String>? featureKey,
    Expression<DateTime>? unlockedUntil,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (featureKey != null) 'feature_key': featureKey,
      if (unlockedUntil != null) 'unlocked_until': unlockedUntil,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeatureUnlocksCompanion copyWith({
    Value<String>? featureKey,
    Value<DateTime>? unlockedUntil,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FeatureUnlocksCompanion(
      featureKey: featureKey ?? this.featureKey,
      unlockedUntil: unlockedUntil ?? this.unlockedUntil,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (featureKey.present) {
      map['feature_key'] = Variable<String>(featureKey.value);
    }
    if (unlockedUntil.present) {
      map['unlocked_until'] = Variable<DateTime>(unlockedUntil.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeatureUnlocksCompanion(')
          ..write('featureKey: $featureKey, ')
          ..write('unlockedUntil: $unlockedUntil, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomHabitOrganEffectsTable extends CustomHabitOrganEffects
    with TableInfo<$CustomHabitOrganEffectsTable, CustomHabitOrganEffectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomHabitOrganEffectsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _thumbUpPointsMeta = const VerificationMeta(
    'thumbUpPoints',
  );
  @override
  late final GeneratedColumn<double> thumbUpPoints = GeneratedColumn<double>(
    'thumb_up_points',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _thumbDownPointsMeta = const VerificationMeta(
    'thumbDownPoints',
  );
  @override
  late final GeneratedColumn<double> thumbDownPoints = GeneratedColumn<double>(
    'thumb_down_points',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    habitId,
    partKey,
    thumbUpPoints,
    thumbDownPoints,
    updatedAt,
    syncStatus,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_habit_organ_effects';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomHabitOrganEffectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('part_key')) {
      context.handle(
        _partKeyMeta,
        partKey.isAcceptableOrUnknown(data['part_key']!, _partKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_partKeyMeta);
    }
    if (data.containsKey('thumb_up_points')) {
      context.handle(
        _thumbUpPointsMeta,
        thumbUpPoints.isAcceptableOrUnknown(
          data['thumb_up_points']!,
          _thumbUpPointsMeta,
        ),
      );
    }
    if (data.containsKey('thumb_down_points')) {
      context.handle(
        _thumbDownPointsMeta,
        thumbDownPoints.isAcceptableOrUnknown(
          data['thumb_down_points']!,
          _thumbDownPointsMeta,
        ),
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
  Set<GeneratedColumn> get $primaryKey => {habitId, partKey};
  @override
  CustomHabitOrganEffectRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomHabitOrganEffectRow(
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      partKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_key'],
      )!,
      thumbUpPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}thumb_up_points'],
      )!,
      thumbDownPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}thumb_down_points'],
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
  $CustomHabitOrganEffectsTable createAlias(String alias) {
    return $CustomHabitOrganEffectsTable(attachedDatabase, alias);
  }
}

class CustomHabitOrganEffectRow extends DataClass
    implements Insertable<CustomHabitOrganEffectRow> {
  final String habitId;
  final String partKey;
  final double thumbUpPoints;
  final double thumbDownPoints;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  const CustomHabitOrganEffectRow({
    required this.habitId,
    required this.partKey,
    required this.thumbUpPoints,
    required this.thumbDownPoints,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['habit_id'] = Variable<String>(habitId);
    map['part_key'] = Variable<String>(partKey);
    map['thumb_up_points'] = Variable<double>(thumbUpPoints);
    map['thumb_down_points'] = Variable<double>(thumbDownPoints);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  CustomHabitOrganEffectsCompanion toCompanion(bool nullToAbsent) {
    return CustomHabitOrganEffectsCompanion(
      habitId: Value(habitId),
      partKey: Value(partKey),
      thumbUpPoints: Value(thumbUpPoints),
      thumbDownPoints: Value(thumbDownPoints),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory CustomHabitOrganEffectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomHabitOrganEffectRow(
      habitId: serializer.fromJson<String>(json['habitId']),
      partKey: serializer.fromJson<String>(json['partKey']),
      thumbUpPoints: serializer.fromJson<double>(json['thumbUpPoints']),
      thumbDownPoints: serializer.fromJson<double>(json['thumbDownPoints']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'habitId': serializer.toJson<String>(habitId),
      'partKey': serializer.toJson<String>(partKey),
      'thumbUpPoints': serializer.toJson<double>(thumbUpPoints),
      'thumbDownPoints': serializer.toJson<double>(thumbDownPoints),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  CustomHabitOrganEffectRow copyWith({
    String? habitId,
    String? partKey,
    double? thumbUpPoints,
    double? thumbDownPoints,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
  }) => CustomHabitOrganEffectRow(
    habitId: habitId ?? this.habitId,
    partKey: partKey ?? this.partKey,
    thumbUpPoints: thumbUpPoints ?? this.thumbUpPoints,
    thumbDownPoints: thumbDownPoints ?? this.thumbDownPoints,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  CustomHabitOrganEffectRow copyWithCompanion(
    CustomHabitOrganEffectsCompanion data,
  ) {
    return CustomHabitOrganEffectRow(
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      partKey: data.partKey.present ? data.partKey.value : this.partKey,
      thumbUpPoints: data.thumbUpPoints.present
          ? data.thumbUpPoints.value
          : this.thumbUpPoints,
      thumbDownPoints: data.thumbDownPoints.present
          ? data.thumbDownPoints.value
          : this.thumbDownPoints,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomHabitOrganEffectRow(')
          ..write('habitId: $habitId, ')
          ..write('partKey: $partKey, ')
          ..write('thumbUpPoints: $thumbUpPoints, ')
          ..write('thumbDownPoints: $thumbDownPoints, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    habitId,
    partKey,
    thumbUpPoints,
    thumbDownPoints,
    updatedAt,
    syncStatus,
    remoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomHabitOrganEffectRow &&
          other.habitId == this.habitId &&
          other.partKey == this.partKey &&
          other.thumbUpPoints == this.thumbUpPoints &&
          other.thumbDownPoints == this.thumbDownPoints &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId);
}

class CustomHabitOrganEffectsCompanion
    extends UpdateCompanion<CustomHabitOrganEffectRow> {
  final Value<String> habitId;
  final Value<String> partKey;
  final Value<double> thumbUpPoints;
  final Value<double> thumbDownPoints;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> rowid;
  const CustomHabitOrganEffectsCompanion({
    this.habitId = const Value.absent(),
    this.partKey = const Value.absent(),
    this.thumbUpPoints = const Value.absent(),
    this.thumbDownPoints = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomHabitOrganEffectsCompanion.insert({
    required String habitId,
    required String partKey,
    this.thumbUpPoints = const Value.absent(),
    this.thumbDownPoints = const Value.absent(),
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : habitId = Value(habitId),
       partKey = Value(partKey),
       updatedAt = Value(updatedAt);
  static Insertable<CustomHabitOrganEffectRow> custom({
    Expression<String>? habitId,
    Expression<String>? partKey,
    Expression<double>? thumbUpPoints,
    Expression<double>? thumbDownPoints,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (habitId != null) 'habit_id': habitId,
      if (partKey != null) 'part_key': partKey,
      if (thumbUpPoints != null) 'thumb_up_points': thumbUpPoints,
      if (thumbDownPoints != null) 'thumb_down_points': thumbDownPoints,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomHabitOrganEffectsCompanion copyWith({
    Value<String>? habitId,
    Value<String>? partKey,
    Value<double>? thumbUpPoints,
    Value<double>? thumbDownPoints,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<int>? rowid,
  }) {
    return CustomHabitOrganEffectsCompanion(
      habitId: habitId ?? this.habitId,
      partKey: partKey ?? this.partKey,
      thumbUpPoints: thumbUpPoints ?? this.thumbUpPoints,
      thumbDownPoints: thumbDownPoints ?? this.thumbDownPoints,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (partKey.present) {
      map['part_key'] = Variable<String>(partKey.value);
    }
    if (thumbUpPoints.present) {
      map['thumb_up_points'] = Variable<double>(thumbUpPoints.value);
    }
    if (thumbDownPoints.present) {
      map['thumb_down_points'] = Variable<double>(thumbDownPoints.value);
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
    return (StringBuffer('CustomHabitOrganEffectsCompanion(')
          ..write('habitId: $habitId, ')
          ..write('partKey: $partKey, ')
          ..write('thumbUpPoints: $thumbUpPoints, ')
          ..write('thumbDownPoints: $thumbDownPoints, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StandardHabitOrganEffectsTable extends StandardHabitOrganEffects
    with
        TableInfo<
          $StandardHabitOrganEffectsTable,
          StandardHabitOrganEffectRow
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StandardHabitOrganEffectsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _thumbUpPointsMeta = const VerificationMeta(
    'thumbUpPoints',
  );
  @override
  late final GeneratedColumn<double> thumbUpPoints = GeneratedColumn<double>(
    'thumb_up_points',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _thumbDownPointsMeta = const VerificationMeta(
    'thumbDownPoints',
  );
  @override
  late final GeneratedColumn<double> thumbDownPoints = GeneratedColumn<double>(
    'thumb_down_points',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    habitId,
    partKey,
    thumbUpPoints,
    thumbDownPoints,
    updatedAt,
    syncStatus,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'standard_habit_organ_effects';
  @override
  VerificationContext validateIntegrity(
    Insertable<StandardHabitOrganEffectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('part_key')) {
      context.handle(
        _partKeyMeta,
        partKey.isAcceptableOrUnknown(data['part_key']!, _partKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_partKeyMeta);
    }
    if (data.containsKey('thumb_up_points')) {
      context.handle(
        _thumbUpPointsMeta,
        thumbUpPoints.isAcceptableOrUnknown(
          data['thumb_up_points']!,
          _thumbUpPointsMeta,
        ),
      );
    }
    if (data.containsKey('thumb_down_points')) {
      context.handle(
        _thumbDownPointsMeta,
        thumbDownPoints.isAcceptableOrUnknown(
          data['thumb_down_points']!,
          _thumbDownPointsMeta,
        ),
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
  Set<GeneratedColumn> get $primaryKey => {habitId, partKey};
  @override
  StandardHabitOrganEffectRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StandardHabitOrganEffectRow(
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      partKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_key'],
      )!,
      thumbUpPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}thumb_up_points'],
      )!,
      thumbDownPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}thumb_down_points'],
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
  $StandardHabitOrganEffectsTable createAlias(String alias) {
    return $StandardHabitOrganEffectsTable(attachedDatabase, alias);
  }
}

class StandardHabitOrganEffectRow extends DataClass
    implements Insertable<StandardHabitOrganEffectRow> {
  final String habitId;
  final String partKey;
  final double thumbUpPoints;
  final double thumbDownPoints;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  const StandardHabitOrganEffectRow({
    required this.habitId,
    required this.partKey,
    required this.thumbUpPoints,
    required this.thumbDownPoints,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['habit_id'] = Variable<String>(habitId);
    map['part_key'] = Variable<String>(partKey);
    map['thumb_up_points'] = Variable<double>(thumbUpPoints);
    map['thumb_down_points'] = Variable<double>(thumbDownPoints);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  StandardHabitOrganEffectsCompanion toCompanion(bool nullToAbsent) {
    return StandardHabitOrganEffectsCompanion(
      habitId: Value(habitId),
      partKey: Value(partKey),
      thumbUpPoints: Value(thumbUpPoints),
      thumbDownPoints: Value(thumbDownPoints),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory StandardHabitOrganEffectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StandardHabitOrganEffectRow(
      habitId: serializer.fromJson<String>(json['habitId']),
      partKey: serializer.fromJson<String>(json['partKey']),
      thumbUpPoints: serializer.fromJson<double>(json['thumbUpPoints']),
      thumbDownPoints: serializer.fromJson<double>(json['thumbDownPoints']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'habitId': serializer.toJson<String>(habitId),
      'partKey': serializer.toJson<String>(partKey),
      'thumbUpPoints': serializer.toJson<double>(thumbUpPoints),
      'thumbDownPoints': serializer.toJson<double>(thumbDownPoints),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  StandardHabitOrganEffectRow copyWith({
    String? habitId,
    String? partKey,
    double? thumbUpPoints,
    double? thumbDownPoints,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
  }) => StandardHabitOrganEffectRow(
    habitId: habitId ?? this.habitId,
    partKey: partKey ?? this.partKey,
    thumbUpPoints: thumbUpPoints ?? this.thumbUpPoints,
    thumbDownPoints: thumbDownPoints ?? this.thumbDownPoints,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  StandardHabitOrganEffectRow copyWithCompanion(
    StandardHabitOrganEffectsCompanion data,
  ) {
    return StandardHabitOrganEffectRow(
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      partKey: data.partKey.present ? data.partKey.value : this.partKey,
      thumbUpPoints: data.thumbUpPoints.present
          ? data.thumbUpPoints.value
          : this.thumbUpPoints,
      thumbDownPoints: data.thumbDownPoints.present
          ? data.thumbDownPoints.value
          : this.thumbDownPoints,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StandardHabitOrganEffectRow(')
          ..write('habitId: $habitId, ')
          ..write('partKey: $partKey, ')
          ..write('thumbUpPoints: $thumbUpPoints, ')
          ..write('thumbDownPoints: $thumbDownPoints, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    habitId,
    partKey,
    thumbUpPoints,
    thumbDownPoints,
    updatedAt,
    syncStatus,
    remoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StandardHabitOrganEffectRow &&
          other.habitId == this.habitId &&
          other.partKey == this.partKey &&
          other.thumbUpPoints == this.thumbUpPoints &&
          other.thumbDownPoints == this.thumbDownPoints &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId);
}

class StandardHabitOrganEffectsCompanion
    extends UpdateCompanion<StandardHabitOrganEffectRow> {
  final Value<String> habitId;
  final Value<String> partKey;
  final Value<double> thumbUpPoints;
  final Value<double> thumbDownPoints;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> rowid;
  const StandardHabitOrganEffectsCompanion({
    this.habitId = const Value.absent(),
    this.partKey = const Value.absent(),
    this.thumbUpPoints = const Value.absent(),
    this.thumbDownPoints = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StandardHabitOrganEffectsCompanion.insert({
    required String habitId,
    required String partKey,
    this.thumbUpPoints = const Value.absent(),
    this.thumbDownPoints = const Value.absent(),
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : habitId = Value(habitId),
       partKey = Value(partKey),
       updatedAt = Value(updatedAt);
  static Insertable<StandardHabitOrganEffectRow> custom({
    Expression<String>? habitId,
    Expression<String>? partKey,
    Expression<double>? thumbUpPoints,
    Expression<double>? thumbDownPoints,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (habitId != null) 'habit_id': habitId,
      if (partKey != null) 'part_key': partKey,
      if (thumbUpPoints != null) 'thumb_up_points': thumbUpPoints,
      if (thumbDownPoints != null) 'thumb_down_points': thumbDownPoints,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StandardHabitOrganEffectsCompanion copyWith({
    Value<String>? habitId,
    Value<String>? partKey,
    Value<double>? thumbUpPoints,
    Value<double>? thumbDownPoints,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<int>? rowid,
  }) {
    return StandardHabitOrganEffectsCompanion(
      habitId: habitId ?? this.habitId,
      partKey: partKey ?? this.partKey,
      thumbUpPoints: thumbUpPoints ?? this.thumbUpPoints,
      thumbDownPoints: thumbDownPoints ?? this.thumbDownPoints,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (partKey.present) {
      map['part_key'] = Variable<String>(partKey.value);
    }
    if (thumbUpPoints.present) {
      map['thumb_up_points'] = Variable<double>(thumbUpPoints.value);
    }
    if (thumbDownPoints.present) {
      map['thumb_down_points'] = Variable<double>(thumbDownPoints.value);
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
    return (StringBuffer('StandardHabitOrganEffectsCompanion(')
          ..write('habitId: $habitId, ')
          ..write('partKey: $partKey, ')
          ..write('thumbUpPoints: $thumbUpPoints, ')
          ..write('thumbDownPoints: $thumbDownPoints, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NumericalHabitEntriesTable extends NumericalHabitEntries
    with TableInfo<$NumericalHabitEntriesTable, NumericalHabitEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NumericalHabitEntriesTable(this.attachedDatabase, [this._alias]);
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
  late final GeneratedColumn<int> value = GeneratedColumn<int>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outcomeFactorMeta = const VerificationMeta(
    'outcomeFactor',
  );
  @override
  late final GeneratedColumn<double> outcomeFactor = GeneratedColumn<double>(
    'outcome_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualDidHabitMeta = const VerificationMeta(
    'actualDidHabit',
  );
  @override
  late final GeneratedColumn<bool> actualDidHabit = GeneratedColumn<bool>(
    'actual_did_habit',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("actual_did_habit" IN (0, 1))',
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
    id,
    habitId,
    localDay,
    value,
    outcomeFactor,
    actualDidHabit,
    updatedAt,
    syncStatus,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'numerical_habit_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<NumericalHabitEntryRow> instance, {
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
    }
    if (data.containsKey('outcome_factor')) {
      context.handle(
        _outcomeFactorMeta,
        outcomeFactor.isAcceptableOrUnknown(
          data['outcome_factor']!,
          _outcomeFactorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_outcomeFactorMeta);
    }
    if (data.containsKey('actual_did_habit')) {
      context.handle(
        _actualDidHabitMeta,
        actualDidHabit.isAcceptableOrUnknown(
          data['actual_did_habit']!,
          _actualDidHabitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualDidHabitMeta);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NumericalHabitEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NumericalHabitEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      localDay: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}local_day'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value'],
      ),
      outcomeFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}outcome_factor'],
      )!,
      actualDidHabit: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}actual_did_habit'],
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
  $NumericalHabitEntriesTable createAlias(String alias) {
    return $NumericalHabitEntriesTable(attachedDatabase, alias);
  }
}

class NumericalHabitEntryRow extends DataClass
    implements Insertable<NumericalHabitEntryRow> {
  final String id;
  final String habitId;
  final DateTime localDay;
  final int? value;
  final double outcomeFactor;
  final bool actualDidHabit;
  final DateTime updatedAt;
  final String syncStatus;
  final String? remoteId;
  const NumericalHabitEntryRow({
    required this.id,
    required this.habitId,
    required this.localDay,
    this.value,
    required this.outcomeFactor,
    required this.actualDidHabit,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['local_day'] = Variable<DateTime>(localDay);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<int>(value);
    }
    map['outcome_factor'] = Variable<double>(outcomeFactor);
    map['actual_did_habit'] = Variable<bool>(actualDidHabit);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  NumericalHabitEntriesCompanion toCompanion(bool nullToAbsent) {
    return NumericalHabitEntriesCompanion(
      id: Value(id),
      habitId: Value(habitId),
      localDay: Value(localDay),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
      outcomeFactor: Value(outcomeFactor),
      actualDidHabit: Value(actualDidHabit),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory NumericalHabitEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NumericalHabitEntryRow(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      localDay: serializer.fromJson<DateTime>(json['localDay']),
      value: serializer.fromJson<int?>(json['value']),
      outcomeFactor: serializer.fromJson<double>(json['outcomeFactor']),
      actualDidHabit: serializer.fromJson<bool>(json['actualDidHabit']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'localDay': serializer.toJson<DateTime>(localDay),
      'value': serializer.toJson<int?>(value),
      'outcomeFactor': serializer.toJson<double>(outcomeFactor),
      'actualDidHabit': serializer.toJson<bool>(actualDidHabit),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  NumericalHabitEntryRow copyWith({
    String? id,
    String? habitId,
    DateTime? localDay,
    Value<int?> value = const Value.absent(),
    double? outcomeFactor,
    bool? actualDidHabit,
    DateTime? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
  }) => NumericalHabitEntryRow(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    localDay: localDay ?? this.localDay,
    value: value.present ? value.value : this.value,
    outcomeFactor: outcomeFactor ?? this.outcomeFactor,
    actualDidHabit: actualDidHabit ?? this.actualDidHabit,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  NumericalHabitEntryRow copyWithCompanion(
    NumericalHabitEntriesCompanion data,
  ) {
    return NumericalHabitEntryRow(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      localDay: data.localDay.present ? data.localDay.value : this.localDay,
      value: data.value.present ? data.value.value : this.value,
      outcomeFactor: data.outcomeFactor.present
          ? data.outcomeFactor.value
          : this.outcomeFactor,
      actualDidHabit: data.actualDidHabit.present
          ? data.actualDidHabit.value
          : this.actualDidHabit,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NumericalHabitEntryRow(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('localDay: $localDay, ')
          ..write('value: $value, ')
          ..write('outcomeFactor: $outcomeFactor, ')
          ..write('actualDidHabit: $actualDidHabit, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    habitId,
    localDay,
    value,
    outcomeFactor,
    actualDidHabit,
    updatedAt,
    syncStatus,
    remoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NumericalHabitEntryRow &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.localDay == this.localDay &&
          other.value == this.value &&
          other.outcomeFactor == this.outcomeFactor &&
          other.actualDidHabit == this.actualDidHabit &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId);
}

class NumericalHabitEntriesCompanion
    extends UpdateCompanion<NumericalHabitEntryRow> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<DateTime> localDay;
  final Value<int?> value;
  final Value<double> outcomeFactor;
  final Value<bool> actualDidHabit;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> rowid;
  const NumericalHabitEntriesCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.localDay = const Value.absent(),
    this.value = const Value.absent(),
    this.outcomeFactor = const Value.absent(),
    this.actualDidHabit = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NumericalHabitEntriesCompanion.insert({
    required String id,
    required String habitId,
    required DateTime localDay,
    this.value = const Value.absent(),
    required double outcomeFactor,
    required bool actualDidHabit,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       habitId = Value(habitId),
       localDay = Value(localDay),
       outcomeFactor = Value(outcomeFactor),
       actualDidHabit = Value(actualDidHabit),
       updatedAt = Value(updatedAt);
  static Insertable<NumericalHabitEntryRow> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<DateTime>? localDay,
    Expression<int>? value,
    Expression<double>? outcomeFactor,
    Expression<bool>? actualDidHabit,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (localDay != null) 'local_day': localDay,
      if (value != null) 'value': value,
      if (outcomeFactor != null) 'outcome_factor': outcomeFactor,
      if (actualDidHabit != null) 'actual_did_habit': actualDidHabit,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NumericalHabitEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? habitId,
    Value<DateTime>? localDay,
    Value<int?>? value,
    Value<double>? outcomeFactor,
    Value<bool>? actualDidHabit,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<int>? rowid,
  }) {
    return NumericalHabitEntriesCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      localDay: localDay ?? this.localDay,
      value: value ?? this.value,
      outcomeFactor: outcomeFactor ?? this.outcomeFactor,
      actualDidHabit: actualDidHabit ?? this.actualDidHabit,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
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
    if (localDay.present) {
      map['local_day'] = Variable<DateTime>(localDay.value);
    }
    if (value.present) {
      map['value'] = Variable<int>(value.value);
    }
    if (outcomeFactor.present) {
      map['outcome_factor'] = Variable<double>(outcomeFactor.value);
    }
    if (actualDidHabit.present) {
      map['actual_did_habit'] = Variable<bool>(actualDidHabit.value);
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
    return (StringBuffer('NumericalHabitEntriesCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('localDay: $localDay, ')
          ..write('value: $value, ')
          ..write('outcomeFactor: $outcomeFactor, ')
          ..write('actualDidHabit: $actualDidHabit, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NumericalBodyContributionsTable extends NumericalBodyContributions
    with
        TableInfo<
          $NumericalBodyContributionsTable,
          NumericalBodyContributionRow
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NumericalBodyContributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES numerical_habit_entries (id)',
    ),
  );
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
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<double> points = GeneratedColumn<double>(
    'points',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [entryId, partKey, points];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'numerical_body_contributions';
  @override
  VerificationContext validateIntegrity(
    Insertable<NumericalBodyContributionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('part_key')) {
      context.handle(
        _partKeyMeta,
        partKey.isAcceptableOrUnknown(data['part_key']!, _partKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_partKeyMeta);
    }
    if (data.containsKey('points')) {
      context.handle(
        _pointsMeta,
        points.isAcceptableOrUnknown(data['points']!, _pointsMeta),
      );
    } else if (isInserting) {
      context.missing(_pointsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entryId, partKey};
  @override
  NumericalBodyContributionRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NumericalBodyContributionRow(
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
      partKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_key'],
      )!,
      points: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}points'],
      )!,
    );
  }

  @override
  $NumericalBodyContributionsTable createAlias(String alias) {
    return $NumericalBodyContributionsTable(attachedDatabase, alias);
  }
}

class NumericalBodyContributionRow extends DataClass
    implements Insertable<NumericalBodyContributionRow> {
  final String entryId;
  final String partKey;
  final double points;
  const NumericalBodyContributionRow({
    required this.entryId,
    required this.partKey,
    required this.points,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entry_id'] = Variable<String>(entryId);
    map['part_key'] = Variable<String>(partKey);
    map['points'] = Variable<double>(points);
    return map;
  }

  NumericalBodyContributionsCompanion toCompanion(bool nullToAbsent) {
    return NumericalBodyContributionsCompanion(
      entryId: Value(entryId),
      partKey: Value(partKey),
      points: Value(points),
    );
  }

  factory NumericalBodyContributionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NumericalBodyContributionRow(
      entryId: serializer.fromJson<String>(json['entryId']),
      partKey: serializer.fromJson<String>(json['partKey']),
      points: serializer.fromJson<double>(json['points']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entryId': serializer.toJson<String>(entryId),
      'partKey': serializer.toJson<String>(partKey),
      'points': serializer.toJson<double>(points),
    };
  }

  NumericalBodyContributionRow copyWith({
    String? entryId,
    String? partKey,
    double? points,
  }) => NumericalBodyContributionRow(
    entryId: entryId ?? this.entryId,
    partKey: partKey ?? this.partKey,
    points: points ?? this.points,
  );
  NumericalBodyContributionRow copyWithCompanion(
    NumericalBodyContributionsCompanion data,
  ) {
    return NumericalBodyContributionRow(
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      partKey: data.partKey.present ? data.partKey.value : this.partKey,
      points: data.points.present ? data.points.value : this.points,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NumericalBodyContributionRow(')
          ..write('entryId: $entryId, ')
          ..write('partKey: $partKey, ')
          ..write('points: $points')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entryId, partKey, points);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NumericalBodyContributionRow &&
          other.entryId == this.entryId &&
          other.partKey == this.partKey &&
          other.points == this.points);
}

class NumericalBodyContributionsCompanion
    extends UpdateCompanion<NumericalBodyContributionRow> {
  final Value<String> entryId;
  final Value<String> partKey;
  final Value<double> points;
  final Value<int> rowid;
  const NumericalBodyContributionsCompanion({
    this.entryId = const Value.absent(),
    this.partKey = const Value.absent(),
    this.points = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NumericalBodyContributionsCompanion.insert({
    required String entryId,
    required String partKey,
    required double points,
    this.rowid = const Value.absent(),
  }) : entryId = Value(entryId),
       partKey = Value(partKey),
       points = Value(points);
  static Insertable<NumericalBodyContributionRow> custom({
    Expression<String>? entryId,
    Expression<String>? partKey,
    Expression<double>? points,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entryId != null) 'entry_id': entryId,
      if (partKey != null) 'part_key': partKey,
      if (points != null) 'points': points,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NumericalBodyContributionsCompanion copyWith({
    Value<String>? entryId,
    Value<String>? partKey,
    Value<double>? points,
    Value<int>? rowid,
  }) {
    return NumericalBodyContributionsCompanion(
      entryId: entryId ?? this.entryId,
      partKey: partKey ?? this.partKey,
      points: points ?? this.points,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (partKey.present) {
      map['part_key'] = Variable<String>(partKey.value);
    }
    if (points.present) {
      map['points'] = Variable<double>(points.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NumericalBodyContributionsCompanion(')
          ..write('entryId: $entryId, ')
          ..write('partKey: $partKey, ')
          ..write('points: $points, ')
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
  late final $NamedCustomGraphsTable namedCustomGraphs =
      $NamedCustomGraphsTable(this);
  late final $NamedCustomGraphRulesTable namedCustomGraphRules =
      $NamedCustomGraphRulesTable(this);
  late final $ReductionPlansTable reductionPlans = $ReductionPlansTable(this);
  late final $GrowthPlansTable growthPlans = $GrowthPlansTable(this);
  late final $GrowthPlanEntriesTable growthPlanEntries =
      $GrowthPlanEntriesTable(this);
  late final $HabitStreaksTable habitStreaks = $HabitStreaksTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $RewardStatesTable rewardStates = $RewardStatesTable(this);
  late final $RewardEventsTable rewardEvents = $RewardEventsTable(this);
  late final $FeatureUnlocksTable featureUnlocks = $FeatureUnlocksTable(this);
  late final $CustomHabitOrganEffectsTable customHabitOrganEffects =
      $CustomHabitOrganEffectsTable(this);
  late final $StandardHabitOrganEffectsTable standardHabitOrganEffects =
      $StandardHabitOrganEffectsTable(this);
  late final $NumericalHabitEntriesTable numericalHabitEntries =
      $NumericalHabitEntriesTable(this);
  late final $NumericalBodyContributionsTable numericalBodyContributions =
      $NumericalBodyContributionsTable(this);
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
    namedCustomGraphs,
    namedCustomGraphRules,
    reductionPlans,
    growthPlans,
    growthPlanEntries,
    habitStreaks,
    appSettings,
    rewardStates,
    rewardEvents,
    featureUnlocks,
    customHabitOrganEffects,
    standardHabitOrganEffects,
    numericalHabitEntries,
    numericalBodyContributions,
  ];
}

typedef $$HabitDefinitionsTableCreateCompanionBuilder =
    HabitDefinitionsCompanion Function({
      required String id,
      required String nameKey,
      required String category,
      Value<bool> isActive,
      Value<bool> isFavorite,
      Value<bool> numericalTrackingEnabled,
      Value<int?> numericalTarget,
      Value<String?> numericalUnit,
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
      Value<bool> numericalTrackingEnabled,
      Value<int?> numericalTarget,
      Value<String?> numericalUnit,
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

  static MultiTypedResultKey<
    $NamedCustomGraphRulesTable,
    List<NamedCustomGraphRuleRow>
  >
  _namedCustomGraphRulesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.namedCustomGraphRules,
        aliasName: 'habit_definitions__id__named_custom_graph_rules__habit_id',
      );

  $$NamedCustomGraphRulesTableProcessedTableManager
  get namedCustomGraphRulesRefs {
    final manager = $$NamedCustomGraphRulesTableTableManager(
      $_db,
      $_db.namedCustomGraphRules,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _namedCustomGraphRulesRefsTable($_db),
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

  static MultiTypedResultKey<$GrowthPlansTable, List<GrowthPlanRow>>
  _growthPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.growthPlans,
    aliasName: 'habit_definitions__id__growth_plans__habit_id',
  );

  $$GrowthPlansTableProcessedTableManager get growthPlansRefs {
    final manager = $$GrowthPlansTableTableManager(
      $_db,
      $_db.growthPlans,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_growthPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HabitStreaksTable, List<HabitStreakRow>>
  _habitStreaksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitStreaks,
    aliasName: 'habit_definitions__id__habit_streaks__habit_id',
  );

  $$HabitStreaksTableProcessedTableManager get habitStreaksRefs {
    final manager = $$HabitStreaksTableTableManager(
      $_db,
      $_db.habitStreaks,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitStreaksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CustomHabitOrganEffectsTable,
    List<CustomHabitOrganEffectRow>
  >
  _customHabitOrganEffectsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.customHabitOrganEffects,
        aliasName:
            'habit_definitions__id__custom_habit_organ_effects__habit_id',
      );

  $$CustomHabitOrganEffectsTableProcessedTableManager
  get customHabitOrganEffectsRefs {
    final manager = $$CustomHabitOrganEffectsTableTableManager(
      $_db,
      $_db.customHabitOrganEffects,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _customHabitOrganEffectsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $StandardHabitOrganEffectsTable,
    List<StandardHabitOrganEffectRow>
  >
  _standardHabitOrganEffectsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.standardHabitOrganEffects,
        aliasName:
            'habit_definitions__id__standard_habit_organ_effects__habit_id',
      );

  $$StandardHabitOrganEffectsTableProcessedTableManager
  get standardHabitOrganEffectsRefs {
    final manager = $$StandardHabitOrganEffectsTableTableManager(
      $_db,
      $_db.standardHabitOrganEffects,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _standardHabitOrganEffectsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $NumericalHabitEntriesTable,
    List<NumericalHabitEntryRow>
  >
  _numericalHabitEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.numericalHabitEntries,
        aliasName: 'habit_definitions__id__numerical_habit_entries__habit_id',
      );

  $$NumericalHabitEntriesTableProcessedTableManager
  get numericalHabitEntriesRefs {
    final manager = $$NumericalHabitEntriesTableTableManager(
      $_db,
      $_db.numericalHabitEntries,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _numericalHabitEntriesRefsTable($_db),
    );
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

  ColumnFilters<bool> get numericalTrackingEnabled => $composableBuilder(
    column: $table.numericalTrackingEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numericalTarget => $composableBuilder(
    column: $table.numericalTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numericalUnit => $composableBuilder(
    column: $table.numericalUnit,
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

  Expression<bool> namedCustomGraphRulesRefs(
    Expression<bool> Function($$NamedCustomGraphRulesTableFilterComposer f) f,
  ) {
    final $$NamedCustomGraphRulesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.namedCustomGraphRules,
          getReferencedColumn: (t) => t.habitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NamedCustomGraphRulesTableFilterComposer(
                $db: $db,
                $table: $db.namedCustomGraphRules,
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

  Expression<bool> growthPlansRefs(
    Expression<bool> Function($$GrowthPlansTableFilterComposer f) f,
  ) {
    final $$GrowthPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.growthPlans,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrowthPlansTableFilterComposer(
            $db: $db,
            $table: $db.growthPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> habitStreaksRefs(
    Expression<bool> Function($$HabitStreaksTableFilterComposer f) f,
  ) {
    final $$HabitStreaksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitStreaks,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitStreaksTableFilterComposer(
            $db: $db,
            $table: $db.habitStreaks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customHabitOrganEffectsRefs(
    Expression<bool> Function($$CustomHabitOrganEffectsTableFilterComposer f) f,
  ) {
    final $$CustomHabitOrganEffectsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.customHabitOrganEffects,
          getReferencedColumn: (t) => t.habitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CustomHabitOrganEffectsTableFilterComposer(
                $db: $db,
                $table: $db.customHabitOrganEffects,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> standardHabitOrganEffectsRefs(
    Expression<bool> Function($$StandardHabitOrganEffectsTableFilterComposer f)
    f,
  ) {
    final $$StandardHabitOrganEffectsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.standardHabitOrganEffects,
          getReferencedColumn: (t) => t.habitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StandardHabitOrganEffectsTableFilterComposer(
                $db: $db,
                $table: $db.standardHabitOrganEffects,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> numericalHabitEntriesRefs(
    Expression<bool> Function($$NumericalHabitEntriesTableFilterComposer f) f,
  ) {
    final $$NumericalHabitEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.numericalHabitEntries,
          getReferencedColumn: (t) => t.habitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NumericalHabitEntriesTableFilterComposer(
                $db: $db,
                $table: $db.numericalHabitEntries,
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

  ColumnOrderings<bool> get numericalTrackingEnabled => $composableBuilder(
    column: $table.numericalTrackingEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numericalTarget => $composableBuilder(
    column: $table.numericalTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numericalUnit => $composableBuilder(
    column: $table.numericalUnit,
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

  GeneratedColumn<bool> get numericalTrackingEnabled => $composableBuilder(
    column: $table.numericalTrackingEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numericalTarget => $composableBuilder(
    column: $table.numericalTarget,
    builder: (column) => column,
  );

  GeneratedColumn<String> get numericalUnit => $composableBuilder(
    column: $table.numericalUnit,
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

  Expression<T> namedCustomGraphRulesRefs<T extends Object>(
    Expression<T> Function($$NamedCustomGraphRulesTableAnnotationComposer a) f,
  ) {
    final $$NamedCustomGraphRulesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.namedCustomGraphRules,
          getReferencedColumn: (t) => t.habitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NamedCustomGraphRulesTableAnnotationComposer(
                $db: $db,
                $table: $db.namedCustomGraphRules,
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

  Expression<T> growthPlansRefs<T extends Object>(
    Expression<T> Function($$GrowthPlansTableAnnotationComposer a) f,
  ) {
    final $$GrowthPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.growthPlans,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrowthPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.growthPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> habitStreaksRefs<T extends Object>(
    Expression<T> Function($$HabitStreaksTableAnnotationComposer a) f,
  ) {
    final $$HabitStreaksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitStreaks,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitStreaksTableAnnotationComposer(
            $db: $db,
            $table: $db.habitStreaks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> customHabitOrganEffectsRefs<T extends Object>(
    Expression<T> Function($$CustomHabitOrganEffectsTableAnnotationComposer a)
    f,
  ) {
    final $$CustomHabitOrganEffectsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.customHabitOrganEffects,
          getReferencedColumn: (t) => t.habitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CustomHabitOrganEffectsTableAnnotationComposer(
                $db: $db,
                $table: $db.customHabitOrganEffects,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> standardHabitOrganEffectsRefs<T extends Object>(
    Expression<T> Function($$StandardHabitOrganEffectsTableAnnotationComposer a)
    f,
  ) {
    final $$StandardHabitOrganEffectsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.standardHabitOrganEffects,
          getReferencedColumn: (t) => t.habitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StandardHabitOrganEffectsTableAnnotationComposer(
                $db: $db,
                $table: $db.standardHabitOrganEffects,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> numericalHabitEntriesRefs<T extends Object>(
    Expression<T> Function($$NumericalHabitEntriesTableAnnotationComposer a) f,
  ) {
    final $$NumericalHabitEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.numericalHabitEntries,
          getReferencedColumn: (t) => t.habitId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NumericalHabitEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.numericalHabitEntries,
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
            bool namedCustomGraphRulesRefs,
            bool reductionPlansRefs,
            bool growthPlansRefs,
            bool habitStreaksRefs,
            bool customHabitOrganEffectsRefs,
            bool standardHabitOrganEffectsRefs,
            bool numericalHabitEntriesRefs,
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
                Value<bool> numericalTrackingEnabled = const Value.absent(),
                Value<int?> numericalTarget = const Value.absent(),
                Value<String?> numericalUnit = const Value.absent(),
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
                numericalTrackingEnabled: numericalTrackingEnabled,
                numericalTarget: numericalTarget,
                numericalUnit: numericalUnit,
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
                Value<bool> numericalTrackingEnabled = const Value.absent(),
                Value<int?> numericalTarget = const Value.absent(),
                Value<String?> numericalUnit = const Value.absent(),
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
                numericalTrackingEnabled: numericalTrackingEnabled,
                numericalTarget: numericalTarget,
                numericalUnit: numericalUnit,
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
                namedCustomGraphRulesRefs = false,
                reductionPlansRefs = false,
                growthPlansRefs = false,
                habitStreaksRefs = false,
                customHabitOrganEffectsRefs = false,
                standardHabitOrganEffectsRefs = false,
                numericalHabitEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (habitLogEntriesRefs) db.habitLogEntries,
                    if (graphHistoryEntriesRefs) db.graphHistoryEntries,
                    if (customGraphRulesRefs) db.customGraphRules,
                    if (specialHabitGraphsRefs) db.specialHabitGraphs,
                    if (namedCustomGraphRulesRefs) db.namedCustomGraphRules,
                    if (reductionPlansRefs) db.reductionPlans,
                    if (growthPlansRefs) db.growthPlans,
                    if (habitStreaksRefs) db.habitStreaks,
                    if (customHabitOrganEffectsRefs) db.customHabitOrganEffects,
                    if (standardHabitOrganEffectsRefs)
                      db.standardHabitOrganEffects,
                    if (numericalHabitEntriesRefs) db.numericalHabitEntries,
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
                      if (namedCustomGraphRulesRefs)
                        await $_getPrefetchedData<
                          HabitDefinition,
                          $HabitDefinitionsTable,
                          NamedCustomGraphRuleRow
                        >(
                          currentTable: table,
                          referencedTable: $$HabitDefinitionsTableReferences
                              ._namedCustomGraphRulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitDefinitionsTableReferences(
                                db,
                                table,
                                p0,
                              ).namedCustomGraphRulesRefs,
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
                      if (growthPlansRefs)
                        await $_getPrefetchedData<
                          HabitDefinition,
                          $HabitDefinitionsTable,
                          GrowthPlanRow
                        >(
                          currentTable: table,
                          referencedTable: $$HabitDefinitionsTableReferences
                              ._growthPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitDefinitionsTableReferences(
                                db,
                                table,
                                p0,
                              ).growthPlansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (habitStreaksRefs)
                        await $_getPrefetchedData<
                          HabitDefinition,
                          $HabitDefinitionsTable,
                          HabitStreakRow
                        >(
                          currentTable: table,
                          referencedTable: $$HabitDefinitionsTableReferences
                              ._habitStreaksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitDefinitionsTableReferences(
                                db,
                                table,
                                p0,
                              ).habitStreaksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (customHabitOrganEffectsRefs)
                        await $_getPrefetchedData<
                          HabitDefinition,
                          $HabitDefinitionsTable,
                          CustomHabitOrganEffectRow
                        >(
                          currentTable: table,
                          referencedTable: $$HabitDefinitionsTableReferences
                              ._customHabitOrganEffectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitDefinitionsTableReferences(
                                db,
                                table,
                                p0,
                              ).customHabitOrganEffectsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (standardHabitOrganEffectsRefs)
                        await $_getPrefetchedData<
                          HabitDefinition,
                          $HabitDefinitionsTable,
                          StandardHabitOrganEffectRow
                        >(
                          currentTable: table,
                          referencedTable: $$HabitDefinitionsTableReferences
                              ._standardHabitOrganEffectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitDefinitionsTableReferences(
                                db,
                                table,
                                p0,
                              ).standardHabitOrganEffectsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (numericalHabitEntriesRefs)
                        await $_getPrefetchedData<
                          HabitDefinition,
                          $HabitDefinitionsTable,
                          NumericalHabitEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$HabitDefinitionsTableReferences
                              ._numericalHabitEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitDefinitionsTableReferences(
                                db,
                                table,
                                p0,
                              ).numericalHabitEntriesRefs,
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
        bool namedCustomGraphRulesRefs,
        bool reductionPlansRefs,
        bool growthPlansRefs,
        bool habitStreaksRefs,
        bool customHabitOrganEffectsRefs,
        bool standardHabitOrganEffectsRefs,
        bool numericalHabitEntriesRefs,
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
      Value<double?> score,
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
      Value<double?> score,
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

  ColumnFilters<double> get score => $composableBuilder(
    column: $table.score,
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

  ColumnOrderings<double> get score => $composableBuilder(
    column: $table.score,
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

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

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
                Value<double?> score = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BodyPartStatesCompanion(
                partKey: partKey,
                level: level,
                score: score,
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
                Value<double?> score = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BodyPartStatesCompanion.insert(
                partKey: partKey,
                level: level,
                score: score,
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
      Value<int> completedValue,
      Value<int> missedValue,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
    });
typedef $$SpecialHabitGraphsTableUpdateCompanionBuilder =
    SpecialHabitGraphsCompanion Function({
      Value<int> slot,
      Value<String> habitId,
      Value<int> completedValue,
      Value<int> missedValue,
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

  ColumnFilters<int> get completedValue => $composableBuilder(
    column: $table.completedValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get missedValue => $composableBuilder(
    column: $table.missedValue,
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

  ColumnOrderings<int> get completedValue => $composableBuilder(
    column: $table.completedValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get missedValue => $composableBuilder(
    column: $table.missedValue,
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

  GeneratedColumn<int> get completedValue => $composableBuilder(
    column: $table.completedValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get missedValue => $composableBuilder(
    column: $table.missedValue,
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
                Value<int> completedValue = const Value.absent(),
                Value<int> missedValue = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => SpecialHabitGraphsCompanion(
                slot: slot,
                habitId: habitId,
                completedValue: completedValue,
                missedValue: missedValue,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> slot = const Value.absent(),
                required String habitId,
                Value<int> completedValue = const Value.absent(),
                Value<int> missedValue = const Value.absent(),
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => SpecialHabitGraphsCompanion.insert(
                slot: slot,
                habitId: habitId,
                completedValue: completedValue,
                missedValue: missedValue,
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
typedef $$NamedCustomGraphsTableCreateCompanionBuilder =
    NamedCustomGraphsCompanion Function({
      Value<int> slot,
      required String name,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
    });
typedef $$NamedCustomGraphsTableUpdateCompanionBuilder =
    NamedCustomGraphsCompanion Function({
      Value<int> slot,
      Value<String> name,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
    });

final class $$NamedCustomGraphsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $NamedCustomGraphsTable,
          NamedCustomGraphRow
        > {
  $$NamedCustomGraphsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $NamedCustomGraphRulesTable,
    List<NamedCustomGraphRuleRow>
  >
  _namedCustomGraphRulesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.namedCustomGraphRules,
        aliasName:
            'named_custom_graphs__slot__named_custom_graph_rules__graph_slot',
      );

  $$NamedCustomGraphRulesTableProcessedTableManager
  get namedCustomGraphRulesRefs {
    final manager = $$NamedCustomGraphRulesTableTableManager(
      $_db,
      $_db.namedCustomGraphRules,
    ).filter((f) => f.graphSlot.slot.sqlEquals($_itemColumn<int>('slot')!));

    final cache = $_typedResult.readTableOrNull(
      _namedCustomGraphRulesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NamedCustomGraphsTableFilterComposer
    extends Composer<_$AppDatabase, $NamedCustomGraphsTable> {
  $$NamedCustomGraphsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
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

  Expression<bool> namedCustomGraphRulesRefs(
    Expression<bool> Function($$NamedCustomGraphRulesTableFilterComposer f) f,
  ) {
    final $$NamedCustomGraphRulesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.slot,
          referencedTable: $db.namedCustomGraphRules,
          getReferencedColumn: (t) => t.graphSlot,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NamedCustomGraphRulesTableFilterComposer(
                $db: $db,
                $table: $db.namedCustomGraphRules,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$NamedCustomGraphsTableOrderingComposer
    extends Composer<_$AppDatabase, $NamedCustomGraphsTable> {
  $$NamedCustomGraphsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
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

class $$NamedCustomGraphsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NamedCustomGraphsTable> {
  $$NamedCustomGraphsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  Expression<T> namedCustomGraphRulesRefs<T extends Object>(
    Expression<T> Function($$NamedCustomGraphRulesTableAnnotationComposer a) f,
  ) {
    final $$NamedCustomGraphRulesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.slot,
          referencedTable: $db.namedCustomGraphRules,
          getReferencedColumn: (t) => t.graphSlot,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NamedCustomGraphRulesTableAnnotationComposer(
                $db: $db,
                $table: $db.namedCustomGraphRules,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$NamedCustomGraphsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NamedCustomGraphsTable,
          NamedCustomGraphRow,
          $$NamedCustomGraphsTableFilterComposer,
          $$NamedCustomGraphsTableOrderingComposer,
          $$NamedCustomGraphsTableAnnotationComposer,
          $$NamedCustomGraphsTableCreateCompanionBuilder,
          $$NamedCustomGraphsTableUpdateCompanionBuilder,
          (NamedCustomGraphRow, $$NamedCustomGraphsTableReferences),
          NamedCustomGraphRow,
          PrefetchHooks Function({bool namedCustomGraphRulesRefs})
        > {
  $$NamedCustomGraphsTableTableManager(
    _$AppDatabase db,
    $NamedCustomGraphsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NamedCustomGraphsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NamedCustomGraphsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NamedCustomGraphsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> slot = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => NamedCustomGraphsCompanion(
                slot: slot,
                name: name,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> slot = const Value.absent(),
                required String name,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => NamedCustomGraphsCompanion.insert(
                slot: slot,
                name: name,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NamedCustomGraphsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({namedCustomGraphRulesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (namedCustomGraphRulesRefs) db.namedCustomGraphRules,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (namedCustomGraphRulesRefs)
                    await $_getPrefetchedData<
                      NamedCustomGraphRow,
                      $NamedCustomGraphsTable,
                      NamedCustomGraphRuleRow
                    >(
                      currentTable: table,
                      referencedTable: $$NamedCustomGraphsTableReferences
                          ._namedCustomGraphRulesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$NamedCustomGraphsTableReferences(
                            db,
                            table,
                            p0,
                          ).namedCustomGraphRulesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.graphSlot == item.slot,
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

typedef $$NamedCustomGraphsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NamedCustomGraphsTable,
      NamedCustomGraphRow,
      $$NamedCustomGraphsTableFilterComposer,
      $$NamedCustomGraphsTableOrderingComposer,
      $$NamedCustomGraphsTableAnnotationComposer,
      $$NamedCustomGraphsTableCreateCompanionBuilder,
      $$NamedCustomGraphsTableUpdateCompanionBuilder,
      (NamedCustomGraphRow, $$NamedCustomGraphsTableReferences),
      NamedCustomGraphRow,
      PrefetchHooks Function({bool namedCustomGraphRulesRefs})
    >;
typedef $$NamedCustomGraphRulesTableCreateCompanionBuilder =
    NamedCustomGraphRulesCompanion Function({
      required int graphSlot,
      required int ruleSlot,
      required String habitId,
      required int completedPoints,
      required int missedPoints,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<int> rowid,
    });
typedef $$NamedCustomGraphRulesTableUpdateCompanionBuilder =
    NamedCustomGraphRulesCompanion Function({
      Value<int> graphSlot,
      Value<int> ruleSlot,
      Value<String> habitId,
      Value<int> completedPoints,
      Value<int> missedPoints,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<int> rowid,
    });

final class $$NamedCustomGraphRulesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $NamedCustomGraphRulesTable,
          NamedCustomGraphRuleRow
        > {
  $$NamedCustomGraphRulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $NamedCustomGraphsTable _graphSlotTable(_$AppDatabase db) =>
      db.namedCustomGraphs.createAlias(
        'named_custom_graph_rules__graph_slot__named_custom_graphs__slot',
      );

  $$NamedCustomGraphsTableProcessedTableManager get graphSlot {
    final $_column = $_itemColumn<int>('graph_slot')!;

    final manager = $$NamedCustomGraphsTableTableManager(
      $_db,
      $_db.namedCustomGraphs,
    ).filter((f) => f.slot.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_graphSlotTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $HabitDefinitionsTable _habitIdTable(_$AppDatabase db) => db
      .habitDefinitions
      .createAlias('named_custom_graph_rules__habit_id__habit_definitions__id');

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

class $$NamedCustomGraphRulesTableFilterComposer
    extends Composer<_$AppDatabase, $NamedCustomGraphRulesTable> {
  $$NamedCustomGraphRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ruleSlot => $composableBuilder(
    column: $table.ruleSlot,
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

  $$NamedCustomGraphsTableFilterComposer get graphSlot {
    final $$NamedCustomGraphsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.graphSlot,
      referencedTable: $db.namedCustomGraphs,
      getReferencedColumn: (t) => t.slot,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NamedCustomGraphsTableFilterComposer(
            $db: $db,
            $table: $db.namedCustomGraphs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$NamedCustomGraphRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $NamedCustomGraphRulesTable> {
  $$NamedCustomGraphRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ruleSlot => $composableBuilder(
    column: $table.ruleSlot,
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

  $$NamedCustomGraphsTableOrderingComposer get graphSlot {
    final $$NamedCustomGraphsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.graphSlot,
      referencedTable: $db.namedCustomGraphs,
      getReferencedColumn: (t) => t.slot,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NamedCustomGraphsTableOrderingComposer(
            $db: $db,
            $table: $db.namedCustomGraphs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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

class $$NamedCustomGraphRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NamedCustomGraphRulesTable> {
  $$NamedCustomGraphRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ruleSlot =>
      $composableBuilder(column: $table.ruleSlot, builder: (column) => column);

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

  $$NamedCustomGraphsTableAnnotationComposer get graphSlot {
    final $$NamedCustomGraphsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.graphSlot,
          referencedTable: $db.namedCustomGraphs,
          getReferencedColumn: (t) => t.slot,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NamedCustomGraphsTableAnnotationComposer(
                $db: $db,
                $table: $db.namedCustomGraphs,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

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

class $$NamedCustomGraphRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NamedCustomGraphRulesTable,
          NamedCustomGraphRuleRow,
          $$NamedCustomGraphRulesTableFilterComposer,
          $$NamedCustomGraphRulesTableOrderingComposer,
          $$NamedCustomGraphRulesTableAnnotationComposer,
          $$NamedCustomGraphRulesTableCreateCompanionBuilder,
          $$NamedCustomGraphRulesTableUpdateCompanionBuilder,
          (NamedCustomGraphRuleRow, $$NamedCustomGraphRulesTableReferences),
          NamedCustomGraphRuleRow,
          PrefetchHooks Function({bool graphSlot, bool habitId})
        > {
  $$NamedCustomGraphRulesTableTableManager(
    _$AppDatabase db,
    $NamedCustomGraphRulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NamedCustomGraphRulesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NamedCustomGraphRulesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NamedCustomGraphRulesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> graphSlot = const Value.absent(),
                Value<int> ruleSlot = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<int> completedPoints = const Value.absent(),
                Value<int> missedPoints = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NamedCustomGraphRulesCompanion(
                graphSlot: graphSlot,
                ruleSlot: ruleSlot,
                habitId: habitId,
                completedPoints: completedPoints,
                missedPoints: missedPoints,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int graphSlot,
                required int ruleSlot,
                required String habitId,
                required int completedPoints,
                required int missedPoints,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NamedCustomGraphRulesCompanion.insert(
                graphSlot: graphSlot,
                ruleSlot: ruleSlot,
                habitId: habitId,
                completedPoints: completedPoints,
                missedPoints: missedPoints,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NamedCustomGraphRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({graphSlot = false, habitId = false}) {
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
                    if (graphSlot) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.graphSlot,
                                referencedTable:
                                    $$NamedCustomGraphRulesTableReferences
                                        ._graphSlotTable(db),
                                referencedColumn:
                                    $$NamedCustomGraphRulesTableReferences
                                        ._graphSlotTable(db)
                                        .slot,
                              )
                              as T;
                    }
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable:
                                    $$NamedCustomGraphRulesTableReferences
                                        ._habitIdTable(db),
                                referencedColumn:
                                    $$NamedCustomGraphRulesTableReferences
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

typedef $$NamedCustomGraphRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NamedCustomGraphRulesTable,
      NamedCustomGraphRuleRow,
      $$NamedCustomGraphRulesTableFilterComposer,
      $$NamedCustomGraphRulesTableOrderingComposer,
      $$NamedCustomGraphRulesTableAnnotationComposer,
      $$NamedCustomGraphRulesTableCreateCompanionBuilder,
      $$NamedCustomGraphRulesTableUpdateCompanionBuilder,
      (NamedCustomGraphRuleRow, $$NamedCustomGraphRulesTableReferences),
      NamedCustomGraphRuleRow,
      PrefetchHooks Function({bool graphSlot, bool habitId})
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
typedef $$GrowthPlansTableCreateCompanionBuilder =
    GrowthPlansCompanion Function({
      required String id,
      required String habitId,
      required String mode,
      required DateTime startedOn,
      required int targetDaysPerWeek,
      required int targetRepetitionsPerDay,
      Value<String> offWeekdays,
      Value<String> weekdayRepetitions,
      Value<String> measurementUnit,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$GrowthPlansTableUpdateCompanionBuilder =
    GrowthPlansCompanion Function({
      Value<String> id,
      Value<String> habitId,
      Value<String> mode,
      Value<DateTime> startedOn,
      Value<int> targetDaysPerWeek,
      Value<int> targetRepetitionsPerDay,
      Value<String> offWeekdays,
      Value<String> weekdayRepetitions,
      Value<String> measurementUnit,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$GrowthPlansTableReferences
    extends BaseReferences<_$AppDatabase, $GrowthPlansTable, GrowthPlanRow> {
  $$GrowthPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitDefinitionsTable _habitIdTable(_$AppDatabase db) => db
      .habitDefinitions
      .createAlias('growth_plans__habit_id__habit_definitions__id');

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

  static MultiTypedResultKey<$GrowthPlanEntriesTable, List<GrowthPlanEntryRow>>
  _growthPlanEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.growthPlanEntries,
        aliasName: 'growth_plans__id__growth_plan_entries__plan_id',
      );

  $$GrowthPlanEntriesTableProcessedTableManager get growthPlanEntriesRefs {
    final manager = $$GrowthPlanEntriesTableTableManager(
      $_db,
      $_db.growthPlanEntries,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _growthPlanEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GrowthPlansTableFilterComposer
    extends Composer<_$AppDatabase, $GrowthPlansTable> {
  $$GrowthPlansTableFilterComposer({
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

  ColumnFilters<int> get targetDaysPerWeek => $composableBuilder(
    column: $table.targetDaysPerWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetRepetitionsPerDay => $composableBuilder(
    column: $table.targetRepetitionsPerDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get offWeekdays => $composableBuilder(
    column: $table.offWeekdays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weekdayRepetitions => $composableBuilder(
    column: $table.weekdayRepetitions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get measurementUnit => $composableBuilder(
    column: $table.measurementUnit,
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

  Expression<bool> growthPlanEntriesRefs(
    Expression<bool> Function($$GrowthPlanEntriesTableFilterComposer f) f,
  ) {
    final $$GrowthPlanEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.growthPlanEntries,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrowthPlanEntriesTableFilterComposer(
            $db: $db,
            $table: $db.growthPlanEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GrowthPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $GrowthPlansTable> {
  $$GrowthPlansTableOrderingComposer({
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

  ColumnOrderings<int> get targetDaysPerWeek => $composableBuilder(
    column: $table.targetDaysPerWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetRepetitionsPerDay => $composableBuilder(
    column: $table.targetRepetitionsPerDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get offWeekdays => $composableBuilder(
    column: $table.offWeekdays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekdayRepetitions => $composableBuilder(
    column: $table.weekdayRepetitions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get measurementUnit => $composableBuilder(
    column: $table.measurementUnit,
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

class $$GrowthPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrowthPlansTable> {
  $$GrowthPlansTableAnnotationComposer({
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

  GeneratedColumn<int> get targetDaysPerWeek => $composableBuilder(
    column: $table.targetDaysPerWeek,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetRepetitionsPerDay => $composableBuilder(
    column: $table.targetRepetitionsPerDay,
    builder: (column) => column,
  );

  GeneratedColumn<String> get offWeekdays => $composableBuilder(
    column: $table.offWeekdays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weekdayRepetitions => $composableBuilder(
    column: $table.weekdayRepetitions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get measurementUnit => $composableBuilder(
    column: $table.measurementUnit,
    builder: (column) => column,
  );

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

  Expression<T> growthPlanEntriesRefs<T extends Object>(
    Expression<T> Function($$GrowthPlanEntriesTableAnnotationComposer a) f,
  ) {
    final $$GrowthPlanEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.growthPlanEntries,
          getReferencedColumn: (t) => t.planId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GrowthPlanEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.growthPlanEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GrowthPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GrowthPlansTable,
          GrowthPlanRow,
          $$GrowthPlansTableFilterComposer,
          $$GrowthPlansTableOrderingComposer,
          $$GrowthPlansTableAnnotationComposer,
          $$GrowthPlansTableCreateCompanionBuilder,
          $$GrowthPlansTableUpdateCompanionBuilder,
          (GrowthPlanRow, $$GrowthPlansTableReferences),
          GrowthPlanRow,
          PrefetchHooks Function({bool habitId, bool growthPlanEntriesRefs})
        > {
  $$GrowthPlansTableTableManager(_$AppDatabase db, $GrowthPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrowthPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrowthPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrowthPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<DateTime> startedOn = const Value.absent(),
                Value<int> targetDaysPerWeek = const Value.absent(),
                Value<int> targetRepetitionsPerDay = const Value.absent(),
                Value<String> offWeekdays = const Value.absent(),
                Value<String> weekdayRepetitions = const Value.absent(),
                Value<String> measurementUnit = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrowthPlansCompanion(
                id: id,
                habitId: habitId,
                mode: mode,
                startedOn: startedOn,
                targetDaysPerWeek: targetDaysPerWeek,
                targetRepetitionsPerDay: targetRepetitionsPerDay,
                offWeekdays: offWeekdays,
                weekdayRepetitions: weekdayRepetitions,
                measurementUnit: measurementUnit,
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
                required int targetDaysPerWeek,
                required int targetRepetitionsPerDay,
                Value<String> offWeekdays = const Value.absent(),
                Value<String> weekdayRepetitions = const Value.absent(),
                Value<String> measurementUnit = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrowthPlansCompanion.insert(
                id: id,
                habitId: habitId,
                mode: mode,
                startedOn: startedOn,
                targetDaysPerWeek: targetDaysPerWeek,
                targetRepetitionsPerDay: targetRepetitionsPerDay,
                offWeekdays: offWeekdays,
                weekdayRepetitions: weekdayRepetitions,
                measurementUnit: measurementUnit,
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
                  $$GrowthPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({habitId = false, growthPlanEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (growthPlanEntriesRefs) db.growthPlanEntries,
                  ],
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
                                        $$GrowthPlansTableReferences
                                            ._habitIdTable(db),
                                    referencedColumn:
                                        $$GrowthPlansTableReferences
                                            ._habitIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (growthPlanEntriesRefs)
                        await $_getPrefetchedData<
                          GrowthPlanRow,
                          $GrowthPlansTable,
                          GrowthPlanEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$GrowthPlansTableReferences
                              ._growthPlanEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GrowthPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).growthPlanEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.planId == item.id,
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

typedef $$GrowthPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GrowthPlansTable,
      GrowthPlanRow,
      $$GrowthPlansTableFilterComposer,
      $$GrowthPlansTableOrderingComposer,
      $$GrowthPlansTableAnnotationComposer,
      $$GrowthPlansTableCreateCompanionBuilder,
      $$GrowthPlansTableUpdateCompanionBuilder,
      (GrowthPlanRow, $$GrowthPlansTableReferences),
      GrowthPlanRow,
      PrefetchHooks Function({bool habitId, bool growthPlanEntriesRefs})
    >;
typedef $$GrowthPlanEntriesTableCreateCompanionBuilder =
    GrowthPlanEntriesCompanion Function({
      required String planId,
      required DateTime localDay,
      Value<int> completedCount,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<int> rowid,
    });
typedef $$GrowthPlanEntriesTableUpdateCompanionBuilder =
    GrowthPlanEntriesCompanion Function({
      Value<String> planId,
      Value<DateTime> localDay,
      Value<int> completedCount,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<int> rowid,
    });

final class $$GrowthPlanEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GrowthPlanEntriesTable,
          GrowthPlanEntryRow
        > {
  $$GrowthPlanEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GrowthPlansTable _planIdTable(_$AppDatabase db) => db.growthPlans
      .createAlias('growth_plan_entries__plan_id__growth_plans__id');

  $$GrowthPlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<String>('plan_id')!;

    final manager = $$GrowthPlansTableTableManager(
      $_db,
      $_db.growthPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GrowthPlanEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $GrowthPlanEntriesTable> {
  $$GrowthPlanEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get localDay => $composableBuilder(
    column: $table.localDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedCount => $composableBuilder(
    column: $table.completedCount,
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

  $$GrowthPlansTableFilterComposer get planId {
    final $$GrowthPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.growthPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrowthPlansTableFilterComposer(
            $db: $db,
            $table: $db.growthPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrowthPlanEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $GrowthPlanEntriesTable> {
  $$GrowthPlanEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get localDay => $composableBuilder(
    column: $table.localDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedCount => $composableBuilder(
    column: $table.completedCount,
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

  $$GrowthPlansTableOrderingComposer get planId {
    final $$GrowthPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.growthPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrowthPlansTableOrderingComposer(
            $db: $db,
            $table: $db.growthPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrowthPlanEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrowthPlanEntriesTable> {
  $$GrowthPlanEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get localDay =>
      $composableBuilder(column: $table.localDay, builder: (column) => column);

  GeneratedColumn<int> get completedCount => $composableBuilder(
    column: $table.completedCount,
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

  $$GrowthPlansTableAnnotationComposer get planId {
    final $$GrowthPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.growthPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrowthPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.growthPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrowthPlanEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GrowthPlanEntriesTable,
          GrowthPlanEntryRow,
          $$GrowthPlanEntriesTableFilterComposer,
          $$GrowthPlanEntriesTableOrderingComposer,
          $$GrowthPlanEntriesTableAnnotationComposer,
          $$GrowthPlanEntriesTableCreateCompanionBuilder,
          $$GrowthPlanEntriesTableUpdateCompanionBuilder,
          (GrowthPlanEntryRow, $$GrowthPlanEntriesTableReferences),
          GrowthPlanEntryRow,
          PrefetchHooks Function({bool planId})
        > {
  $$GrowthPlanEntriesTableTableManager(
    _$AppDatabase db,
    $GrowthPlanEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrowthPlanEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrowthPlanEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrowthPlanEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> planId = const Value.absent(),
                Value<DateTime> localDay = const Value.absent(),
                Value<int> completedCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrowthPlanEntriesCompanion(
                planId: planId,
                localDay: localDay,
                completedCount: completedCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String planId,
                required DateTime localDay,
                Value<int> completedCount = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrowthPlanEntriesCompanion.insert(
                planId: planId,
                localDay: localDay,
                completedCount: completedCount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GrowthPlanEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planId = false}) {
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
                    if (planId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.planId,
                                referencedTable:
                                    $$GrowthPlanEntriesTableReferences
                                        ._planIdTable(db),
                                referencedColumn:
                                    $$GrowthPlanEntriesTableReferences
                                        ._planIdTable(db)
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

typedef $$GrowthPlanEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GrowthPlanEntriesTable,
      GrowthPlanEntryRow,
      $$GrowthPlanEntriesTableFilterComposer,
      $$GrowthPlanEntriesTableOrderingComposer,
      $$GrowthPlanEntriesTableAnnotationComposer,
      $$GrowthPlanEntriesTableCreateCompanionBuilder,
      $$GrowthPlanEntriesTableUpdateCompanionBuilder,
      (GrowthPlanEntryRow, $$GrowthPlanEntriesTableReferences),
      GrowthPlanEntryRow,
      PrefetchHooks Function({bool planId})
    >;
typedef $$HabitStreaksTableCreateCompanionBuilder =
    HabitStreaksCompanion Function({
      required String habitId,
      Value<int?> colorValue,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$HabitStreaksTableUpdateCompanionBuilder =
    HabitStreaksCompanion Function({
      Value<String> habitId,
      Value<int?> colorValue,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$HabitStreaksTableReferences
    extends BaseReferences<_$AppDatabase, $HabitStreaksTable, HabitStreakRow> {
  $$HabitStreaksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitDefinitionsTable _habitIdTable(_$AppDatabase db) => db
      .habitDefinitions
      .createAlias('habit_streaks__habit_id__habit_definitions__id');

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

class $$HabitStreaksTableFilterComposer
    extends Composer<_$AppDatabase, $HabitStreaksTable> {
  $$HabitStreaksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
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

class $$HabitStreaksTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitStreaksTable> {
  $$HabitStreaksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
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

class $$HabitStreaksTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitStreaksTable> {
  $$HabitStreaksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

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

class $$HabitStreaksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitStreaksTable,
          HabitStreakRow,
          $$HabitStreaksTableFilterComposer,
          $$HabitStreaksTableOrderingComposer,
          $$HabitStreaksTableAnnotationComposer,
          $$HabitStreaksTableCreateCompanionBuilder,
          $$HabitStreaksTableUpdateCompanionBuilder,
          (HabitStreakRow, $$HabitStreaksTableReferences),
          HabitStreakRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$HabitStreaksTableTableManager(_$AppDatabase db, $HabitStreaksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitStreaksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitStreaksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitStreaksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> habitId = const Value.absent(),
                Value<int?> colorValue = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitStreaksCompanion(
                habitId: habitId,
                colorValue: colorValue,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String habitId,
                Value<int?> colorValue = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => HabitStreaksCompanion.insert(
                habitId: habitId,
                colorValue: colorValue,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitStreaksTableReferences(db, table, e),
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
                                referencedTable: $$HabitStreaksTableReferences
                                    ._habitIdTable(db),
                                referencedColumn: $$HabitStreaksTableReferences
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

typedef $$HabitStreaksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitStreaksTable,
      HabitStreakRow,
      $$HabitStreaksTableFilterComposer,
      $$HabitStreaksTableOrderingComposer,
      $$HabitStreaksTableAnnotationComposer,
      $$HabitStreaksTableCreateCompanionBuilder,
      $$HabitStreaksTableUpdateCompanionBuilder,
      (HabitStreakRow, $$HabitStreaksTableReferences),
      HabitStreakRow,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$RewardStatesTableCreateCompanionBuilder =
    RewardStatesCompanion Function({
      Value<int> id,
      Value<String> plan,
      Value<DateTime?> planExpiresAt,
      Value<int> tokenBalance,
      Value<int> currentStreak,
      Value<int> profileProgress,
      Value<int> bodyProgress,
      Value<int> calendarProgress,
      Value<DateTime?> lastEvaluatedWeek,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$RewardStatesTableUpdateCompanionBuilder =
    RewardStatesCompanion Function({
      Value<int> id,
      Value<String> plan,
      Value<DateTime?> planExpiresAt,
      Value<int> tokenBalance,
      Value<int> currentStreak,
      Value<int> profileProgress,
      Value<int> bodyProgress,
      Value<int> calendarProgress,
      Value<DateTime?> lastEvaluatedWeek,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$RewardStatesTableFilterComposer
    extends Composer<_$AppDatabase, $RewardStatesTable> {
  $$RewardStatesTableFilterComposer({
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

  ColumnFilters<String> get plan => $composableBuilder(
    column: $table.plan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get planExpiresAt => $composableBuilder(
    column: $table.planExpiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tokenBalance => $composableBuilder(
    column: $table.tokenBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get profileProgress => $composableBuilder(
    column: $table.profileProgress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bodyProgress => $composableBuilder(
    column: $table.bodyProgress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calendarProgress => $composableBuilder(
    column: $table.calendarProgress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastEvaluatedWeek => $composableBuilder(
    column: $table.lastEvaluatedWeek,
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
}

class $$RewardStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $RewardStatesTable> {
  $$RewardStatesTableOrderingComposer({
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

  ColumnOrderings<String> get plan => $composableBuilder(
    column: $table.plan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get planExpiresAt => $composableBuilder(
    column: $table.planExpiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tokenBalance => $composableBuilder(
    column: $table.tokenBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get profileProgress => $composableBuilder(
    column: $table.profileProgress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bodyProgress => $composableBuilder(
    column: $table.bodyProgress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calendarProgress => $composableBuilder(
    column: $table.calendarProgress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastEvaluatedWeek => $composableBuilder(
    column: $table.lastEvaluatedWeek,
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
}

class $$RewardStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RewardStatesTable> {
  $$RewardStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get plan =>
      $composableBuilder(column: $table.plan, builder: (column) => column);

  GeneratedColumn<DateTime> get planExpiresAt => $composableBuilder(
    column: $table.planExpiresAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tokenBalance => $composableBuilder(
    column: $table.tokenBalance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get profileProgress => $composableBuilder(
    column: $table.profileProgress,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bodyProgress => $composableBuilder(
    column: $table.bodyProgress,
    builder: (column) => column,
  );

  GeneratedColumn<int> get calendarProgress => $composableBuilder(
    column: $table.calendarProgress,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastEvaluatedWeek => $composableBuilder(
    column: $table.lastEvaluatedWeek,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RewardStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RewardStatesTable,
          RewardStateRow,
          $$RewardStatesTableFilterComposer,
          $$RewardStatesTableOrderingComposer,
          $$RewardStatesTableAnnotationComposer,
          $$RewardStatesTableCreateCompanionBuilder,
          $$RewardStatesTableUpdateCompanionBuilder,
          (
            RewardStateRow,
            BaseReferences<_$AppDatabase, $RewardStatesTable, RewardStateRow>,
          ),
          RewardStateRow,
          PrefetchHooks Function()
        > {
  $$RewardStatesTableTableManager(_$AppDatabase db, $RewardStatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RewardStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RewardStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RewardStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> plan = const Value.absent(),
                Value<DateTime?> planExpiresAt = const Value.absent(),
                Value<int> tokenBalance = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> profileProgress = const Value.absent(),
                Value<int> bodyProgress = const Value.absent(),
                Value<int> calendarProgress = const Value.absent(),
                Value<DateTime?> lastEvaluatedWeek = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RewardStatesCompanion(
                id: id,
                plan: plan,
                planExpiresAt: planExpiresAt,
                tokenBalance: tokenBalance,
                currentStreak: currentStreak,
                profileProgress: profileProgress,
                bodyProgress: bodyProgress,
                calendarProgress: calendarProgress,
                lastEvaluatedWeek: lastEvaluatedWeek,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> plan = const Value.absent(),
                Value<DateTime?> planExpiresAt = const Value.absent(),
                Value<int> tokenBalance = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> profileProgress = const Value.absent(),
                Value<int> bodyProgress = const Value.absent(),
                Value<int> calendarProgress = const Value.absent(),
                Value<DateTime?> lastEvaluatedWeek = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => RewardStatesCompanion.insert(
                id: id,
                plan: plan,
                planExpiresAt: planExpiresAt,
                tokenBalance: tokenBalance,
                currentStreak: currentStreak,
                profileProgress: profileProgress,
                bodyProgress: bodyProgress,
                calendarProgress: calendarProgress,
                lastEvaluatedWeek: lastEvaluatedWeek,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RewardStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RewardStatesTable,
      RewardStateRow,
      $$RewardStatesTableFilterComposer,
      $$RewardStatesTableOrderingComposer,
      $$RewardStatesTableAnnotationComposer,
      $$RewardStatesTableCreateCompanionBuilder,
      $$RewardStatesTableUpdateCompanionBuilder,
      (
        RewardStateRow,
        BaseReferences<_$AppDatabase, $RewardStatesTable, RewardStateRow>,
      ),
      RewardStateRow,
      PrefetchHooks Function()
    >;
typedef $$RewardEventsTableCreateCompanionBuilder =
    RewardEventsCompanion Function({
      required String id,
      Value<String?> badgeKey,
      required int amount,
      required DateTime occurredOn,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$RewardEventsTableUpdateCompanionBuilder =
    RewardEventsCompanion Function({
      Value<String> id,
      Value<String?> badgeKey,
      Value<int> amount,
      Value<DateTime> occurredOn,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$RewardEventsTableFilterComposer
    extends Composer<_$AppDatabase, $RewardEventsTable> {
  $$RewardEventsTableFilterComposer({
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

  ColumnFilters<String> get badgeKey => $composableBuilder(
    column: $table.badgeKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RewardEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $RewardEventsTable> {
  $$RewardEventsTableOrderingComposer({
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

  ColumnOrderings<String> get badgeKey => $composableBuilder(
    column: $table.badgeKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RewardEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RewardEventsTable> {
  $$RewardEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get badgeKey =>
      $composableBuilder(column: $table.badgeKey, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RewardEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RewardEventsTable,
          RewardEventRow,
          $$RewardEventsTableFilterComposer,
          $$RewardEventsTableOrderingComposer,
          $$RewardEventsTableAnnotationComposer,
          $$RewardEventsTableCreateCompanionBuilder,
          $$RewardEventsTableUpdateCompanionBuilder,
          (
            RewardEventRow,
            BaseReferences<_$AppDatabase, $RewardEventsTable, RewardEventRow>,
          ),
          RewardEventRow,
          PrefetchHooks Function()
        > {
  $$RewardEventsTableTableManager(_$AppDatabase db, $RewardEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RewardEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RewardEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RewardEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> badgeKey = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> occurredOn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RewardEventsCompanion(
                id: id,
                badgeKey: badgeKey,
                amount: amount,
                occurredOn: occurredOn,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> badgeKey = const Value.absent(),
                required int amount,
                required DateTime occurredOn,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RewardEventsCompanion.insert(
                id: id,
                badgeKey: badgeKey,
                amount: amount,
                occurredOn: occurredOn,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RewardEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RewardEventsTable,
      RewardEventRow,
      $$RewardEventsTableFilterComposer,
      $$RewardEventsTableOrderingComposer,
      $$RewardEventsTableAnnotationComposer,
      $$RewardEventsTableCreateCompanionBuilder,
      $$RewardEventsTableUpdateCompanionBuilder,
      (
        RewardEventRow,
        BaseReferences<_$AppDatabase, $RewardEventsTable, RewardEventRow>,
      ),
      RewardEventRow,
      PrefetchHooks Function()
    >;
typedef $$FeatureUnlocksTableCreateCompanionBuilder =
    FeatureUnlocksCompanion Function({
      required String featureKey,
      required DateTime unlockedUntil,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FeatureUnlocksTableUpdateCompanionBuilder =
    FeatureUnlocksCompanion Function({
      Value<String> featureKey,
      Value<DateTime> unlockedUntil,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$FeatureUnlocksTableFilterComposer
    extends Composer<_$AppDatabase, $FeatureUnlocksTable> {
  $$FeatureUnlocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get featureKey => $composableBuilder(
    column: $table.featureKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedUntil => $composableBuilder(
    column: $table.unlockedUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeatureUnlocksTableOrderingComposer
    extends Composer<_$AppDatabase, $FeatureUnlocksTable> {
  $$FeatureUnlocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get featureKey => $composableBuilder(
    column: $table.featureKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedUntil => $composableBuilder(
    column: $table.unlockedUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeatureUnlocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeatureUnlocksTable> {
  $$FeatureUnlocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get featureKey => $composableBuilder(
    column: $table.featureKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get unlockedUntil => $composableBuilder(
    column: $table.unlockedUntil,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FeatureUnlocksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeatureUnlocksTable,
          FeatureUnlockRow,
          $$FeatureUnlocksTableFilterComposer,
          $$FeatureUnlocksTableOrderingComposer,
          $$FeatureUnlocksTableAnnotationComposer,
          $$FeatureUnlocksTableCreateCompanionBuilder,
          $$FeatureUnlocksTableUpdateCompanionBuilder,
          (
            FeatureUnlockRow,
            BaseReferences<
              _$AppDatabase,
              $FeatureUnlocksTable,
              FeatureUnlockRow
            >,
          ),
          FeatureUnlockRow,
          PrefetchHooks Function()
        > {
  $$FeatureUnlocksTableTableManager(
    _$AppDatabase db,
    $FeatureUnlocksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeatureUnlocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeatureUnlocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeatureUnlocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> featureKey = const Value.absent(),
                Value<DateTime> unlockedUntil = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeatureUnlocksCompanion(
                featureKey: featureKey,
                unlockedUntil: unlockedUntil,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String featureKey,
                required DateTime unlockedUntil,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FeatureUnlocksCompanion.insert(
                featureKey: featureKey,
                unlockedUntil: unlockedUntil,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeatureUnlocksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeatureUnlocksTable,
      FeatureUnlockRow,
      $$FeatureUnlocksTableFilterComposer,
      $$FeatureUnlocksTableOrderingComposer,
      $$FeatureUnlocksTableAnnotationComposer,
      $$FeatureUnlocksTableCreateCompanionBuilder,
      $$FeatureUnlocksTableUpdateCompanionBuilder,
      (
        FeatureUnlockRow,
        BaseReferences<_$AppDatabase, $FeatureUnlocksTable, FeatureUnlockRow>,
      ),
      FeatureUnlockRow,
      PrefetchHooks Function()
    >;
typedef $$CustomHabitOrganEffectsTableCreateCompanionBuilder =
    CustomHabitOrganEffectsCompanion Function({
      required String habitId,
      required String partKey,
      Value<double> thumbUpPoints,
      Value<double> thumbDownPoints,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<int> rowid,
    });
typedef $$CustomHabitOrganEffectsTableUpdateCompanionBuilder =
    CustomHabitOrganEffectsCompanion Function({
      Value<String> habitId,
      Value<String> partKey,
      Value<double> thumbUpPoints,
      Value<double> thumbDownPoints,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<int> rowid,
    });

final class $$CustomHabitOrganEffectsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CustomHabitOrganEffectsTable,
          CustomHabitOrganEffectRow
        > {
  $$CustomHabitOrganEffectsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitDefinitionsTable _habitIdTable(_$AppDatabase db) =>
      db.habitDefinitions.createAlias(
        'custom_habit_organ_effects__habit_id__habit_definitions__id',
      );

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

class $$CustomHabitOrganEffectsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomHabitOrganEffectsTable> {
  $$CustomHabitOrganEffectsTableFilterComposer({
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

  ColumnFilters<double> get thumbUpPoints => $composableBuilder(
    column: $table.thumbUpPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get thumbDownPoints => $composableBuilder(
    column: $table.thumbDownPoints,
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

class $$CustomHabitOrganEffectsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomHabitOrganEffectsTable> {
  $$CustomHabitOrganEffectsTableOrderingComposer({
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

  ColumnOrderings<double> get thumbUpPoints => $composableBuilder(
    column: $table.thumbUpPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get thumbDownPoints => $composableBuilder(
    column: $table.thumbDownPoints,
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

class $$CustomHabitOrganEffectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomHabitOrganEffectsTable> {
  $$CustomHabitOrganEffectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get partKey =>
      $composableBuilder(column: $table.partKey, builder: (column) => column);

  GeneratedColumn<double> get thumbUpPoints => $composableBuilder(
    column: $table.thumbUpPoints,
    builder: (column) => column,
  );

  GeneratedColumn<double> get thumbDownPoints => $composableBuilder(
    column: $table.thumbDownPoints,
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

class $$CustomHabitOrganEffectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomHabitOrganEffectsTable,
          CustomHabitOrganEffectRow,
          $$CustomHabitOrganEffectsTableFilterComposer,
          $$CustomHabitOrganEffectsTableOrderingComposer,
          $$CustomHabitOrganEffectsTableAnnotationComposer,
          $$CustomHabitOrganEffectsTableCreateCompanionBuilder,
          $$CustomHabitOrganEffectsTableUpdateCompanionBuilder,
          (CustomHabitOrganEffectRow, $$CustomHabitOrganEffectsTableReferences),
          CustomHabitOrganEffectRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$CustomHabitOrganEffectsTableTableManager(
    _$AppDatabase db,
    $CustomHabitOrganEffectsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomHabitOrganEffectsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CustomHabitOrganEffectsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CustomHabitOrganEffectsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> habitId = const Value.absent(),
                Value<String> partKey = const Value.absent(),
                Value<double> thumbUpPoints = const Value.absent(),
                Value<double> thumbDownPoints = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomHabitOrganEffectsCompanion(
                habitId: habitId,
                partKey: partKey,
                thumbUpPoints: thumbUpPoints,
                thumbDownPoints: thumbDownPoints,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String habitId,
                required String partKey,
                Value<double> thumbUpPoints = const Value.absent(),
                Value<double> thumbDownPoints = const Value.absent(),
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomHabitOrganEffectsCompanion.insert(
                habitId: habitId,
                partKey: partKey,
                thumbUpPoints: thumbUpPoints,
                thumbDownPoints: thumbDownPoints,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomHabitOrganEffectsTableReferences(db, table, e),
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
                                    $$CustomHabitOrganEffectsTableReferences
                                        ._habitIdTable(db),
                                referencedColumn:
                                    $$CustomHabitOrganEffectsTableReferences
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

typedef $$CustomHabitOrganEffectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomHabitOrganEffectsTable,
      CustomHabitOrganEffectRow,
      $$CustomHabitOrganEffectsTableFilterComposer,
      $$CustomHabitOrganEffectsTableOrderingComposer,
      $$CustomHabitOrganEffectsTableAnnotationComposer,
      $$CustomHabitOrganEffectsTableCreateCompanionBuilder,
      $$CustomHabitOrganEffectsTableUpdateCompanionBuilder,
      (CustomHabitOrganEffectRow, $$CustomHabitOrganEffectsTableReferences),
      CustomHabitOrganEffectRow,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$StandardHabitOrganEffectsTableCreateCompanionBuilder =
    StandardHabitOrganEffectsCompanion Function({
      required String habitId,
      required String partKey,
      Value<double> thumbUpPoints,
      Value<double> thumbDownPoints,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<int> rowid,
    });
typedef $$StandardHabitOrganEffectsTableUpdateCompanionBuilder =
    StandardHabitOrganEffectsCompanion Function({
      Value<String> habitId,
      Value<String> partKey,
      Value<double> thumbUpPoints,
      Value<double> thumbDownPoints,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<int> rowid,
    });

final class $$StandardHabitOrganEffectsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $StandardHabitOrganEffectsTable,
          StandardHabitOrganEffectRow
        > {
  $$StandardHabitOrganEffectsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitDefinitionsTable _habitIdTable(_$AppDatabase db) =>
      db.habitDefinitions.createAlias(
        'standard_habit_organ_effects__habit_id__habit_definitions__id',
      );

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

class $$StandardHabitOrganEffectsTableFilterComposer
    extends Composer<_$AppDatabase, $StandardHabitOrganEffectsTable> {
  $$StandardHabitOrganEffectsTableFilterComposer({
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

  ColumnFilters<double> get thumbUpPoints => $composableBuilder(
    column: $table.thumbUpPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get thumbDownPoints => $composableBuilder(
    column: $table.thumbDownPoints,
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

class $$StandardHabitOrganEffectsTableOrderingComposer
    extends Composer<_$AppDatabase, $StandardHabitOrganEffectsTable> {
  $$StandardHabitOrganEffectsTableOrderingComposer({
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

  ColumnOrderings<double> get thumbUpPoints => $composableBuilder(
    column: $table.thumbUpPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get thumbDownPoints => $composableBuilder(
    column: $table.thumbDownPoints,
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

class $$StandardHabitOrganEffectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StandardHabitOrganEffectsTable> {
  $$StandardHabitOrganEffectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get partKey =>
      $composableBuilder(column: $table.partKey, builder: (column) => column);

  GeneratedColumn<double> get thumbUpPoints => $composableBuilder(
    column: $table.thumbUpPoints,
    builder: (column) => column,
  );

  GeneratedColumn<double> get thumbDownPoints => $composableBuilder(
    column: $table.thumbDownPoints,
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

class $$StandardHabitOrganEffectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StandardHabitOrganEffectsTable,
          StandardHabitOrganEffectRow,
          $$StandardHabitOrganEffectsTableFilterComposer,
          $$StandardHabitOrganEffectsTableOrderingComposer,
          $$StandardHabitOrganEffectsTableAnnotationComposer,
          $$StandardHabitOrganEffectsTableCreateCompanionBuilder,
          $$StandardHabitOrganEffectsTableUpdateCompanionBuilder,
          (
            StandardHabitOrganEffectRow,
            $$StandardHabitOrganEffectsTableReferences,
          ),
          StandardHabitOrganEffectRow,
          PrefetchHooks Function({bool habitId})
        > {
  $$StandardHabitOrganEffectsTableTableManager(
    _$AppDatabase db,
    $StandardHabitOrganEffectsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StandardHabitOrganEffectsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$StandardHabitOrganEffectsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StandardHabitOrganEffectsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> habitId = const Value.absent(),
                Value<String> partKey = const Value.absent(),
                Value<double> thumbUpPoints = const Value.absent(),
                Value<double> thumbDownPoints = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StandardHabitOrganEffectsCompanion(
                habitId: habitId,
                partKey: partKey,
                thumbUpPoints: thumbUpPoints,
                thumbDownPoints: thumbDownPoints,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String habitId,
                required String partKey,
                Value<double> thumbUpPoints = const Value.absent(),
                Value<double> thumbDownPoints = const Value.absent(),
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StandardHabitOrganEffectsCompanion.insert(
                habitId: habitId,
                partKey: partKey,
                thumbUpPoints: thumbUpPoints,
                thumbDownPoints: thumbDownPoints,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StandardHabitOrganEffectsTableReferences(db, table, e),
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
                                    $$StandardHabitOrganEffectsTableReferences
                                        ._habitIdTable(db),
                                referencedColumn:
                                    $$StandardHabitOrganEffectsTableReferences
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

typedef $$StandardHabitOrganEffectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StandardHabitOrganEffectsTable,
      StandardHabitOrganEffectRow,
      $$StandardHabitOrganEffectsTableFilterComposer,
      $$StandardHabitOrganEffectsTableOrderingComposer,
      $$StandardHabitOrganEffectsTableAnnotationComposer,
      $$StandardHabitOrganEffectsTableCreateCompanionBuilder,
      $$StandardHabitOrganEffectsTableUpdateCompanionBuilder,
      (StandardHabitOrganEffectRow, $$StandardHabitOrganEffectsTableReferences),
      StandardHabitOrganEffectRow,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$NumericalHabitEntriesTableCreateCompanionBuilder =
    NumericalHabitEntriesCompanion Function({
      required String id,
      required String habitId,
      required DateTime localDay,
      Value<int?> value,
      required double outcomeFactor,
      required bool actualDidHabit,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<int> rowid,
    });
typedef $$NumericalHabitEntriesTableUpdateCompanionBuilder =
    NumericalHabitEntriesCompanion Function({
      Value<String> id,
      Value<String> habitId,
      Value<DateTime> localDay,
      Value<int?> value,
      Value<double> outcomeFactor,
      Value<bool> actualDidHabit,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<int> rowid,
    });

final class $$NumericalHabitEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $NumericalHabitEntriesTable,
          NumericalHabitEntryRow
        > {
  $$NumericalHabitEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitDefinitionsTable _habitIdTable(_$AppDatabase db) => db
      .habitDefinitions
      .createAlias('numerical_habit_entries__habit_id__habit_definitions__id');

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

  static MultiTypedResultKey<
    $NumericalBodyContributionsTable,
    List<NumericalBodyContributionRow>
  >
  _numericalBodyContributionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.numericalBodyContributions,
    aliasName:
        'numerical_habit_entries__id__numerical_body_contributions__entry_id',
  );

  $$NumericalBodyContributionsTableProcessedTableManager
  get numericalBodyContributionsRefs {
    final manager = $$NumericalBodyContributionsTableTableManager(
      $_db,
      $_db.numericalBodyContributions,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _numericalBodyContributionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NumericalHabitEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $NumericalHabitEntriesTable> {
  $$NumericalHabitEntriesTableFilterComposer({
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

  ColumnFilters<DateTime> get localDay => $composableBuilder(
    column: $table.localDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get outcomeFactor => $composableBuilder(
    column: $table.outcomeFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get actualDidHabit => $composableBuilder(
    column: $table.actualDidHabit,
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

  Expression<bool> numericalBodyContributionsRefs(
    Expression<bool> Function($$NumericalBodyContributionsTableFilterComposer f)
    f,
  ) {
    final $$NumericalBodyContributionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.numericalBodyContributions,
          getReferencedColumn: (t) => t.entryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NumericalBodyContributionsTableFilterComposer(
                $db: $db,
                $table: $db.numericalBodyContributions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$NumericalHabitEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $NumericalHabitEntriesTable> {
  $$NumericalHabitEntriesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get localDay => $composableBuilder(
    column: $table.localDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get outcomeFactor => $composableBuilder(
    column: $table.outcomeFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get actualDidHabit => $composableBuilder(
    column: $table.actualDidHabit,
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

class $$NumericalHabitEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NumericalHabitEntriesTable> {
  $$NumericalHabitEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get localDay =>
      $composableBuilder(column: $table.localDay, builder: (column) => column);

  GeneratedColumn<int> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<double> get outcomeFactor => $composableBuilder(
    column: $table.outcomeFactor,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get actualDidHabit => $composableBuilder(
    column: $table.actualDidHabit,
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

  Expression<T> numericalBodyContributionsRefs<T extends Object>(
    Expression<T> Function(
      $$NumericalBodyContributionsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$NumericalBodyContributionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.numericalBodyContributions,
          getReferencedColumn: (t) => t.entryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NumericalBodyContributionsTableAnnotationComposer(
                $db: $db,
                $table: $db.numericalBodyContributions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$NumericalHabitEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NumericalHabitEntriesTable,
          NumericalHabitEntryRow,
          $$NumericalHabitEntriesTableFilterComposer,
          $$NumericalHabitEntriesTableOrderingComposer,
          $$NumericalHabitEntriesTableAnnotationComposer,
          $$NumericalHabitEntriesTableCreateCompanionBuilder,
          $$NumericalHabitEntriesTableUpdateCompanionBuilder,
          (NumericalHabitEntryRow, $$NumericalHabitEntriesTableReferences),
          NumericalHabitEntryRow,
          PrefetchHooks Function({
            bool habitId,
            bool numericalBodyContributionsRefs,
          })
        > {
  $$NumericalHabitEntriesTableTableManager(
    _$AppDatabase db,
    $NumericalHabitEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NumericalHabitEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NumericalHabitEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NumericalHabitEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<DateTime> localDay = const Value.absent(),
                Value<int?> value = const Value.absent(),
                Value<double> outcomeFactor = const Value.absent(),
                Value<bool> actualDidHabit = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NumericalHabitEntriesCompanion(
                id: id,
                habitId: habitId,
                localDay: localDay,
                value: value,
                outcomeFactor: outcomeFactor,
                actualDidHabit: actualDidHabit,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String habitId,
                required DateTime localDay,
                Value<int?> value = const Value.absent(),
                required double outcomeFactor,
                required bool actualDidHabit,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NumericalHabitEntriesCompanion.insert(
                id: id,
                habitId: habitId,
                localDay: localDay,
                value: value,
                outcomeFactor: outcomeFactor,
                actualDidHabit: actualDidHabit,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NumericalHabitEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({habitId = false, numericalBodyContributionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (numericalBodyContributionsRefs)
                      db.numericalBodyContributions,
                  ],
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
                                        $$NumericalHabitEntriesTableReferences
                                            ._habitIdTable(db),
                                    referencedColumn:
                                        $$NumericalHabitEntriesTableReferences
                                            ._habitIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (numericalBodyContributionsRefs)
                        await $_getPrefetchedData<
                          NumericalHabitEntryRow,
                          $NumericalHabitEntriesTable,
                          NumericalBodyContributionRow
                        >(
                          currentTable: table,
                          referencedTable:
                              $$NumericalHabitEntriesTableReferences
                                  ._numericalBodyContributionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$NumericalHabitEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).numericalBodyContributionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
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

typedef $$NumericalHabitEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NumericalHabitEntriesTable,
      NumericalHabitEntryRow,
      $$NumericalHabitEntriesTableFilterComposer,
      $$NumericalHabitEntriesTableOrderingComposer,
      $$NumericalHabitEntriesTableAnnotationComposer,
      $$NumericalHabitEntriesTableCreateCompanionBuilder,
      $$NumericalHabitEntriesTableUpdateCompanionBuilder,
      (NumericalHabitEntryRow, $$NumericalHabitEntriesTableReferences),
      NumericalHabitEntryRow,
      PrefetchHooks Function({
        bool habitId,
        bool numericalBodyContributionsRefs,
      })
    >;
typedef $$NumericalBodyContributionsTableCreateCompanionBuilder =
    NumericalBodyContributionsCompanion Function({
      required String entryId,
      required String partKey,
      required double points,
      Value<int> rowid,
    });
typedef $$NumericalBodyContributionsTableUpdateCompanionBuilder =
    NumericalBodyContributionsCompanion Function({
      Value<String> entryId,
      Value<String> partKey,
      Value<double> points,
      Value<int> rowid,
    });

final class $$NumericalBodyContributionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $NumericalBodyContributionsTable,
          NumericalBodyContributionRow
        > {
  $$NumericalBodyContributionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $NumericalHabitEntriesTable _entryIdTable(_$AppDatabase db) =>
      db.numericalHabitEntries.createAlias(
        'numerical_body_contributions__entry_id__numerical_habit_entries__id',
      );

  $$NumericalHabitEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager = $$NumericalHabitEntriesTableTableManager(
      $_db,
      $_db.numericalHabitEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NumericalBodyContributionsTableFilterComposer
    extends Composer<_$AppDatabase, $NumericalBodyContributionsTable> {
  $$NumericalBodyContributionsTableFilterComposer({
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

  ColumnFilters<double> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnFilters(column),
  );

  $$NumericalHabitEntriesTableFilterComposer get entryId {
    final $$NumericalHabitEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.entryId,
          referencedTable: $db.numericalHabitEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NumericalHabitEntriesTableFilterComposer(
                $db: $db,
                $table: $db.numericalHabitEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$NumericalBodyContributionsTableOrderingComposer
    extends Composer<_$AppDatabase, $NumericalBodyContributionsTable> {
  $$NumericalBodyContributionsTableOrderingComposer({
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

  ColumnOrderings<double> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnOrderings(column),
  );

  $$NumericalHabitEntriesTableOrderingComposer get entryId {
    final $$NumericalHabitEntriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.entryId,
          referencedTable: $db.numericalHabitEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NumericalHabitEntriesTableOrderingComposer(
                $db: $db,
                $table: $db.numericalHabitEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$NumericalBodyContributionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NumericalBodyContributionsTable> {
  $$NumericalBodyContributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get partKey =>
      $composableBuilder(column: $table.partKey, builder: (column) => column);

  GeneratedColumn<double> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  $$NumericalHabitEntriesTableAnnotationComposer get entryId {
    final $$NumericalHabitEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.entryId,
          referencedTable: $db.numericalHabitEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NumericalHabitEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.numericalHabitEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$NumericalBodyContributionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NumericalBodyContributionsTable,
          NumericalBodyContributionRow,
          $$NumericalBodyContributionsTableFilterComposer,
          $$NumericalBodyContributionsTableOrderingComposer,
          $$NumericalBodyContributionsTableAnnotationComposer,
          $$NumericalBodyContributionsTableCreateCompanionBuilder,
          $$NumericalBodyContributionsTableUpdateCompanionBuilder,
          (
            NumericalBodyContributionRow,
            $$NumericalBodyContributionsTableReferences,
          ),
          NumericalBodyContributionRow,
          PrefetchHooks Function({bool entryId})
        > {
  $$NumericalBodyContributionsTableTableManager(
    _$AppDatabase db,
    $NumericalBodyContributionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NumericalBodyContributionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NumericalBodyContributionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NumericalBodyContributionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> entryId = const Value.absent(),
                Value<String> partKey = const Value.absent(),
                Value<double> points = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NumericalBodyContributionsCompanion(
                entryId: entryId,
                partKey: partKey,
                points: points,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String entryId,
                required String partKey,
                required double points,
                Value<int> rowid = const Value.absent(),
              }) => NumericalBodyContributionsCompanion.insert(
                entryId: entryId,
                partKey: partKey,
                points: points,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NumericalBodyContributionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false}) {
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
                    if (entryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entryId,
                                referencedTable:
                                    $$NumericalBodyContributionsTableReferences
                                        ._entryIdTable(db),
                                referencedColumn:
                                    $$NumericalBodyContributionsTableReferences
                                        ._entryIdTable(db)
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

typedef $$NumericalBodyContributionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NumericalBodyContributionsTable,
      NumericalBodyContributionRow,
      $$NumericalBodyContributionsTableFilterComposer,
      $$NumericalBodyContributionsTableOrderingComposer,
      $$NumericalBodyContributionsTableAnnotationComposer,
      $$NumericalBodyContributionsTableCreateCompanionBuilder,
      $$NumericalBodyContributionsTableUpdateCompanionBuilder,
      (
        NumericalBodyContributionRow,
        $$NumericalBodyContributionsTableReferences,
      ),
      NumericalBodyContributionRow,
      PrefetchHooks Function({bool entryId})
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
  $$NamedCustomGraphsTableTableManager get namedCustomGraphs =>
      $$NamedCustomGraphsTableTableManager(_db, _db.namedCustomGraphs);
  $$NamedCustomGraphRulesTableTableManager get namedCustomGraphRules =>
      $$NamedCustomGraphRulesTableTableManager(_db, _db.namedCustomGraphRules);
  $$ReductionPlansTableTableManager get reductionPlans =>
      $$ReductionPlansTableTableManager(_db, _db.reductionPlans);
  $$GrowthPlansTableTableManager get growthPlans =>
      $$GrowthPlansTableTableManager(_db, _db.growthPlans);
  $$GrowthPlanEntriesTableTableManager get growthPlanEntries =>
      $$GrowthPlanEntriesTableTableManager(_db, _db.growthPlanEntries);
  $$HabitStreaksTableTableManager get habitStreaks =>
      $$HabitStreaksTableTableManager(_db, _db.habitStreaks);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$RewardStatesTableTableManager get rewardStates =>
      $$RewardStatesTableTableManager(_db, _db.rewardStates);
  $$RewardEventsTableTableManager get rewardEvents =>
      $$RewardEventsTableTableManager(_db, _db.rewardEvents);
  $$FeatureUnlocksTableTableManager get featureUnlocks =>
      $$FeatureUnlocksTableTableManager(_db, _db.featureUnlocks);
  $$CustomHabitOrganEffectsTableTableManager get customHabitOrganEffects =>
      $$CustomHabitOrganEffectsTableTableManager(
        _db,
        _db.customHabitOrganEffects,
      );
  $$StandardHabitOrganEffectsTableTableManager get standardHabitOrganEffects =>
      $$StandardHabitOrganEffectsTableTableManager(
        _db,
        _db.standardHabitOrganEffects,
      );
  $$NumericalHabitEntriesTableTableManager get numericalHabitEntries =>
      $$NumericalHabitEntriesTableTableManager(_db, _db.numericalHabitEntries);
  $$NumericalBodyContributionsTableTableManager
  get numericalBodyContributions =>
      $$NumericalBodyContributionsTableTableManager(
        _db,
        _db.numericalBodyContributions,
      );
}
