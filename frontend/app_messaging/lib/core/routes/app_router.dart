import 'package:app_messaging/presentation/pages/auth/register_page.dart';
import 'package:app_messaging/presentation/pages/contact/contact_page.dart';
import 'package:app_messaging/presentation/pages/message/message_page.dart';
import 'package:app_messaging/presentation/pages/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/pages/auth/login_page.dart';
import 'routes_names.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splashScreen,
    routes: [
      //routes splash
      GoRoute(
        name: RouteNames.splashScreen,
        path: RoutePaths.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),

      //routes login
      GoRoute(
        name: RouteNames.login,
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),

      //routes register
      GoRoute(
        name: RouteNames.register,
        path: RoutePaths.register,
        builder: (context, state) => const RegisterPage(),
      ),

      //routes message
      GoRoute(
        name: RouteNames.message,
        path: RoutePaths.message,
        builder: (context, state) => const MessagePage(),
      ),

      //routes contact
      GoRoute(
        name: RouteNames.contact,
        path: RoutePaths.contact,
        builder: (context, state) => const ContactPage(),
      ),
    ],
  );
}
