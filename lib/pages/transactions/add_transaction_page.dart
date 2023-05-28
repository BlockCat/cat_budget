import 'package:flutter/material.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [_AddTransactionForm()],
    );
  }
}

class _AddTransactionForm extends StatefulWidget {
  const _AddTransactionForm({Key? key}) : super(key: key);

  @override
  State<_AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<_AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Other Account',
              icon: Icon(Icons.account_balance),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Amount in cents',
              icon: Icon(Icons.description),
            ),
          ),
        ],
      ),
    );
  }
}
