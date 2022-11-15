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

class GetRecordLoadingState extends AppState {}

// ignore: must_be_immutable
class GetRecordSuccessState extends AppState {
  List<RecordModel> records;
  GetRecordSuccessState(this.records);
}

class GetRecordErrorState extends AppState {
  final String message;

  GetRecordErrorState(this.message);
}

class GetOrderLoadingState extends AppState {}

// ignore: must_be_immutable
class GetOrderSuccessState extends AppState {
  List<OrderModel> orders;
  GetOrderSuccessState(this.orders);
}

class GetOrderErrorState extends AppState {
  final String message;

  GetOrderErrorState(this.message);
}

class AddOrderLoadingState extends AppState {}

class AddOrderSuccessState extends AppState {}

class AddOrderErrorState extends AppState {
  final String message;

  AddOrderErrorState(this.message);
}

class EditOrderLoadingState extends AppState {}

class EditOrderSuccessState extends AppState {}

class EditOrderErrorState extends AppState {
  final String message;

  EditOrderErrorState(this.message);
}

class ScanOrderSuccessState extends AppState {
  final OrderModel orderModel;
  final RecordModel recordModel;

  ScanOrderSuccessState(this.orderModel, this.recordModel);
}

class ScanOrderLoadingState extends AppState {}

class ScanOrderErrorState extends AppState {
  final String message;

  ScanOrderErrorState(this.message);
}

class DeliveryStatusSuccessState extends AppState {
  DeliveryStatusSuccessState();
}

class DeliveryStatusLoadingState extends AppState {}

class DeliveryStatusErrorState extends AppState {
  final String message;

  DeliveryStatusErrorState(this.message);
}
