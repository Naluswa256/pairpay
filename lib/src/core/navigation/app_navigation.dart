// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizzle_starter/src/core/network_health_check/network_inherited_widget.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/specialization_model.dart';import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Appointment/appointments.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/all_lawyers.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/all_specialization_screen.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/dashboard_screen.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/lawyer_detail_screen.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/request_appointement.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Notification/notifications.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Profile/profile.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/sub_profile.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/home_page.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/events/authentication_event.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/choose_login.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/forgot_password.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/user_login_screen.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/user_signup_screen.dart';
import 'package:sizzle_starter/src/feature/onboarding/screens/verify_email_screen.dart';
import 'package:sizzle_starter/src/splash_screen.dart';

class AppNavigation {
  AppNavigation._();

  static String initial = "/";

  // Private navigators
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorSettings =
      GlobalKey<NavigatorState>(debugLabel: 'shellSettings');
  static final _shellNavigatorAppointments =
      GlobalKey<NavigatorState>(debugLabel: 'shellAppointments');
  static final _shellNavigatorNotifications =
      GlobalKey<NavigatorState>(debugLabel: 'shellNotifications');
  // GoRouter configuration
  static final GoRouter router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/chooseLogin',
        builder: (context, state) => const ChooseLogin(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => UserLoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: '/verifyEmai',
        builder: (context, state) => VerifyEmailScreen(),
      ),
      GoRoute(
        path: '/forgotPassword',
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      
      /// MainWrapper
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => NetworkAwareWidget(
          child: MainWrapper(
            navigationShell: navigationShell,
          ),
        ),
        branches: <StatefulShellBranch>[
          /// Brach Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: "/home",
                name: "Home",
                builder: (BuildContext context, GoRouterState state) => 
                    BlocProvider(create: (BuildContext context)=>DependenciesScope.of(context).homeBloc,
                    child: const HomeScreen(),),
                routes: [
                  GoRoute(
                    path: 'allLawyers',
                    name: 'allLawyers',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: AllLawyerScreen(specialization: state.extra! as Specialization,),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'lawyerDetail',
                    name: 'lawyerDetail',
                    builder: (context, state) {
                      final user = state.extra! as User;
                      return LawyerDetailScreen(lawyerModel: user);
                    },
                  ),
                  GoRoute(
                    path: 'bookingScreen',
                    name: 'bookingScreen',
                    builder: (context, state) {
                      return BookingScreen();
                    },
                  ),
                  GoRoute(
                    path: 'allSpecializations',
                    name: 'allSpecializations',
                    builder: (context, state) {
                      final specializationResponse = state.extra! as SpecializationResponse;
                      return AllSpecializationsScreen(specializationResponse:specializationResponse);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAppointments,
            routes: <RouteBase>[
              GoRoute(
                path: '/appointments',
                name: 'Appointments',
                builder: (context, state) => AppointementsPage(
                  key: state.pageKey,
                ),
              ),
              // Add more routes specific to the Appointments tab as needed
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorNotifications,
            routes: <RouteBase>[
              GoRoute(
                path: '/notifications',
                name: 'Notifications',
                builder: (context, state) => Notifications(
                  key: state.pageKey,
                ),
              ),
              // Add more routes specific to the Notifications tab as needed
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettings,
            routes: <RouteBase>[
              GoRoute(
                path: "/settings",
                name: "Settings",
                builder: (BuildContext context, GoRouterState state) =>
                    const SettingsView(),
                routes: [
                  GoRoute(
                    path: "subSetting",
                    name: "subSetting",
                    pageBuilder: (context, state) {
                      return CustomTransitionPage<void>(
                        key: state.pageKey,
                        child: const SubSettingsView(),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) =>
                            FadeTransition(opacity: animation, child: child),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
