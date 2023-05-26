import 'package:cat_budget/pages/accounts/account.dart';
import 'package:cat_budget/pages/dashboard/dashboard.dart';
import 'package:cat_budget/pages/transactions/transaction_page.dart';
import 'package:cat_budget/services/budget/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter _router =
    GoRouter(navigatorKey: _rootNavigatorKey, initialLocation: '/', routes: [
  ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Cat Budget'),
            ),
            body: Center(child: child),
            bottomNavigationBar: const MyBottomNavigationBar());
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) =>
                const DashboardPage(key: Key('dashboard.page'))),
        GoRoute(
            path: '/accounts',
            pageBuilder: (context, state) => const NoTransitionPage(
                child: AccountPage(key: Key('accounts.page')))),
        GoRoute(
            path: '/transactions',
            pageBuilder: (context, state) => const NoTransitionPage(
                child: TransactionPage(key: Key('transactions.page')))),
      ]),
]);

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
    return MaterialApp.router(
      title: 'Cat Budget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
