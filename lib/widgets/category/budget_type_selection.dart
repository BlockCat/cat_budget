import 'package:cat_budget/data/models/budget_type.dart';
import 'package:flutter/material.dart';

class BudgetTypeSelection extends StatefulWidget {
  final BudgetData? budgetData;

  const BudgetTypeSelection({super.key, this.budgetData});

  @override
  State<StatefulWidget> createState() => _BudgetTypeSelectionState();
}

class _BudgetTypeSelectionState extends State<BudgetTypeSelection> {
  BudgetType _budgetType = BudgetType.envelope;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        // padding: const EdgeInsets.all(10),
        child: Column(children: [
          _buildButtonOptions(),
          _buildConfiguration(),
        ]),
      ),
    );
  }

  _buildButtonOptions() {
    return SegmentedButton<BudgetType>(
        segments: const <ButtonSegment<BudgetType>>[
          ButtonSegment<BudgetType>(
            label: Text("Envelope"),
            value: BudgetType.envelope,
            icon: Icon(Icons.mail),
          ),
          ButtonSegment<BudgetType>(
            label: Text("Monthly"),
            value: BudgetType.monthly,
            icon: Icon(Icons.calendar_month),
          ),
          ButtonSegment<BudgetType>(
            label: Text("Target"),
            value: BudgetType.target,
            icon: Icon(Icons.golf_course_sharp),
          ),
        ],
        emptySelectionAllowed: false,
        selectedIcon: const Icon(Icons.check),
        onSelectionChanged: (selection) =>
            setState(() => _budgetType = selection.first!),
        selected: {_budgetType});
  }

  _buildConfiguration() {
    switch (_budgetType) {
      case BudgetType.envelope:
        return _buildEnvelopeConfiguration();
      case BudgetType.monthly:
        return _buildMonthlyConfiguration();
      case BudgetType.target:
        return _buildTargetConfiguration();
    }
  }

  _buildEnvelopeConfiguration() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: const Text("You manually put money in the category each month"),
    );
  }

  _buildMonthlyConfiguration() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text("You set a monthly budget for the category"),
          TextFormField(
            decoration: const InputDecoration(labelText: "Monthly Budget"),
            autocorrect: true,
            autofocus: true,
            initialValue: "0",
          ),
        ],
      ),
    );
  }

  _buildTargetConfiguration() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text("You set a target amount for the category"),
          TextFormField(
            decoration: const InputDecoration(labelText: "Target Amount"),
            autocorrect: true,
            autofocus: true,
            initialValue: "0",
          ),
          CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
              onDateChanged: (date) {})
        ],
      ),
    );
  }
}
