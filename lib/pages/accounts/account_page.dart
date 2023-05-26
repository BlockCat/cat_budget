import 'package:cat_budget/data/database/database.dart';
import 'package:cat_budget/pages/dashboard/dashboard_bloc.dart';
import 'package:cat_budget/pages/transactions/transaction_page.dart';
import 'package:cat_budget/widgets/account_widget.dart';
import 'package:cat_budget/widgets/expandable_fab.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => DashboardBloc(), child: _AccountPage());
  }
}

class _AccountPage extends StatelessWidget {
  final Stream<List<Account>> accountsStream =
      GetIt.I.get<MainDatabase>().accounts.select().watch();

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
        child: StreamBuilder(
            stream: accountsStream,
            initialData: const [],
            builder: (context, snapshot) => ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final account = snapshot.data![index] as Account;
                    return AccountEntryWidget(
                      id: account.id,
                      name: account.name,
                      money: account.balance,
                      description: account.description,
                    );
                  },
                )),
      ),
      floatingActionButton: ExpandableFab(distance: 70.0, children: [
        ActionButton(
          icon: const Icon(Icons.add_card_outlined),
          onPressed: () {},
        ),
        ActionButton(
          icon: const Icon(Icons.add_link_outlined),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionPage(),
                ));
          },
        ),
      ]),
    );
  }
}
