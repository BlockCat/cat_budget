class Category {
  final int? id;
  final String name;
  final double budget;
  final DateTime? targetDate;
  final CategoryType type;

  final int categoryGroupId;

  final int sort;

  const Category({
    this.id,
    required this.name,
    required this.budget,
    this.targetDate,
    required this.type,
    required this.categoryGroupId,
    required this.sort,
  });

  @override
  String toString() {
    return 'Category(id: $id, name: $name, budget: $budget, targetDate: $targetDate, type: $type, categoryGroupId: $categoryGroupId, sort: $sort)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'budget': budget,
      'targetDate': targetDate?.millisecondsSinceEpoch,
      'type': type.index,
      'categoryGroupId': categoryGroupId,
      'sort': sort,
    };
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int?,
      name: map['name'] as String,
      budget: map['budget'] as double,
      targetDate: map['targetDate'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['targetDate'] as int),
      type: CategoryType.values[map['type'] as int],
      categoryGroupId: map['categoryGroupId'] as int,
      sort: map['sort'] as int,
    );
  }
}

enum CategoryType {
  /// Budget
  budget,

  /// Goal
  goal
}
