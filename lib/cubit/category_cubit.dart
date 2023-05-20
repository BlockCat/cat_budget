import 'package:bloc/bloc.dart';
import 'package:cat_budget/models/category_group.dart';

import '../models/category.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit()
      : super(const CategoryState(groups: [
          CategoryGroup(id: 0, name: 'Bills', categories: [
            Category(id: 0, name: 'Rent', budget: 610.84, total: 0),
            Category(id: 1, name: 'Electricity', budget: 0, total: 0),
            Category(id: 2, name: 'Water', budget: 0, total: 0),
            Category(id: 3, name: 'Internet', budget: 0, total: 0),
            Category(id: 4, name: 'Phone', budget: 0, total: 0),
            Category(id: 5, name: 'Insurance', budget: 0, total: 0),
            Category(id: 6, name: 'Taxes', budget: 0, total: 0),
            Category(id: 7, name: 'Other', budget: 0, total: 0),
          ]),
          CategoryGroup(id: 1, name: 'Frequent', categories: [
            Category(id: 8, name: 'Groceries', budget: 0, total: 0),
            Category(id: 9, name: 'Car', budget: 0, total: 0),
            Category(id: 10, name: 'Transport', budget: 0, total: 0),
            Category(id: 11, name: 'Other', budget: 0, total: 0),
          ]),
          CategoryGroup(id: 2, name: 'Other', categories: [
            Category(id: 12, name: 'Eating Out', budget: 0, total: 0),
            Category(id: 13, name: 'Entertainment', budget: 0, total: 0),
            Category(id: 14, name: 'Shopping', budget: 0, total: 0),
            Category(id: 15, name: 'Other', budget: 0, total: 0),
          ]),
          CategoryGroup(id: 3, name: 'Givings', categories: [
            Category(id: 16, name: 'Church', budget: 0, total: 0),
            Category(id: 17, name: 'Charity', budget: 0, total: 0),
            Category(id: 18, name: 'Gifts', budget: 0, total: 0),
            Category(id: 19, name: 'Other', budget: 0, total: 0),
          ]),
          CategoryGroup(id: 4, name: 'Goals', categories: [
            Category(id: 20, name: 'Savings', budget: 0, total: 0),
            Category(id: 21, name: 'Investments', budget: 0, total: 0),
            Category(id: 22, name: 'Other', budget: 0, total: 0),
          ]),
          CategoryGroup(id: 5, name: 'Debts', categories: [
            Category(id: 23, name: 'Student Loan', budget: 0, total: 0),
          ])
        ]));
}

class CategoryState {
  // Dictorary of categories
  final List<CategoryGroup> groups;

  const CategoryState({this.groups = const []});
}
