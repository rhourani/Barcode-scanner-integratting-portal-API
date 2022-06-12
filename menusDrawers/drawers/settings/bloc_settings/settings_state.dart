part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsFailure extends SettingsState {
  final String error;

  const SettingsFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => ' SettingsFailure { error: $error }';
}

class ChangePasswordSuccess extends SettingsState {}
