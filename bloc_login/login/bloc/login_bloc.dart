import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/bloc/authentication_bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/dao/user_dao.dart';
import 'package:ioi_barcode_scanner/bloc_login/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  UserDao userDao;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
    if (event is LoginButtonPressed) {
      yield LoginInitial();
      try {
        final user = await userRepository.authenticate(
          email: event.email,
          password: event.password,
        );
        String token = user.token;
        String bearer = "Bearer ";
        String finalToken = bearer+token;
        final userPermissions = await userRepository.authPermissions(
            token: finalToken,
        );
        authenticationBloc.add(LoggedIn(user: user, userPermissions: userPermissions));
        yield LoginInitial();
        //companyBloc.add(FetchCompanyFromServer());
       // yield LoginInitial();

      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}