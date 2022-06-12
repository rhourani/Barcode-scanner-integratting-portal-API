import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_login/bloc/authentication_bloc.dart';
import 'bloc_login/common/loading_indicator.dart';
import 'bloc_login/home/homePage.dart';
import 'bloc_login/login/login_page.dart';
import 'bloc_login/repository/user_repository.dart';
import 'bloc_login/splash/splash_page.dart';

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        primarySwatch: Colors.lightBlue,
        brightness: Brightness.dark,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository,);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}