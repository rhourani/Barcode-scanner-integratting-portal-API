import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/repository/user_repository.dart';

import '../defaultCompanyAppsMenu.dart';
import '../mainMenu.dart';
import 'drawers_bloc.dart';


class MiddleDrawerForApps extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  MiddleDrawerForApps({Key key})
      : super(key: key);
  final appTitle = 'IOI Portal';


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AppsBloc(
          userRepository: userRepository,
        );
      },
      child: DefaultCompanyAppsMenu(),
    );
  }
}



class MiddleDrawerForBloc extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  MiddleDrawerForBloc({Key key})
      : super(key: key);
  final appTitle = 'IOI Portal';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AppsBloc(
          userRepository: userRepository,
        );
      },
      child: MainDrawer(),
    );
  }
}



