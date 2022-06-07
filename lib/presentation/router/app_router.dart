import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/constants/strings.dart';
import 'package:magdsoft_flutter_structure/data/models/login_model.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/user_profile.dart';
import 'package:magdsoft_flutter_structure/presentation/screens/user/register_screen.dart';

import '../screens/user/login_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case userProfile:
        final arguments = settings.arguments as Map;

        final LoginModel userInfo = arguments['userInfo'];
        final Account userData = userInfo.account![0];

        return MaterialPageRoute(
            builder: (_) => UserProfile(
                  accountInfo: userData,
                ));
      default:
        return null;
    }
  }
}
