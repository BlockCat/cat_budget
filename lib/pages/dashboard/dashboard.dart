import 'package:cat_budget/pages/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => DashboardBloc(), child: _HomePage());
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CatBudget'),
      ),
      body: ListView(
        children: const [
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          Divider(),
          ListTile(
            title: Text('Other category'),
            subtitle: Text('total budget account: \$0.00'),
          ),
          Divider(),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
           SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
           SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
          SizedBox(
            height: 40,
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
