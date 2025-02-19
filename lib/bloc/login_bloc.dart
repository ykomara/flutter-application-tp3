import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

const users = {
  'ykomara@gmail.com': '62333',
  'medmo@gmail.com': '7517',
};

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 2));

      if (!users.containsKey(event.username)) {
        emit(LoginFailure(error: "Utilisateur non trouvé"));
      } else if (users[event.username] != event.password) {
        emit(LoginFailure(error: "Mot de passe incorrect"));
      } else {
        emit(LoginSuccess());
      }
    });
  }
}
