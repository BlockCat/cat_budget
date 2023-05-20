import 'package:cat_budget/pages/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => DashboardBloc(), child: _HomePage());
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [DrawerHeader(child: Text('CatBudget'))],
          ),
        ),
        appBar: AppBar(title: const Text('CatBudget')),
        body: Text('Hello World'));
  }
}
