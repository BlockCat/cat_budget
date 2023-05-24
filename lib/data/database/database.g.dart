// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Accounts extends Table with TableInfo<Accounts, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Accounts(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT NOT NULL');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _balanceMeta =
      const VerificationMeta('balance');
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
      'balance', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  @override
  List<GeneratedColumn> get $columns => [id, name, description, type, balance];
  @override
  String get aliasedName => _alias ?? 'accounts';
  @override
  String get actualTableName => 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<Account> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      balance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}balance'])!,
    );
  }

  @override
  Accounts createAlias(String alias) {
    return Accounts(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Account extends DataClass implements Insertable<Account> {
  final int id;
  final String name;
  final String? description;
  final int type;
  final double balance;
  const Account(
      {required this.id,
      required this.name,
      this.description,
      required this.type,
      required this.balance});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['type'] = Variable<int>(type);
    map['balance'] = Variable<double>(balance);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: Value(type),
      balance: Value(balance),
    );
  }

  factory Account.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      type: serializer.fromJson<int>(json['type']),
      balance: serializer.fromJson<double>(json['balance']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'type': serializer.toJson<int>(type),
      'balance': serializer.toJson<double>(balance),
    };
  }

  Account copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          int? type,
          double? balance}) =>
      Account(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        type: type ?? this.type,
        balance: balance ?? this.balance,
      );
  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('balance: $balance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, type, balance);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.type == this.type &&
          other.balance == this.balance);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> type;
  final Value<double> balance;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.balance = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required int type,
    this.balance = const Value.absent(),
  })  : name = Value(name),
        type = Value(type);
  static Insertable<Account> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? type,
    Expression<double>? balance,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (balance != null) 'balance': balance,
    });
  }

  AccountsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<int>? type,
      Value<double>? balance}) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      balance: balance ?? this.balance,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('balance: $balance')
          ..write(')'))
        .toString();
  }
}

class Categories extends Table with TableInfo<Categories, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Categories(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT NOT NULL');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, name, description];
  @override
  String get aliasedName => _alias ?? 'categories';
  @override
  String get actualTableName => 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  Categories createAlias(String alias) {
    return Categories(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final String? description;
  const Category({required this.id, required this.name, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  Category copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent()}) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String?>? description}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class CategoryEnvelopes extends Table
    with TableInfo<CategoryEnvelopes, CategoryEnvelope> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CategoryEnvelopes(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT NOT NULL');
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  late final GeneratedColumn<DateTime> period = GeneratedColumn<DateTime>(
      'period', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _budgetMeta = const VerificationMeta('budget');
  late final GeneratedColumn<double> budget = GeneratedColumn<double>(
      'budget', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _balanceMeta =
      const VerificationMeta('balance');
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
      'balance', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, categoryId, period, budget, balance];
  @override
  String get aliasedName => _alias ?? 'category_envelopes';
  @override
  String get actualTableName => 'category_envelopes';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryEnvelope> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('period')) {
      context.handle(_periodMeta,
          period.isAcceptableOrUnknown(data['period']!, _periodMeta));
    } else if (isInserting) {
      context.missing(_periodMeta);
    }
    if (data.containsKey('budget')) {
      context.handle(_budgetMeta,
          budget.isAcceptableOrUnknown(data['budget']!, _budgetMeta));
    } else if (isInserting) {
      context.missing(_budgetMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(_balanceMeta,
          balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEnvelope map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryEnvelope(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      period: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}period'])!,
      budget: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}budget'])!,
      balance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}balance'])!,
    );
  }

  @override
  CategoryEnvelopes createAlias(String alias) {
    return CategoryEnvelopes(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(category_id)REFERENCES categories(id)ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class CategoryEnvelope extends DataClass
    implements Insertable<CategoryEnvelope> {
  final int id;
  final int categoryId;
  final DateTime period;
  final double budget;
  final double balance;
  const CategoryEnvelope(
      {required this.id,
      required this.categoryId,
      required this.period,
      required this.budget,
      required this.balance});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['period'] = Variable<DateTime>(period);
    map['budget'] = Variable<double>(budget);
    map['balance'] = Variable<double>(balance);
    return map;
  }

  CategoryEnvelopesCompanion toCompanion(bool nullToAbsent) {
    return CategoryEnvelopesCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      period: Value(period),
      budget: Value(budget),
      balance: Value(balance),
    );
  }

  factory CategoryEnvelope.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryEnvelope(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['category_id']),
      period: serializer.fromJson<DateTime>(json['period']),
      budget: serializer.fromJson<double>(json['budget']),
      balance: serializer.fromJson<double>(json['balance']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category_id': serializer.toJson<int>(categoryId),
      'period': serializer.toJson<DateTime>(period),
      'budget': serializer.toJson<double>(budget),
      'balance': serializer.toJson<double>(balance),
    };
  }

  CategoryEnvelope copyWith(
          {int? id,
          int? categoryId,
          DateTime? period,
          double? budget,
          double? balance}) =>
      CategoryEnvelope(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        period: period ?? this.period,
        budget: budget ?? this.budget,
        balance: balance ?? this.balance,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryEnvelope(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('period: $period, ')
          ..write('budget: $budget, ')
          ..write('balance: $balance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, categoryId, period, budget, balance);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryEnvelope &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.period == this.period &&
          other.budget == this.budget &&
          other.balance == this.balance);
}

class CategoryEnvelopesCompanion extends UpdateCompanion<CategoryEnvelope> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<DateTime> period;
  final Value<double> budget;
  final Value<double> balance;
  const CategoryEnvelopesCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.period = const Value.absent(),
    this.budget = const Value.absent(),
    this.balance = const Value.absent(),
  });
  CategoryEnvelopesCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required DateTime period,
    required double budget,
    this.balance = const Value.absent(),
  })  : categoryId = Value(categoryId),
        period = Value(period),
        budget = Value(budget);
  static Insertable<CategoryEnvelope> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<DateTime>? period,
    Expression<double>? budget,
    Expression<double>? balance,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (period != null) 'period': period,
      if (budget != null) 'budget': budget,
      if (balance != null) 'balance': balance,
    });
  }

  CategoryEnvelopesCompanion copyWith(
      {Value<int>? id,
      Value<int>? categoryId,
      Value<DateTime>? period,
      Value<double>? budget,
      Value<double>? balance}) {
    return CategoryEnvelopesCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      period: period ?? this.period,
      budget: budget ?? this.budget,
      balance: balance ?? this.balance,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (period.present) {
      map['period'] = Variable<DateTime>(period.value);
    }
    if (budget.present) {
      map['budget'] = Variable<double>(budget.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryEnvelopesCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('period: $period, ')
          ..write('budget: $budget, ')
          ..write('balance: $balance')
          ..write(')'))
        .toString();
  }
}

class BankTransactions extends Table
    with TableInfo<BankTransactions, BankTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  BankTransactions(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT NOT NULL');
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
      'account_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, accountId, amount, date, description];
  @override
  String get aliasedName => _alias ?? 'bank_transactions';
  @override
  String get actualTableName => 'bank_transactions';
  @override
  VerificationContext validateIntegrity(Insertable<BankTransaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankTransaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}account_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  BankTransactions createAlias(String alias) {
    return BankTransactions(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(account_id)REFERENCES accounts(id)ON DELETE CASCADE'];
  @override
  bool get dontWriteConstraints => true;
}

class BankTransaction extends DataClass implements Insertable<BankTransaction> {
  final int id;
  final int accountId;
  final double amount;
  final DateTime date;
  final String? description;
  const BankTransaction(
      {required this.id,
      required this.accountId,
      required this.amount,
      required this.date,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<int>(accountId);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  BankTransactionsCompanion toCompanion(bool nullToAbsent) {
    return BankTransactionsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      amount: Value(amount),
      date: Value(date),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory BankTransaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankTransaction(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int>(json['account_id']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'account_id': serializer.toJson<int>(accountId),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String?>(description),
    };
  }

  BankTransaction copyWith(
          {int? id,
          int? accountId,
          double? amount,
          DateTime? date,
          Value<String?> description = const Value.absent()}) =>
      BankTransaction(
        id: id ?? this.id,
        accountId: accountId ?? this.accountId,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('BankTransaction(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, accountId, amount, date, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankTransaction &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.description == this.description);
}

class BankTransactionsCompanion extends UpdateCompanion<BankTransaction> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String?> description;
  const BankTransactionsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
  });
  BankTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    required double amount,
    required DateTime date,
    this.description = const Value.absent(),
  })  : accountId = Value(accountId),
        amount = Value(amount),
        date = Value(date);
  static Insertable<BankTransaction> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
    });
  }

  BankTransactionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? accountId,
      Value<double>? amount,
      Value<DateTime>? date,
      Value<String?>? description}) {
    return BankTransactionsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class BankTransactionCategory extends Table
    with TableInfo<BankTransactionCategory, BankTransactionCategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  BankTransactionCategory(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT NOT NULL');
  static const VerificationMeta _bankTransactionIdMeta =
      const VerificationMeta('bankTransactionId');
  late final GeneratedColumn<int> bankTransactionId = GeneratedColumn<int>(
      'bank_transaction_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, bankTransactionId, categoryId, amount];
  @override
  String get aliasedName => _alias ?? 'bank_transaction_category';
  @override
  String get actualTableName => 'bank_transaction_category';
  @override
  VerificationContext validateIntegrity(
      Insertable<BankTransactionCategoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bank_transaction_id')) {
      context.handle(
          _bankTransactionIdMeta,
          bankTransactionId.isAcceptableOrUnknown(
              data['bank_transaction_id']!, _bankTransactionIdMeta));
    } else if (isInserting) {
      context.missing(_bankTransactionIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankTransactionCategoryData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankTransactionCategoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bankTransactionId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}bank_transaction_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  BankTransactionCategory createAlias(String alias) {
    return BankTransactionCategory(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
        'FOREIGN KEY(bank_transaction_id)REFERENCES bank_transactions(id)ON DELETE CASCADE',
        'FOREIGN KEY(category_id)REFERENCES categories(id)ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class BankTransactionCategoryData extends DataClass
    implements Insertable<BankTransactionCategoryData> {
  final int id;
  final int bankTransactionId;
  final int categoryId;
  final double amount;
  const BankTransactionCategoryData(
      {required this.id,
      required this.bankTransactionId,
      required this.categoryId,
      required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bank_transaction_id'] = Variable<int>(bankTransactionId);
    map['category_id'] = Variable<int>(categoryId);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  BankTransactionCategoryCompanion toCompanion(bool nullToAbsent) {
    return BankTransactionCategoryCompanion(
      id: Value(id),
      bankTransactionId: Value(bankTransactionId),
      categoryId: Value(categoryId),
      amount: Value(amount),
    );
  }

  factory BankTransactionCategoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankTransactionCategoryData(
      id: serializer.fromJson<int>(json['id']),
      bankTransactionId: serializer.fromJson<int>(json['bank_transaction_id']),
      categoryId: serializer.fromJson<int>(json['category_id']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bank_transaction_id': serializer.toJson<int>(bankTransactionId),
      'category_id': serializer.toJson<int>(categoryId),
      'amount': serializer.toJson<double>(amount),
    };
  }

  BankTransactionCategoryData copyWith(
          {int? id, int? bankTransactionId, int? categoryId, double? amount}) =>
      BankTransactionCategoryData(
        id: id ?? this.id,
        bankTransactionId: bankTransactionId ?? this.bankTransactionId,
        categoryId: categoryId ?? this.categoryId,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('BankTransactionCategoryData(')
          ..write('id: $id, ')
          ..write('bankTransactionId: $bankTransactionId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bankTransactionId, categoryId, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankTransactionCategoryData &&
          other.id == this.id &&
          other.bankTransactionId == this.bankTransactionId &&
          other.categoryId == this.categoryId &&
          other.amount == this.amount);
}

class BankTransactionCategoryCompanion
    extends UpdateCompanion<BankTransactionCategoryData> {
  final Value<int> id;
  final Value<int> bankTransactionId;
  final Value<int> categoryId;
  final Value<double> amount;
  const BankTransactionCategoryCompanion({
    this.id = const Value.absent(),
    this.bankTransactionId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  BankTransactionCategoryCompanion.insert({
    this.id = const Value.absent(),
    required int bankTransactionId,
    required int categoryId,
    required double amount,
  })  : bankTransactionId = Value(bankTransactionId),
        categoryId = Value(categoryId),
        amount = Value(amount);
  static Insertable<BankTransactionCategoryData> custom({
    Expression<int>? id,
    Expression<int>? bankTransactionId,
    Expression<int>? categoryId,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bankTransactionId != null) 'bank_transaction_id': bankTransactionId,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
    });
  }

  BankTransactionCategoryCompanion copyWith(
      {Value<int>? id,
      Value<int>? bankTransactionId,
      Value<int>? categoryId,
      Value<double>? amount}) {
    return BankTransactionCategoryCompanion(
      id: id ?? this.id,
      bankTransactionId: bankTransactionId ?? this.bankTransactionId,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bankTransactionId.present) {
      map['bank_transaction_id'] = Variable<int>(bankTransactionId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankTransactionCategoryCompanion(')
          ..write('id: $id, ')
          ..write('bankTransactionId: $bankTransactionId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

abstract class _$MainDatabase extends GeneratedDatabase {
  _$MainDatabase(QueryExecutor e) : super(e);
  late final Accounts accounts = Accounts(this);
  late final Categories categories = Categories(this);
  late final CategoryEnvelopes categoryEnvelopes = CategoryEnvelopes(this);
  late final BankTransactions bankTransactions = BankTransactions(this);
  late final BankTransactionCategory bankTransactionCategory =
      BankTransactionCategory(this);
  late final Trigger categoryEnvelopeUpdated = Trigger(
      'CREATE TRIGGER IF NOT EXISTS category_envelope_updated AFTER UPDATE ON category_envelopes WHEN OLD.budget <> NEW.budget BEGIN UPDATE category_envelopes SET balance = balance - OLD.budget + NEW.budget WHERE id = NEW.id;END',
      'category_envelope_updated');
  late final Trigger categoryEnvelopeBalanceUpdated = Trigger(
      'CREATE TRIGGER IF NOT EXISTS category_envelope_balance_updated AFTER UPDATE ON category_envelopes WHEN OLD.balance <> NEW.balance BEGIN UPDATE category_envelopes SET balance = balance + max(NEW.balance - OLD.balance, -OLD.balance) WHERE category_id = NEW.category_id AND period > NEW.period;END',
      'category_envelope_balance_updated');
  late final Trigger bankTransactionCategoryInserted = Trigger(
      'CREATE TRIGGER IF NOT EXISTS bank_transaction_category_inserted AFTER INSERT ON bank_transaction_category BEGIN UPDATE category_envelopes SET balance = balance + NEW.amount WHERE category_id = NEW.category_id AND strftime(\'%Y-%m\', period, \'auto\') = (SELECT strftime(\'%Y-%m\', date, \'auto\') FROM bank_transactions AS bs WHERE bs.id = NEW.bank_transaction_id);END',
      'bank_transaction_category_inserted');
  late final Trigger bankTransactionCategoryUpdated = Trigger(
      'CREATE TRIGGER IF NOT EXISTS bank_transaction_category_updated AFTER UPDATE ON bank_transaction_category WHEN OLD.amount <> NEW.amount BEGIN UPDATE category_envelopes SET balance = balance - OLD.amount WHERE category_id = OLD.category_id AND strftime(\'%Y-%m\', period) = strftime(\'%Y-%m\', (SELECT date FROM bank_transactions WHERE bank_transactions.id = OLD.bank_transaction_id));UPDATE category_envelopes SET balance = balance + NEW.amount WHERE category_id = NEW.category_id AND strftime(\'%Y-%m\', period) = strftime(\'%Y-%m\', (SELECT date FROM bank_transactions WHERE bank_transactions.id = NEW.bank_transaction_id));END',
      'bank_transaction_category_updated');
  late final Trigger bankTransactionCategoryDeleted = Trigger(
      'CREATE TRIGGER IF NOT EXISTS bank_transaction_category_deleted AFTER DELETE ON bank_transaction_category BEGIN UPDATE category_envelopes SET balance = balance - OLD.amount WHERE category_id = OLD.category_id AND strftime(\'%Y-%m\', period) = strftime(\'%Y-%m\', (SELECT date FROM bank_transactions WHERE id = OLD.bank_transaction_id));END',
      'bank_transaction_category_deleted');
  late final Trigger transactionAddedUpdateAccount = Trigger(
      'CREATE TRIGGER IF NOT EXISTS transaction_added_update_account AFTER INSERT ON bank_transactions BEGIN UPDATE accounts SET balance = balance + NEW.amount WHERE id = NEW.account_id;END',
      'transaction_added_update_account');
  late final Trigger transactionUpdatedUpdateAccount = Trigger(
      'CREATE TRIGGER IF NOT EXISTS transaction_updated_update_account AFTER UPDATE ON bank_transactions WHEN OLD.amount <> NEW.amount OR OLD.account_id <> NEW.account_id BEGIN UPDATE accounts SET balance = balance - OLD.amount WHERE id = OLD.account_id;UPDATE accounts SET balance = balance + NEW.amount WHERE id = NEW.account_id;END',
      'transaction_updated_update_account');
  late final Trigger transactionDeletedUpdateAccount = Trigger(
      'CREATE TRIGGER IF NOT EXISTS transaction_deleted_update_account AFTER DELETE ON bank_transactions BEGIN UPDATE accounts SET balance = balance - OLD.amount WHERE id = OLD.account_id;END',
      'transaction_deleted_update_account');
  Selectable<double> moneyInBank() {
    return customSelect('SELECT SUM(balance) AS _c0 FROM accounts',
        variables: [],
        readsFrom: {
          accounts,
        }).map((QueryRow row) => row.read<double>('_c0'));
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        accounts,
        categories,
        categoryEnvelopes,
        bankTransactions,
        bankTransactionCategory,
        categoryEnvelopeUpdated,
        categoryEnvelopeBalanceUpdated,
        bankTransactionCategoryInserted,
        bankTransactionCategoryUpdated,
        bankTransactionCategoryDeleted,
        transactionAddedUpdateAccount,
        transactionUpdatedUpdateAccount,
        transactionDeletedUpdateAccount
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('categories',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('category_envelopes', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('accounts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('bank_transactions', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bank_transactions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('bank_transaction_category', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('categories',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('bank_transaction_category', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('category_envelopes',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('category_envelopes', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('category_envelopes',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('category_envelopes', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bank_transaction_category',
                limitUpdateKind: UpdateKind.insert),
            result: [
              TableUpdate('category_envelopes', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bank_transaction_category',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('category_envelopes', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bank_transaction_category',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('category_envelopes', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bank_transactions',
                limitUpdateKind: UpdateKind.insert),
            result: [
              TableUpdate('accounts', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bank_transactions',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('accounts', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bank_transactions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('accounts', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}
