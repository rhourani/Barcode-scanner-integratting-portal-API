import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'bloc_settings/settings_bloc.dart';

class ChangePasswordForm extends StatefulWidget {
  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onChangePassButtonPressed() {
      BlocProvider.of<SettingsBloc>(context).add(ChangePasswordButtonPressed(
        oldPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
      ));
    }

    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Colors.red,
          ));
        }
        if (state is ChangePasswordSuccess) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Password Changed Successfully!'),
            backgroundColor: Colors.green,
          ));
        }
      },
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Container(
            child: Form(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Old Password',
                          icon: Icon(Icons.security)),
                      controller: _oldPasswordController,
                      obscureText: true,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'New Password',
                          icon: Icon(Icons.security)),
                      controller: _newPasswordController,
                      obscureText: true,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.width * 0.22,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: RaisedButton(
                          onPressed: state is! SettingsLoading
                              ? _onChangePassButtonPressed
                              : null,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff0000),
                                    Color(0xff64B6FF),
                                    Color(0x4b0082),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Change Password",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: state is SettingsLoading
                          ? CircularProgressIndicator()
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
