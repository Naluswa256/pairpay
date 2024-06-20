// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Fired just after the app is launched
class AppLoadedup extends AuthenticationEvent {}

class UserLogOut extends AuthenticationEvent {}

class GetUserData extends AuthenticationEvent {}

class UserSignUp extends AuthenticationEvent {
  final String fullNames;
  final String email;
  final String password;

  const UserSignUp({required this.fullNames, required this.email, required this.password});

  @override
  List<Object> get props => [fullNames, email, password];
}

class UserLogin extends AuthenticationEvent {
  final String email;
  final String password;

  const UserLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class ForgotPassword extends AuthenticationEvent {
  final String email;

  const ForgotPassword({required this.email});

  @override
  List<Object> get props => [email];
}

class ResetPassword extends AuthenticationEvent {
  final String newPassword;

  const ResetPassword({required this.newPassword});

  @override
  List<Object> get props => [newPassword];
}
