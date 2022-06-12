import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ioi_barcode_scanner/bloc_login/repository/user_repository.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/sub_menus/administration.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/sub_menus/foodics.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/sub_menus/property.dart';
import 'sub_menus/hr.dart';
import 'sub_menus/admin.dart';
import 'defaultCompanyAppsMenu.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  int myIndex;
  PageController _controller;
  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  //The Logic where you change the pages
  _onChangePage(int index) {
    //_controller.jumpToPage(index);

    if (index != 0)
      setState(() => myIndex =
          index); //change myIndex if you're Selecting between Settings and Explore
    _controller.animateToPage(index.clamp(0, 1),
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: PageView.builder(
      controller: _controller,
      physics:
          NeverScrollableScrollPhysics(), //so the user can not move between pages
      itemCount: 2,
      itemBuilder: (context, index) {
        // Original Drawer
        if (index == 0)
          return DefaultCompanyAppsMenu(
            adminMenu: () => _onChangePage(1),
            administrationMenu: () => _onChangePage(2),
            foodicsMenu: () => _onChangePage(3),
            hrMenu: () => _onChangePage(4),
            propertyMenu: () => _onChangePage(5),
          );
        //Second Drawer form the PageView
        switch (myIndex) {
          case 1:
            return AdminSubDrawer(goBack: () => _onChangePage(0));
          case 2:
            return AdministrationSubDrawer(goBack: () => _onChangePage(0));
          case 3:
            return FoodicsSubDrawer(goBack: () => _onChangePage(0));
          case 4:
            return HRSubDrawer(goBack: () => _onChangePage(0));
          case 5:
            return PropertySubDrawer(goBack: () => _onChangePage(0));
          default:
            return DefaultCompanyAppsMenu(
              goToDefaultCom: () => _onChangePage(0),
            );
        }
      },
    ));
  }
}

class MyInnerDrawer extends StatelessWidget {
  final String name;
  final PageController _controller;

  MyInnerDrawer(this._controller, this.name);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(name),
        trailing: const Icon(Icons.arrow_back_ios),
        onTap: () => _controller.animateToPage(0,
            duration: const Duration(milliseconds: 500), curve: Curves.linear),
      )
    ]);
  }
}
