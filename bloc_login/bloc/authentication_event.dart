part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
  List<Object> get permissionsProps => [];
  List<Object> get comPermissionsProps => [];
  }

class AppStarted extends AuthenticationEvent {}

class GetCompanyPermissions extends AuthenticationEvent {
  final CompanyDetails companyDetails;
  GetCompanyPermissions({@required this.companyDetails});
  @override
  List<Object> get comPermissionsProps => [companyDetails];
}


class LoggedIn extends AuthenticationEvent {
  final UserLoginDetails user;
  final UserPermissions userPermissions;

  const LoggedIn({@required this.user,@required this.userPermissions});
  @override
  List<Object> get props => [user];
  @override
  List<Object> get permissionsProps => [userPermissions];
  @override
  String toString() => 'LoggedIn { email: $user.email.toString() }';
}

class LoggedIn2 extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}