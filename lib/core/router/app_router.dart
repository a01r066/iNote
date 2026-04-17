import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/products/presentation/pages/products_page.dart';
import '../../features/orders/presentation/pages/orders_page.dart';
import '../../features/customers/presentation/pages/customers_page.dart';
import '../utils/extensions/log_extension.dart';
import 'route_names.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = authState.valueOrNull != null;
      final isAuthRoute = state.matchedLocation == RouteNames.login ||
          state.matchedLocation == RouteNames.splash;

      if (!isAuthenticated && !isAuthRoute) {
        return RouteNames.login;
      }
      if (isAuthenticated && state.matchedLocation == RouteNames.login) {
        return RouteNames.dashboard;
      }
      return null;
    },
    routes: [
      // Splash
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),

      // Auth
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),

      // Main Shell with Bottom Navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => _MainShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.dashboard,
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: RouteNames.products,
            builder: (context, state) => const ProductsPage(),
          ),
          GoRoute(
            path: RouteNames.orders,
            builder: (context, state) => const OrdersPage(),
          ),
          GoRoute(
            path: RouteNames.customers,
            builder: (context, state) => const CustomersPage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.uri}'),
            TextButton(
              onPressed: () => context.go(RouteNames.dashboard),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}

class _MainShell extends StatefulWidget {
  const _MainShell({required this.child});

  final Widget child;

  @override
  State<_MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<_MainShell> {
  int _selectedIndex = 0;

  static const _routes = [
    RouteNames.dashboard,
    RouteNames.products,
    RouteNames.orders,
    RouteNames.customers,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          context.go(_routes[index]);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outlined),
            selectedIcon: Icon(Icons.people),
            label: 'Customers',
          ),
        ],
      ),
    );
  }
}
