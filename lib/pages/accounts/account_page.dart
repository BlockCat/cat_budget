import 'dart:math';

import 'package:cat_budget/data/database/database.dart';
import 'package:cat_budget/pages/dashboard/dashboard_bloc.dart';
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
      floatingActionButton: ExpandableFab(distance: 112.0, children: [
        ActionButton(
          icon: const Icon(Icons.price_change_outlined),
          onPressed: () {},
        ),
        ActionButton(
          icon: const Icon(Icons.link),
          onPressed: () {},
        ),
      ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final database = GetIt.I.get<MainDatabase>();
      //     var random = Random();

      //     final accountId = await database.accounts.insertOne(
      //         AccountsCompanion.insert(
      //             name: 'My Account ${random.nextInt(1000)}',
      //             type: 0,
      //             balance: const Value(0)));

      //     await database.bankTransactions.insertOne(
      //       BankTransactionsCompanion.insert(
      //           accountId: accountId,
      //           amount: 2000,
      //           date: DateTime.now().toUtc()),
      //     );

      //     final iters = random.nextInt(7);
      //     for (int i = 0; i < iters; i++) {
      //       await Future.delayed(const Duration(seconds: 2));
      //       await database.bankTransactions.insertOne(
      //         BankTransactionsCompanion.insert(
      //             accountId: accountId,
      //             amount: (random.nextDouble() - 1) * 100,
      //             date: DateTime.now().toUtc()),
      //       );
      //     }
      //   },
      //   backgroundColor: Colors.blue[200],
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
