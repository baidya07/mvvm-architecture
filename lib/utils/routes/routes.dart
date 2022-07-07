import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_architecture/utils/routes/routes_name.dart';
import 'package:mvvm_architecture/view/home_screen.dart';
import 'package:mvvm_architecture/view/login_view.dart';
import 'package:mvvm_architecture/view/signup_view.dart';
import 'package:mvvm_architecture/view/splash_view.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.home:
        return MaterialPageRoute(
            builder:(BuildContext context) => const HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(
            builder:(BuildContext context) => const LoginView());

      case RoutesName.signup:
        return MaterialPageRoute(
            builder:(BuildContext context) => const SignupView());

      case RoutesName.splash:
        return MaterialPageRoute(
            builder:(BuildContext context) => const SplashView());

      default:
        return MaterialPageRoute(
            builder: (_){
              return Scaffold(
                body: Center(
                  child: Text('No Routes defined'),
                ),
              );
            } );
    }
  }
}