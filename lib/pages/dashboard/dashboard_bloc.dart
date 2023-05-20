import 'package:cat_budget/models/category.dart';
import 'package:cat_budget/models/category_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(CategoryInitial()) {
    on<SaveCategoriesEvent>((event, emit) async {
      event.groups.forEach((group) {
        group.categories[0].
      });
    });
  }
}
