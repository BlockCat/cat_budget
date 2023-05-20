import 'package:cat_budget/pages/home.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // HydratedBloc.storage =
  //     await HydratedStorage.build(storageDirectory: 'hydrated_bloc');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
