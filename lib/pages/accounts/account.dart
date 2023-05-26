import 'package:cat_budget/pages/dashboard/dashboard_bloc.dart';
import 'package:cat_budget/widgets/account_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => DashboardBloc(), child: _AccountPage());
  }
}

class _AccountPage extends StatelessWidget {
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
          AccountEntryWidget(
              id: 0,
              name: 'ING Bank',
              description: 'NL92 INGB 123456789',
              money: 100.00),
          AccountEntryWidget(
              id: 1,
              name: 'Savings account',
              description: 'Description one',
              money: 0.00),
          AccountEntryWidget(
              id: 2,
              name: 'Credit Card',
              description: 'Description one',
              money: -231.32),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue[200],
        child: const Icon(Icons.add),
      ),
    );
  }
}
