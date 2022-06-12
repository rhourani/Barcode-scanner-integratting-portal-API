import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ioi_barcode_scanner/bloc_login/repository/user_repository.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/drawers_blocs/initialBloc.dart';

class HomePage extends StatelessWidget {
  final UserRepository userRepository;

  HomePage({Key key, @required this.userRepository}) : super(key: key);
  final appTitle = 'IOI Portal';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(appTitle),
            backgroundColor: Colors.pink,
          ),
          body: Container(
            child: GridView.count(
              crossAxisCount: 3,
            children: List.generate(16, (index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.addchart_outlined, size: 70),
                        ),
                      ],
                    ),
                  )

                ],
              );
            }),),
          ),
          drawer: MiddleDrawerForBloc()),
    );
  }
}