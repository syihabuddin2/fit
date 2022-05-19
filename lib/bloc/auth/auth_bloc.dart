import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit/service/login/loginservice.dart';
import 'package:fit/service/profile/profileservice.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  LoginService loginService;
  ProfileService profileService;

  AuthBloc({required this.loginService, required this.profileService}) : super(AuthLoading());

  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {

    bool hasToken = await loginService.hasToken();

    if (event is AppStarted) {
      if (hasToken) {
        yield NextToDashboardState();
      } else {
        UnAuthenticatedState();
      }
    }

    if (event is LoginPressButton) {
      try {
        yield AuthLoading();

        final loginResponse = await loginService.login(
          email: event.email,
          password: event.password,
        );

        yield AuthenticatedState();
      } catch (error) {
        yield AuthError(error: error.toString());
        yield UnAuthenticatedState();
      }
    }

    if (event is LogoutPressButton) {
      await loginService.logout();
      yield UnAuthenticatedState();
    }

    if (event is NextToDashBoardButton) {
      await profileService.addProfile(
        name: event.name,
        dateOfBirth: event.dateOfBirth,
        gender: event.gender,
        height: event.height,
        weight: event.weight,
      );
      yield NextToDashboardState();
    }
  }
}
