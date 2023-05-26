import 'package:cat_budget/pages/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => DashboardBloc(), child: _TransactionPage());
  }
}

class _TransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [DrawerHeader(child: Text('CatBudget'))],
          ),
        ),
        body: Center(
            child: ListView(children: const [
          SizedBox(height: 50, child: Placeholder()),
          SizedBox(height: 100, child: Placeholder()),
          SizedBox(height: 100, child: Placeholder()),
          SizedBox(height: 100, child: Placeholder()),
        ])));
  }
}
