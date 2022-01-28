import 'package:app/ui/view/home_view.dart';
import 'package:app/ui/view/login_view.dart';
import 'package:app/ui/view/profile_view.dart';
import 'package:app/ui/view/register_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginView.id:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RegisterView.id:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case HomeView.id:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case ProfileView.id:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No view defined for this route'),
            ),
          ),
        );
    }
  }
}
