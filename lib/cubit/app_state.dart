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


class ImageLoadingState extends AppState {}
class ImageSuccessState extends AppState {}
class ImageErrorState extends AppState {
  final String message;

  ImageErrorState(this.message);

}


class AddRecordLoadingState extends AppState {}
class AddRecordSuccessState extends AppState {}
class AddRecordErrorState extends AppState {
  final String message;

  AddRecordErrorState(this.message);

}

class  GetRecordLoadingState extends AppState {}
// ignore: must_be_immutable
class  GetRecordSuccessState extends AppState {
  List<RecordModel> records;
  GetRecordSuccessState(this.records);
}
class  GetRecordErrorState extends AppState {
  final String message;

  GetRecordErrorState(this.message);

}