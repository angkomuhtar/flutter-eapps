import 'package:flutter/material.dart';
import 'package:flutter_eapps/modules/attendance/attendance_history_screen.dart';
import 'package:flutter_eapps/modules/attendance/attendance_page.dart';
import 'package:flutter_eapps/modules/auth/login_screen.dart';
import 'package:flutter_eapps/modules/dashboard/dashboard_page.dart';
import 'package:flutter_eapps/modules/hazard/hazard_details_screen.dart';
import 'package:flutter_eapps/modules/hazard/hazard_page.dart';
import 'package:flutter_eapps/modules/hazard_action/hazard_action_details_screen.dart';
import 'package:flutter_eapps/modules/hazard_action/hazard_action_page.dart';
import 'package:flutter_eapps/modules/home/presentation/home_screen.dart';
import 'package:flutter_eapps/modules/inspection/inspection_details_screen.dart';
import 'package:flutter_eapps/modules/inspection/inspection_form_screen.dart';
import 'package:flutter_eapps/modules/inspection/inspection_page.dart';
import 'package:flutter_eapps/modules/leave/leave_details_screen.dart';
import 'package:flutter_eapps/modules/leave/leave_page.dart';
import 'package:flutter_eapps/modules/notification/notification_page.dart';
import 'package:flutter_eapps/modules/profile/presentation/about_us_page.dart';
import 'package:flutter_eapps/modules/profile/presentation/faq_page.dart';
import 'package:flutter_eapps/modules/profile/presentation/privacy_policy_page.dart';
import 'package:flutter_eapps/modules/profile/presentation/profile_page.dart';
import 'package:flutter_eapps/modules/profile/presentation/terms_condition_page.dart';
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
      GoRoute(
        path: '/hazard/details/:id',
        name: 'hazard-details',
        builder: (context, state) =>
            HazardDetailsScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/hazard-action',
        name: 'hazard-action',
        builder: (context, state) => const HazardActionPage(),
      ),
      GoRoute(
        path: '/hazard-action/details/:id',
        name: 'hazard-action-details',
        builder: (context, state) =>
            HazardActionDetailsScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/inspection',
        name: 'inspection',
        builder: (context, state) => const InspectionPage(),
      ),
      GoRoute(
        path: '/inspection/:slug/form',
        name: 'inspection-form',
        builder: (context, state) =>
            InspectionFormScreen(slug: state.pathParameters['slug']!),
      ),
      GoRoute(
        path: '/inspection/:id/details',
        name: 'inspection-details',
        builder: (context, state) =>
            InspectionDetailsScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/leave',
        name: 'leave',
        builder: (context, state) => const LeavePage(),
      ),
      GoRoute(
        path: '/leave/details/:id',
        name: 'leave-details',
        builder: (context, state) =>
            LeaveDetailsScreen(id: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/terms-condition',
        name: 'terms-condition',
        builder: (context, state) => const TermsConditionPage(),
      ),
      GoRoute(
        path: '/privacy-policy',
        name: 'privacy-policy',
        builder: (context, state) => const PrivacyPolicyPage(),
      ),
      GoRoute(
        path: '/about-us',
        name: 'about-us',
        builder: (context, state) => const AboutUsPage(),
      ),
      GoRoute(
        path: '/faq',
        name: 'faq',
        builder: (context, state) => const FaqPage(),
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
