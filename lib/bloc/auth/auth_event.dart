part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoginPressButton extends AuthEvent {
  String? email;
  String? password;

  LoginPressButton({this.email, this.password});
}

class LogoutPressButton extends AuthEvent {}

class NextToDashBoardButton extends AuthEvent {
  String? name;
  String? dateOfBirth;
  String? gender;
  double? height;
  double? weight;

  NextToDashBoardButton({this.name, this.dateOfBirth, this.gender, this.height, this.weight});
}
