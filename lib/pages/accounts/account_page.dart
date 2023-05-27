import 'package:cat_budget/data/database/database.dart';
import 'package:cat_budget/pages/accounts/add_account_page.dart';
import 'package:cat_budget/pages/dashboard/dashboard_bloc.dart';
import 'package:cat_budget/widgets/account_entry_widget.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

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
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Accounts'),
            contentPadding: const EdgeInsets.all(10),
            trailing: IconButton(
              icon: const Icon(Icons.add_link),
              onPressed: () {
                _onAddUnlinkedAccountPressed(context);
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: Center(
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
          )
        ],
      ),
      // floatingActionButton: ExpandableFab(distance: 70.0, children: [
      //   ActionButton(
      //     icon: const Icon(Icons.add_card_outlined),
      //     onPressed: () {
      //       _onAddUnlinkedAccountPressed(context);
      //     },
      //   ),
      //   ActionButton(
      //     icon: const Icon(Icons.add_link_outlined),
      //     onPressed: _onAddLinkedAccountPressed,
      //   ),
      // ]),
    );
  }

  void _onAddUnlinkedAccountPressed(BuildContext context) async {
    final result =
        await context.push<AddAccountFormResult>('/accounts/add');

    if (result != null) {
      GetIt.I.get<MainDatabase>().accounts.insertOne(
            AccountsCompanion.insert(
              name: result.accountName,
              description: drift.Value(result.accountDescription),
              balance: drift.Value(result.balance),
              type: 0,
            ),
          );
    }
  }
}
