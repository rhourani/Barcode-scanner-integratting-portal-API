import 'package:flutter/material.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/mainMenu.dart';

class HR extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("IOI Portal HR"),
        ),
        drawer: MainDrawer(),
        body: Center(
          child: Text(
            'Hello "User HR"',
            style: TextStyle(color: Colors.red),
          ),
        ),
    );
  }
}
