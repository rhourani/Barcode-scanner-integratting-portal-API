import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ioi_barcode_scanner/bloc_login/bloc/authentication_bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/repository/user_repository.dart';

import 'bloc/login_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login | IOI Portal'),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,

          );
        },
        child: LoginForm(),
      ),
    );
  }
}