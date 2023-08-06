import 'package:flutter/material.dart';

import '../../core/utils/app_strings.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/about_screen.dart';
import '../../features/home/presentation/screens/developers_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/nav_bar_screen.dart';
import '../../features/home/presentation/screens/profile_screen.dart';
import '../../features/home/presentation/screens/project_settings_screen.dart';
import '../../features/home/presentation/screens/tasks_screen.dart';
import '../../features/inbox/presentation/screens/chat_screen.dart';
import '../../features/inbox/presentation/screens/inbox_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/loginRoute';
  static const String forgotPasswordRoute = '/forgotPasswordRoute';
  static const String registerRoute = '/registerRoute';
  static const String homeRoute = '/homeRoute';
  static const String tasksRoute = '/tasksRoute';
  static const String profileRoute = '/profileRoute';
  static const String navBarRoute = '/navBarRoute';
  static const String projectSettingsRoute = '/projectSettingsRoute';
  static const String inboxRoute = '/inboxRoute';
  static const String chatRoute = '/chatRoute';
  static const String onboadringRoute = '/onboadringRoute';
  static const String aboutRoute = '/aboutRoute';
  static const String developersRoute = '/developersRoute';
}

class AppRoutes {
  static Route onGenerateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.tasksRoute:
        return MaterialPageRoute(
          builder: (context) => const TasksScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.profileRoute:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.navBarRoute:
        return MaterialPageRoute(
          builder: (context) => const NavBarScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.projectSettingsRoute:
        return MaterialPageRoute(
          builder: (context) => const ProjectSettingsScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.inboxRoute:
        return MaterialPageRoute(
          builder: (context) => const InboxScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.chatRoute:
        return MaterialPageRoute(
          builder: (context) => const ChatScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.onboadringRoute:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.aboutRoute:
        return MaterialPageRoute(
          builder: (context) => const AboutScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      case Routes.developersRoute:
        return MaterialPageRoute(
          builder: (context) => const DevelopersScreen(),
          settings: RouteSettings(arguments: settings.arguments),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
