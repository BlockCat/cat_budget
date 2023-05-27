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
  final int money;

  @override
  Widget build(BuildContext context) {
    final Color moneyColour;

    if (money < 0) {
      moneyColour = const Color.fromARGB(255, 255, 55, 68);
    } else if (money == 0) {
      moneyColour = const Color.fromARGB(255, 134, 134, 134);
    } else {
      moneyColour = const Color.fromARGB(255, 66, 196, 75);
    }

    final background = Container(
      color: Colors.blueGrey,
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.settings_rounded, color: Colors.white),
        ),
      ),
    );
    final secondaryBackground = Container(
      color: Colors.teal,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.attach_money_rounded, color: Colors.white),
        ),
      ),
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          _onCardClick(context);
        },
        child: Center(
          child: Dismissible(
            key: ValueKey(id),
   
            background: background,
            secondaryBackground: secondaryBackground,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                context.go('/transactions');                
              } else if (direction == DismissDirection.startToEnd) {
                context.go('/accounts/edit/$id');
              }
              return false;
            },
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
                          Text((money / 100.0).toStringAsFixed(2),
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
      ),
    );
  }

  _onCardClick(BuildContext context) {
    context.go('/accounts/details/$id');
  }
}
