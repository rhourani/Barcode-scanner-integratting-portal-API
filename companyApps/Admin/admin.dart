import 'package:flutter/material.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/mainMenu.dart';

class ADMIN extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("IOI Portal ADMIN"),
        ),
        drawer: MainDrawer(),
        body: Center(
          child: Text(
            'Hello "User ADMIN"',
            style: TextStyle(color: Colors.red),
          ),
        ),
    );
  }
}
