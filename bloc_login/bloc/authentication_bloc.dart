import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/repository/user_repository.dart';
import 'package:ioi_barcode_scanner/model/userAccount/userLoginDetailsModel.dart';
import 'package:ioi_barcode_scanner/model/userPermissions/companyList_model.dart';
import 'package:ioi_barcode_scanner/model/userPermissions/user_permissions.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(UserRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUnintialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();

      await userRepository.persistToken(user: event.user);

      await userRepository.persistPermissions(
          userPermissions: event.userPermissions);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();

      await userRepository.deleteToken(id: 0);
      await userRepository.dropDB();

      yield AuthenticationUnauthenticated();
    }
  }
}
