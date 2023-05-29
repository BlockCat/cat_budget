import 'package:cat_budget/data/models/budget_type.dart';
import 'package:cat_budget/widgets/money_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BudgetTypeSelection extends StatefulWidget {
  final ValueNotifier<BudgetData> budgetDataController;
  final ValueChanged<BudgetData>? onBudgetDataChanged;

  const BudgetTypeSelection(
      {super.key,
      required this.budgetDataController,
      this.onBudgetDataChanged});

  @override
  State<StatefulWidget> createState() => _BudgetTypeSelectionState();
}

class _BudgetTypeSelectionState extends State<BudgetTypeSelection> {
  late BudgetType _budgetType;
  int _money = 0;
  DateTime _targetDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    print(widget.budgetDataController.value.toJson());
    _budgetType = widget.budgetDataController.value.type;
    if (_budgetType == BudgetType.monthly) {
      _money = (widget.budgetDataController.value as MonthlyBudgetData)
          .monthlyAmount;
    } else if (_budgetType == BudgetType.target) {
      _money =
          (widget.budgetDataController.value as TargetBudgetData).targetAmount;
      _targetDate = (widget.budgetDataController.value as TargetBudgetData)
          .targetDate
          .toLocal();
    }
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(() {
      fn();
      final data = budgetData();
      if (widget.onBudgetDataChanged != null) {
        widget.onBudgetDataChanged!(data);
      }
      widget.budgetDataController.value = data;
    });
  }

  BudgetData budgetData() {
    switch (_budgetType) {
      case BudgetType.envelope:
        return EnvelopeBudgetData();
      case BudgetType.monthly:
        return MonthlyBudgetData(_money);
      case BudgetType.target:
        return TargetBudgetData(
          targetAmount: _money,
          targetDate: _targetDate.toUtc(),
        );
    }
  }

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
        onSelectionChanged: (selection) {
          if (selection.isEmpty) return;
          setState(() {
            _budgetType = selection.first;
          });

          switch (selection.first) {
            case BudgetType.envelope:
              widget.budgetDataController.value = EnvelopeBudgetData();
              break;
            case BudgetType.monthly:
              widget.budgetDataController.value = MonthlyBudgetData(_money);
              break;
            case BudgetType.target:
              widget.budgetDataController.value = TargetBudgetData(
                  targetAmount: _money, targetDate: _targetDate.toUtc());
              break;
          }
        },
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
          MoneyFormField(
            initialValue: _money,
            decoration: const InputDecoration(labelText: "Monthly Budget"),
            style: const TextStyle(
                fontSize: 40,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 82, 79, 79),
                fontWeight: FontWeight.w800),
            autofocus: true,
            textAlign: TextAlign.center,
            allowNegative: true,
            onChanged: (value) {
              setState(() {
                _money = value;
              });
            },
          ),
        ],
      ),
    );
  }

  _buildTargetConfiguration() {
    final now = DateTime.now();
    final monthsLeft =
        (_targetDate.year - now.year) * 12 + _targetDate.month - now.month;

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text("You set a target amount for the category"),
          MoneyFormField(
            initialValue: _money,
            decoration: const InputDecoration(labelText: "Target Amount"),
            style: const TextStyle(
                fontSize: 40,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 82, 79, 79),
                fontWeight: FontWeight.w800),
            autofocus: true,
            textAlign: TextAlign.center,
            allowNegative: false,
            onChanged: (value) {
              setState(() {
                print("Value: $value");
                _money = value;
              });
            },
          ),
          Column(
            children: [
              TextFormField(
                initialValue: DateFormat.yMd().format(_targetDate),
                decoration: const InputDecoration(labelText: "Target Date"),
                readOnly: true,
                onTap: () => showDatePicker(
                  context: context,
                  initialDate: _targetDate,
                  lastDate: DateTime.now().add(const Duration(days: 365 * 50)),
                  firstDate: DateTime.now(),
                ).then((value) {
                  if (value == null) return;
                  setState(() {
                    _targetDate = value;
                  });
                }),
              ),
              Text(
                monthsLeft == 0
                    ? "Target reached this month"
                    : "Monthly Budget: ${numberFormatter.format((_money / monthsLeft).ceil() / 100.0)}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
