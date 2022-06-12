import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/bloc/authentication_bloc.dart';
import 'package:ioi_barcode_scanner/bloc_login/dao/user_dao.dart';
import 'package:ioi_barcode_scanner/bloc_login/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent,SettingsState> {
  final UserRepository userRepository;


  UserDao userDao;

  SettingsBloc({
    @required this.userRepository,
  })  : assert(userRepository != null);

  @override
  SettingsState get initialState => SettingsInitial();

  @override
  Stream<SettingsState> mapEventToState(
      SettingsEvent event,
      ) async* {
    if (event is ChangePasswordButtonPressed) {
      yield SettingsInitial();
      try {
        final String token = await userRepository.getTokenFromDB();
        bool isChanged = await userRepository.changeUserPassword(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
          token: token,
        );
        if(isChanged){
          yield ChangePasswordSuccess();
        }
      } catch (error) {
        yield SettingsFailure(error: error.toString());
      }
    }
  }
}