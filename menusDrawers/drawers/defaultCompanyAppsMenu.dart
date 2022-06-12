import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/bloc/authentication_bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/dao/user_dao.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/settings/settings.dart';

import 'drawers_blocs/drawers_bloc.dart';


class DefaultCompanyAppsMenu extends StatefulWidget {
  final VoidCallback goToDefaultCom;

  final VoidCallback adminMenu;
  final VoidCallback administrationMenu;
  final VoidCallback foodicsMenu;
  final VoidCallback hrMenu;
  final VoidCallback propertyMenu;

  DefaultCompanyAppsMenu(
      {this.goToDefaultCom,
      this.hrMenu,
      this.adminMenu,
      this.administrationMenu,
      this.foodicsMenu,
      this.propertyMenu});

  @override
  _DefaultCompanyAppsMenuState createState() => _DefaultCompanyAppsMenuState();
}

class _DefaultCompanyAppsMenuState extends State<DefaultCompanyAppsMenu> {
  final userDao = UserDao();
  Future _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = getPermissionsAsync();
    BlocProvider.of<AppsBloc>(context).add(FetchAppsFromLocalDB());
  }

  getPermissionsAsync() async {
    final userPermissonsData = await userDao.getPermissions();
    return userPermissonsData;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppsBloc, AppsState>(
      builder: (context, state) {
        if (state is AppsInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AppsFailure) {
          return Center(
            child: Text("Failed to retrieve Your Apps!"),
          );
        }
        else if (state is AppsUnavailableForUser) {
          return CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                    _createHeader(_userFuture),
                    ListTile(
                      leading: const Icon(
                        Icons.add_business_outlined,
                        size: 39,
                      ),
                      title: Text(
                        'My Apps',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      color: Colors.blueGrey,
                      thickness: 0.1,
                    ),
                    ListTile(
                      leading: const Icon(Icons.warning_amber_outlined),
                      title: Text(
                        'You are in NO Apps!, Ask Admin to add you then log out and login again please!',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () => {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LoggedOut())
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.exit_to_app_rounded),
                      title: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () => {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LoggedOut())
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.anchor_rounded),
                      title: Text(
                        'About',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ]))
            ],
          );
        }
        else if (state is AppsSuccess) {
          if (state.apps.isEmpty) {
            return Center(
              child: Text('You are in NO Apps!'),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                _createHeader(_userFuture),
                ListTile(
                  leading: const Icon(
                    Icons.add_business_outlined,
                    size: 39,
                  ),
                  title: Text(
                    'My Apps',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 0.1,
                ),
                if (state.apps.contains("Administration"))
                  _createAppItem(
                      icon: Icons.admin_panel_settings_outlined,
                      text: 'Administration',
                      onTap: widget.administrationMenu),
                if (state.apps.contains("Admin"))
                  _createAppItem(
                      icon: Icons.admin_panel_settings,
                      text: 'Admin',
                      onTap: widget.adminMenu),
                if (state.apps.contains("Property"))
                  _createAppItem(
                      icon: Icons.place_outlined,
                      text: 'Property',
                      onTap: widget.propertyMenu),
                if (state.apps.contains("Foodics"))
                  _createAppItem(
                      icon: Icons.restaurant,
                      text: 'Foodics',
                      onTap: widget.foodicsMenu),
                if (state.apps.contains("Hr"))
                  _createAppItem(
                      icon: Icons.supervised_user_circle,
                      text: 'HR',
                      onTap: widget.hrMenu),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 0.1,
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                new Settings()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app_rounded),
                  title: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () => {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut())
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.anchor_rounded),
                  title: Text(
                    'About',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
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

Widget _createAppItem({IconData icon, String text, GestureTapCallback onTap}) {
  // TODO serach for user permisiion from the db depending on the coming
  // TODO name then put it in the if down
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
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  } else {
    return SizedBox.shrink();
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
