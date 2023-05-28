import 'package:cat_budget/pages/accounts/account_page.dart';
import 'package:cat_budget/pages/accounts/add_account_page.dart';
import 'package:cat_budget/pages/accounts/ing/add_ing_account_page.dart';
import 'package:cat_budget/pages/dashboard/dashboard.dart';
import 'package:cat_budget/pages/dashboard/edit_categories/edit_category_page.dart';
import 'package:cat_budget/pages/transactions/add_transaction_page.dart';
import 'package:cat_budget/pages/transactions/transaction_page.dart';
import 'package:cat_budget/services/budget/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter router =
    GoRouter(navigatorKey: _rootNavigatorKey, initialLocation: '/', routes: [
  ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Scaffold(
          body: Center(child: child),
          bottomNavigationBar: const MyBottomNavigationBar(),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardPage(
            key: Key('dashboard.page'),
          ),
        ),
        GoRoute(
          path: '/categories/edit',
          pageBuilder: (context, state) => NoTransitionPage(
            child: EditCategoryPage(),
          ),
        ),
        GoRoute(
          path: '/accounts',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AccountPage(
              key: Key('accounts.page'),
            ),
          ),
          routes: [
            GoRoute(
              path: 'details/:id',
              builder: (context, state) => Scaffold(
                appBar: AppBar(
                  title: const Text('Account Details'),
                ),
                body: Placeholder(),
              ),
            ),
            GoRoute(
              path: 'edit/:id',
              builder: (context, state) => Scaffold(
                appBar: AppBar(
                  title: const Text('Edit account'),
                ),
                body: Placeholder(),
              ),
            ),
            GoRoute(
              path: 'add',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AddAccountPage(
                  key: Key('add-unlinked.page'),
                ),
              ),
              routes: [
                GoRoute(
                    path: 'ing',
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: AddIngAccountPage()))
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/transactions',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: TransactionPage(
              key: Key('transactions.page'),
            ),
          ),
          routes: [
            GoRoute(
              path: 'add',
              builder: (context, state) => Scaffold(
                appBar: AppBar(
                  title: const Text('Add transaction'),
                ),
                body: AddTransactionPage(),
              ),
            ),
            GoRoute(
              path: 'edit/:id',
              builder: (context, state) => Scaffold(
                appBar: AppBar(
                  title: const Text('Edit transaction'),
                ),
                body: Placeholder(),
              ),
            ),
          ],
        ),
      ]),
]);
