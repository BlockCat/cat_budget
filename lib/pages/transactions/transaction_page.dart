import 'dart:math';

import 'package:cat_budget/pages/dashboard/dashboard_bloc.dart';
import 'package:cat_budget/widgets/transaction/transaction_entry_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_icons/simple_icons.dart';

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
    List<Widget> transactions = [];

    var icons = const [
      Icon(SimpleIcons.spotify, color: Colors.green),
      Icon(SimpleIcons.google, color: Colors.blue),
      Icon(SimpleIcons.nintendo, color: Colors.red),
      Icon(SimpleIcons.mediamarkt, color: Colors.red),
      Icon(SimpleIcons.directus, color: Colors.purple),
      Icon(SimpleIcons.ikea, color: Colors.blue),
      Icon(SimpleIcons.paypal, color: Colors.blue),
      Icon(SimpleIcons.amazon, color: Colors.orange),
      Icon(SimpleIcons.apple, color: Colors.grey),
      Icon(SimpleIcons.microsoft, color: Colors.blue),
      Icon(SimpleIcons.netflix),
      Icon(SimpleIcons.unity, color: Colors.blue),
      Icon(SimpleIcons.ubisoft, color: Colors.blue),
      Icon(SimpleIcons.ea),
      null
    ];

    var random = Random();
    for (int i = 0; i < 100; i++) {
      transactions.add(TransactionEntryWidget(
          id: i,
          icon: icons[random.nextInt(icons.length)],
          name: 'Spotify',
          accountName: 'ING Bank',
          money: 1023 - i));
    }

    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [DrawerHeader(child: Text('CatBudget'))],
          ),
        ),
        body: Center(child: ListView(children: transactions)));
  }
}
