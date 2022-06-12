import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'initialBloc.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            const Divider(
              color: Colors.blueGrey,
              thickness: 0.01,
            ),
                ListTile(
                  leading: const Icon(Icons.lock_rounded),
                  title: Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    //Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                            new InitialChangePasswordBloc()));
                  },
                ),
            const Divider(
              color: Colors.blueGrey,
              thickness: 0.3,
            ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(
                    'Change Company',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    //Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                            new InitialCompanyNamesBloc()));
                  },
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 0.3,
                ),
          ]))
        ],
      ),
    );
  }
}
