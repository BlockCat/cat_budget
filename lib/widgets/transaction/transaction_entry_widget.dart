import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionEntryWidget extends StatelessWidget {
  const TransactionEntryWidget(
      {super.key,
      required this.id,
      required this.name,
      required this.accountName,
      required this.money,
      this.icon});

  final int id;
  final String name;
  final String accountName;
  final double money;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          _onCardClick(context);
        },
        child: Center(
          child: Container(
            height: 50,
            padding: const EdgeInsets.all(10),
            alignment: AlignmentDirectional.centerStart,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: icon ?? const Icon(Icons.money),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Text(accountName),
              const Text('Music: -23.23'),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(money.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 20,
                                color: money > 0
                                    ? const Color.fromARGB(255, 44, 73, 13)
                                    : Colors.blueGrey[900],
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.right),
                      ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  _onCardClick(BuildContext context) {}
}
