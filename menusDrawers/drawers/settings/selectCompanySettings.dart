/// Flutter code sample for Radio

// Here is an example of Radio widgets wrapped in ListTiles, which is similar
// to what you could get with the RadioListTile widget.
//
// The currently selected character is passed into `groupValue`, which is
// maintained by the example's `State`. In this case, the first `Radio`
// will start off selected because `_character` is initialized to
// `SingingCharacter.lafayette`.
//
// If the second radio button is pressed, the example's state is updated
// with `setState`, updating `_character` to `SingingCharacter.jefferson`.
// This causes the buttons to rebuild with the updated `groupValue`, and
// therefore the selection of the second button.
//
// Requires one of its ancestors to be a [Material] widget.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioi_barcode_scanner/menusDrawers/drawers/drawers_blocs/drawers_bloc.dart';

enum SingingCharacter { lafayette, jefferson }
int setCompanyID = 1;

/// This is the stateful widget that the main application instantiates.
class SetCompanyToUse extends StatefulWidget {
  SetCompanyToUse({Key key}) : super(key: key);

  @override
  _SetCompanyToUseState createState() => _SetCompanyToUseState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _SetCompanyToUseState extends State<SetCompanyToUse> {
  SingingCharacter _character = SingingCharacter.lafayette;
  static const String _title = 'Set a company';
  //int _value = 1;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppsBloc>(context).add(FetchCompaniesNamesFromDB());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppsBloc, AppsState>(builder: (context, state) {
      if (state is CompanyInitial) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is CompanyFailure) {
        return Center(
          child: Text("Failed to retrieve Your Company!"),
        );
      } else if (state is CompaniesNamesSuccess) {
        if (state.companiesNames.isEmpty) {
          return Center(
            child: Text('You are in NO Company currently!'),
          );
        }
        return Column(
          children: <Widget>[
            for (int i = 0; i <state.companiesNames.length; i++)
              ListTile(
                title: Text(
                  '${state.companiesNames[i]}',
                  style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,
                      fontSize: 17,
                  ),
                ),
                leading: Radio(
                  value: i+1,
                  groupValue: setCompanyID,
                  onChanged:_handleRadioValueChange,
                ),
              ),
          ],
        );
      } else {
        return Container();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      setCompanyID = value;
    });
  }
}
