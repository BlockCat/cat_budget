// Flutter page for adding an account
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddAccountFormResult {
  const AddAccountFormResult({
    required this.accountName,
    this.accountDescription,
    required this.balance,
  });

  final String accountName;
  final String? accountDescription;
  final int balance;
}

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Account'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(
          child: Column(
        children: [
          const Text("Add an unlinked account"),
          Container(
            padding: const EdgeInsets.all(10),
            child: AddAccountDetailForm(onSubmitted: (result) {
              context.pop(result);
            }),
          ),
          const Text("Or link to a bank account"),
          ListTile(
            leading: Image.network(
                "https://d21buns5ku92am.cloudfront.net/69197/images/369968-ING_Identifier_FC-8d1eb0-original-1605087880.png"),
            title: const Text("ING"),
            subtitle: const Text("ING Netherlands"),
            trailing: const Icon(Icons.link),
            onTap: () {
              context.go('/accounts/add/ing');
            },
          )
        ],
      )),
    );
  }
}

class AddAccountDetailForm extends StatefulWidget {
  const AddAccountDetailForm({Key? key, this.onSubmitted}) : super(key: key);

  final Function(AddAccountFormResult result)? onSubmitted;

  @override
  State<AddAccountDetailForm> createState() => _AddAccountDetailFormState();
}

class _AddAccountDetailFormState extends State<AddAccountDetailForm> {
  final _formKey = GlobalKey<FormState>();

  final accountNameController = TextEditingController();
  final accountDescriptionController = TextEditingController();
  final accountBalanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: accountNameController,
            decoration: const InputDecoration(
              hintText: 'Account Name',
              icon: Icon(Icons.account_balance),
            ),
          ),
          TextFormField(
            controller: accountDescriptionController,
            decoration: const InputDecoration(
              hintText: 'Account Description',
              icon: Icon(Icons.description),
            ),
          ),
          TextFormField(
            controller: accountBalanceController,
            decoration: const InputDecoration(
              hintText: 'Opening Balance',
              icon: Icon(Icons.attach_money),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an opening balance';
              }
              // check if value is a valid number
              final money = double.tryParse(value);

              if (money == null || money.isInfinite || money.isNaN) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise
                if (_formKey.currentState!.validate()) {
                  // Process data.
                  if (widget.onSubmitted != null) {
                    final int accountBalance =
                        ((double.tryParse(accountBalanceController.text) ?? 0) *
                                100)
                            .round();
                    widget.onSubmitted!(
                      AddAccountFormResult(
                        accountName: accountNameController.text,
                        accountDescription:
                            accountDescriptionController.text.isNotEmpty
                                ? accountDescriptionController.text
                                : null,
                        balance: accountBalance,
                      ),
                    );
                  }
                }
              },
              child: const Text('Add Account'),
            ),
          )
        ],
      ),
    );
  }
}
