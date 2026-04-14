import 'package:flutter/material.dart';
import 'package:flutter_eapps/modules/attendance/attendance_history_screen.dart';
import 'package:flutter_eapps/modules/attendance/attendance_page.dart';
import 'package:flutter_eapps/modules/auth/login_screen.dart';
import 'package:flutter_eapps/modules/dashboard/dashboard_page.dart';
import 'package:flutter_eapps/modules/hazard/hazard_page.dart';
import 'package:flutter_eapps/modules/home/presentation/home_screen.dart';
import 'package:flutter_eapps/modules/notification/notification_page.dart';
import 'package:flutter_eapps/modules/profile/presentation/profile_page.dart';
import 'package:flutter_eapps/modules/sleep_duration/sleep_duration_page.dart';
import 'package:flutter_eapps/modules/auth/auth_notifier.dart';
import 'package:flutter_eapps/modules/auth/auth_state.dart';
import 'package:flutter_eapps/modules/splash/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: RouterRefreshNotifier(ref),
    redirect: (context, state) {
      final authAsync = ref.read(authNotifierProvider);
      final isLoading = authAsync.isLoading;
      final authState = authAsync.valueOrNull;
      final isAuthenticated = authState?.status == AuthStatus.authenticated;
      final isOnLogin = state.matchedLocation == '/login';
      final isOnSplash = state.matchedLocation == '/';

      if (isLoading || authState == null) return '/';

      if (isOnSplash) {
        return isAuthenticated ? '/home' : '/login';
      }

      if (!isAuthenticated && !isOnLogin) return '/login';
      if (isAuthenticated && isOnLogin) return '/home';

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/notification',
        name: 'notification',
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: '/attendance',
        name: 'attendance',
        builder: (context, state) => const AttendancePage(),
      ),
      GoRoute(
        path: '/absence-history',
        name: 'absence-history',
        builder: (context, state) => const AttendanceHistoryScreen(),
      ),
      GoRoute(
        path: '/sleep-duration',
        name: 'sleep-duration',
        builder: (context, state) => const SleepDurationPage(),
      ),
      GoRoute(
        path: '/hazard',
        name: 'hazard',
        builder: (context, state) => const HazardPage(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Route not found: ${state.uri}'))),
  );
});

class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(Ref ref) {
    ref.listen(authNotifierProvider, (_, __) => notifyListeners());
  }
}
