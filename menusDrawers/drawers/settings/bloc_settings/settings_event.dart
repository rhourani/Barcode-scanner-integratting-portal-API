part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class ChangePasswordButtonPressed extends SettingsEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordButtonPressed({
    @required this.oldPassword,
    @required this.newPassword
  });

  @override
  List<Object> get props => [oldPassword, newPassword];

  @override
  String toString() => 'ChangePasswordButtonPressed { oldPassword: $oldPassword, newPassword: $newPassword }';
}
