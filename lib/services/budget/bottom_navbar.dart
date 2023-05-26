import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard), label: 'Dashboard'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_balance), label: 'Accounts'),
        BottomNavigationBarItem(
            icon: Icon(Icons.attach_money), label: 'Transactions'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green[800],
      onTap: (value) {
        if (value == 0) {
          context.go('/');
        } else if (value == 1) {
          context.go('/accounts');
        } else if (value == 2) {
          context.go('/transactions');
        }
        setState(() {
          _selectedIndex = value;
        });
      },
    );
  }
}
