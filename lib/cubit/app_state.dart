part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class HidePassword extends AppState {}

class LoginLoadingState extends AppState {}
class LoginSuccessState extends AppState {}
class LoginErrorState extends AppState {
  final String message;

  LoginErrorState(this.message);

}

class SignUpLoadingState extends AppState {}
class SignUpSuccessState extends AppState {}
class SignUpErrorState extends AppState {
  final String message;

  SignUpErrorState(this.message);

}
