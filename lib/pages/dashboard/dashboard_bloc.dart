import 'package:cat_budget/services/budget/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardStateInitial()) {
    on<SaveCategoriesEvent>((event, emit) async {});
    on<LoadStateEvent>((event, emit) async {});
    on<AddTransactionEvent>((event, emit) async {});
  }
}
