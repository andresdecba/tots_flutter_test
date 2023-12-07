import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tots_flutter_test/auth/presentation/screens/login_screen.dart';
import 'package:tots_flutter_test/clients/domain/entities/client.dart';
import 'package:tots_flutter_test/clients/presentation/screens/find_client_screen.dart';
import 'package:tots_flutter_test/clients/presentation/screens/get_client_screen.dart';
import 'package:tots_flutter_test/clients/presentation/screens/home_screen.dart';
import 'package:tots_flutter_test/clients/presentation/screens/create_edit_client_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRoutes {
  // Pages
  static const loginScreen = 'loginScreen';
  static const findClientScreen = 'findClientScreen';
  static const getClientScreen = 'getClientScreen';
  static const homeScreen = 'homeScreen';
  static const createUpdateScreen = 'createUpdateScreen';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/${AppRoutes.loginScreen}',
    navigatorKey: rootNavigatorKey,
    routes: [
      // routes
      GoRoute(
        path: '/${AppRoutes.loginScreen}',
        name: AppRoutes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/${AppRoutes.getClientScreen}',
        name: AppRoutes.getClientScreen,
        builder: (context, state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return GetClientScreen(
            clientId: args['clientId'],
          );
        },
      ),
      GoRoute(
          path: '/${AppRoutes.findClientScreen}',
          name: AppRoutes.findClientScreen,
          builder: (context, state) {
            Map<String, dynamic> args = state.extra as Map<String, dynamic>;
            return FindClientScreen(
              client: args['client'],
            );
          }),

      GoRoute(
        path: '/${AppRoutes.homeScreen}',
        name: AppRoutes.homeScreen,
        builder: (context, state) => HomeScreen(
          key: UniqueKey(),
        ),
      ),
      GoRoute(
        path: '/${AppRoutes.createUpdateScreen}',
        name: AppRoutes.createUpdateScreen,
        builder: (context, state) {
          // edit client
          if (state.extra != null) {
            Map<String, dynamic> args = state.extra as Map<String, Client>;
            return CreateEditClientScreen(
              client: args['client'],
            );
          }
          // create new client
          return const CreateEditClientScreen();
        },
      ),
    ],
  );
});
