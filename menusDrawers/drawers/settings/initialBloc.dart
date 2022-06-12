import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/repository/user_repository.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/drawers_blocs/drawers_bloc.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/settings/selectCompanySettings.dart';

import 'bloc_settings/settings_bloc.dart';
import 'changePassword.dart';


class InitialCompanyNamesBloc extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  InitialCompanyNamesBloc({Key key}) : super(key: key);
  final appTitle = 'Set A Company';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(appTitle),
          ),
          body: BlocProvider(
            create: (context) {
              return AppsBloc(
                userRepository: userRepository,
              );
            },
            child: SetCompanyToUse(),
          )
    );
  }
}

/*
* For Change password settings
* */
class InitialChangePasswordBloc extends StatelessWidget {
  final UserRepository userRepository= UserRepository();

  InitialChangePasswordBloc({Key key}) : super(key: key);
  final appTitle = 'Change Password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: BlocProvider(
        create: (context) {
          return SettingsBloc(
            userRepository: userRepository,
          );
        },
        child: ChangePasswordForm(),
      ),
    );
  }
}
