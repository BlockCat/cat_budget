// Flutter page for adding an account
import 'package:flutter/material.dart';

class AddCustomAccountPage extends StatelessWidget {
  const AddCustomAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Account'),
      ),
      body: const Center(
        child: Text('Add Account'),
      ),
    );
  }
}

class AddAccountDetailForm extends StatefulWidget {
  const AddAccountDetailForm({Key? key}) : super(key: key);

  @override
  State<AddAccountDetailForm> createState() => _AddAccountDetailFormState();
}

class _AddAccountDetailFormState extends State<AddAccountDetailForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text('Add Account'),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Account Name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Account Description',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Opening Balance',
            ),
          ),
        ],
      ),
    );
  }
}
