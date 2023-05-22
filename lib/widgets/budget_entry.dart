import 'package:flutter/widgets.dart';

class BudgetEntry extends StatelessWidget {
  const BudgetEntry({super.key, this.moneyUsed});

  final double? moneyUsed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            const Text('test'),
            Text('Total $moneyUsed/<placeholder>'),
          ],
        )
      ],
    );
  }
}
