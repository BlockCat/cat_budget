import 'package:cat_budget/models/category.dart';
import 'package:cat_budget/models/category_group.dart';
import 'package:cat_budget/repository/category_group_repository.dart';
import 'package:cat_budget/repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardStateInitial()) {
    on<SaveCategoriesEvent>((event, emit) async {
      final categoryGroupRepository = GetIt.I<CategoryGroupRepository>();
      final categoryRepository = GetIt.I<CategoryRepository>();
      for (var element in event.groups) {
        int categoryGroupId = await categoryGroupRepository.upsert(element);
        for (var category in element.categories) {
          await categoryRepository.upsert(Category(
            id: category.id,
            name: category.name,
            sort: category.sort,
            categoryGroupId: categoryGroupId,
            budget: category.budget,
            type: category.type,
            targetDate: category.targetDate,
          ));
        }
      }
      emit(DashboardState(groups: event.groups));
    });
  }
}
