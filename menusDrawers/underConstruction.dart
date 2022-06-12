import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/bloc/authentication_bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/dao/user_dao.dart';

import 'api_connections/api_user_permissions.dart';

class UnderConstruction extends StatefulWidget {
  UnderConstruction({Key key}) : super(key: key);

  @override
  _underConstruction createState() => _underConstruction();
}

class _underConstruction extends State<UnderConstruction> {
  final userDao = UserDao();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Under Construction'),
      ),
      body: Container(
        child: Center(
          child: Text("Oops! This page is under construction :("),
        ),
      ),
    );
  }
}
