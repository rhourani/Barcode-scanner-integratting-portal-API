// The HR Sub Drawer
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/dao/user_dao.dart';
import 'package:ioi_barcode_scanner/companyApps/Foodics/Services/barcodeScanner.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/drawers_blocs/drawers_bloc.dart';

import '../../underConstruction.dart';


class HRSubDrawer extends StatefulWidget {
  final VoidCallback goBack;

  HRSubDrawer({this.goBack});
  _HRSubDrawerState createState() => _HRSubDrawerState();

}

class _HRSubDrawerState extends State<HRSubDrawer> {
  final userDao = UserDao();
  Future _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = getPermissionsAsync();
    BlocProvider.of<AppsBloc>(context).add(FetchServicesFromDB());
  }

  getPermissionsAsync() async {
    final userPermissionsData = await userDao.getPermissions();
    return userPermissionsData;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppsBloc, AppsState>(
      builder: (context, state) {
        if (state is ServicesInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ServicesFailure) {
          return Center(
            child: Text("Failed to retrieve Your Services!"),
          );
        } else if (state is ServicesSuccess) {
          if (state.services.isEmpty) {
            return Center(
              child: Text('You are in NO Services!'),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                    _createHeader(_userFuture),
                    ListTile(
                      leading: const Icon(Icons.arrow_back_ios),
                      title: Text(
                        'Apps Menu',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: widget.goBack,
                    ),
                    const Divider(
                      color: Colors.blueGrey,
                      thickness: 0.1,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.supervised_user_circle_sharp,
                        size: 50,
                      ),
                      title: Text(
                        'HR',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      color: Colors.blueGrey,
                      thickness: 0.2,
                    ),
                    if (state.services.contains("ioihr.full"))
                      _createItem(
                          icon: Icons.supervised_user_circle,
                          text: 'Full',
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new Scanner()));
                          }),
                    if (state.services.contains("ioihr.view"))
                      _createItem(
                          icon: Icons.supervised_user_circle,
                          text: 'View',
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new UnderConstruction()));
                          }),
                    if (state.services.contains("ioihr.delete"))
                      _createItem(
                          icon: Icons.supervised_user_circle,
                          text: 'Delete',
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                    new UnderConstruction()));
                          }),
                  ]))
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Widget _createHeader(Future obj) {
  Map<dynamic, dynamic> userPermissionsList = {};

  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/drawer_header_background.png'),
        )),
    child: Stack(children: <Widget>[
      Positioned(
        bottom: 15.0,
        left: 16.0,
        child: FutureBuilder(
          future: obj,
          builder: (context, userData) {
            switch (userData.connectionState) {
              case ConnectionState.none:
                return Container();
              case ConnectionState.waiting:
                return Container();
              case ConnectionState.active:
              case ConnectionState.done:
                if (!userPermissionsList.containsKey('userName')) {
                  userPermissionsList =
                  Map<dynamic, dynamic>.from(userData.data);
                }
                return Column(
                  children: <Widget>[
                    Text('Welcome, ${userPermissionsList['userName']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                );
            }
            return Container();
          },
        ),
      ),
    ]),
  );
}

Widget _createItem({IconData icon, String text, GestureTapCallback onTap}) {
  // TODO serach for user permisiion from the db depending on the coming
  // TODO name then put it in the if down --- test vcs
  if (1 == 1) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 31.0),
            child: Text(text,
                style: TextStyle(
                  fontSize: 17.0,
                )),
          ),
        ],
      ),
      onTap: onTap,
    );
  } else {
    return SizedBox.shrink();
  }
}
