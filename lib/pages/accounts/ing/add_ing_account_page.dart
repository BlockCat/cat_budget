// Flutter page for adding an account
import 'package:flutter/material.dart';

class AddIngAccountPage extends StatelessWidget {
  const AddIngAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add ING Account'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 255, 115, 0),
      ),
      body: const Center(
          child: Column(
        children: [
          Text("Do something with ING"),
        ],
      )),
    );
  }
}
