import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountEntryWidget extends StatelessWidget {
  const AccountEntryWidget(
      {super.key,
      required this.id,
      required this.name,
      this.description,
      required this.money});

  final int id;
  final String name;
  final String? description;
  final double money;

  @override
  Widget build(BuildContext context) {
    final Color moneyColour;

    if (money < 0) {
      moneyColour = Color.fromARGB(255, 255, 55, 68);
    } else if (money == 0) {
      moneyColour = const Color.fromARGB(255, 134, 134, 134);
    } else {
      moneyColour = Color.fromARGB(255, 66, 196, 75);
    }

    return Card(
      child: InkWell(
        onTap: () {
          _onCardClick(context);
        },
        child: Center(
          child: Container(
            height: 90,
            padding: const EdgeInsets.all(10),
            alignment: AlignmentDirectional.centerStart,
            child: Row(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description ?? '',
                    style: const TextStyle(
                        fontSize: 10,
                        decorationStyle: TextDecorationStyle.wavy),
                  ),
                ]),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(money.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 20,
                                color: moneyColour,
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
