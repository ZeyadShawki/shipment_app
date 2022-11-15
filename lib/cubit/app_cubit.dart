// ignore: depend_on_referenced_packages
import 'dart:developer';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipment_app/core/shared_prefrances/app_prefrances.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shipment_app/model/order_model.dart';
import 'package:shipment_app/model/record_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  IconData passIcon = Icons.remove_red_eye_rounded;
  bool obscure = false;
  void hidePassword() {
    passIcon = obscure ? Icons.visibility_off : Icons.visibility;
    obscure = !obscure;
    emit(HidePassword());
  }

  void login(String username, String password) async {
    emit(LoginLoadingState());
    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(username)
        .get();
    if (snap.exists) {
      String email = snap.data()!['email'];
      AppPrefreances().saveEmail(email);
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        emit(LoginSuccessState());
      }).catchError((e) {
        emit(LoginErrorState(e.toString()));
      });
    } else {
      emit(LoginErrorState('The email or password is incorrect'));
    }
  }

  void signUp(
      {required String email,
      required String password,
      required String username}) async {
    emit(SignUpLoadingState());
    final reponse = await FirebaseFirestore.instance
        .collection('users')
        .doc(username)
        .get();
    if (reponse.exists) {
      emit(SignUpErrorState(
          'Username is already taken please try other username'));
      return;
    }
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      AppPrefreances().saveEmail(email);
      FirebaseFirestore.instance
          .collection('users')
          .doc(username)
          .set({"email": email});
      emit(SignUpSuccessState());
    }).catchError((e) {
      emit(SignUpErrorState(e.toString()));
    });
  }

  final ImagePicker _picker = ImagePicker();
  File? image;
  String? url;
  void pickImage() async {
    final pick = await _picker.pickImage(source: ImageSource.gallery);
    if (pick == null) {
      return;
    } else {
      image = File(pick.path);
      uploadImage();
    }
  }

  void uploadImage() async {
    emit(ImageLoadingState());
    if (image != null) {
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${image!.uri.pathSegments.last}')
          .putFile(image as File)
          .then((value) async {
        url = await value.ref.getDownloadURL();
        emit(ImageSuccessState());
      }).catchError((e) {
        emit(ImageErrorState(e.toString()));
      });
    }
  }

  void addRecord(RecordModel model) async {
    emit(AddRecordLoadingState());
    final String? email = await AppPrefreances().getEmail();
    FirebaseFirestore.instance
        .collection('inventory')
        .doc(email)
        .collection('products')
        .doc(model.name)
        .set(model.toJson(model))
        .then((value) {
      emit(AddRecordSuccessState());
    }).catchError((e) {
      emit(AddRecordErrorState(e.toString()));
    });
  }

  void getRecords() async {
    List<RecordModel> records = [];
    final String? email = await AppPrefreances().getEmail();

    emit(GetRecordLoadingState());
    FirebaseFirestore.instance
        .collection('inventory')
        .doc(email)
        .collection('products')
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        records.add(RecordModel.fromJson(value.docs[i].data()));
      }
      emit(GetRecordSuccessState(records));
    }).catchError((e) {
      emit(GetRecordErrorState(e.toString()));
    });
  }

  void getOrders(String name) async {
    emit(GetOrderLoadingState());
    final String? email = await AppPrefreances().getEmail();
    final response = await FirebaseFirestore.instance
        .collection('inventory')
        .doc(email)
        .collection('products')
        .doc(name)
        .collection('orders')
        .get();
    if (response.size != 0) {
      final List<OrderModel> orders = [];
      final snap = response.docs;
      for (int i = 0; i < snap.length; i++) {
        orders.add(OrderModel.fromJson(snap[i].data()));
        emit(GetOrderSuccessState(orders));
      }
    } else {
      emit(GetOrderErrorState('No Orders Added yet'));
    }
  }

  void addOrders({required String name, required OrderModel model}) async {
    emit(AddOrderLoadingState());
    final String? email = await AppPrefreances().getEmail();

    FirebaseFirestore.instance
        .collection('inventory')
        .doc(email)
        .collection('products')
        .doc(name)
        .collection('orders')
        .doc()
        .set(OrderModel.toJson(model))
        .then((value) {
      emit(AddOrderSuccessState());
    }).catchError((e) {
      emit(AddOrderErrorState(e.toString()));
    });
  }

  void editOrder(
      {required String oldPlatform,
      required String oldOrderId,
      required String oldTrackingId,
      required String name,
      required OrderModel model}) async {
    emit(EditOrderLoadingState());
    final email = await AppPrefreances().getEmail();
    await FirebaseFirestore.instance
        .collection("inventory")
        .doc(email)
        .collection('products')
        .doc(name)
        .collection('orders')
        .where('orderId', isEqualTo: oldOrderId)
        .where('trackingId', isEqualTo: oldTrackingId)
        .where('platform', isEqualTo: oldPlatform)
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection("inventory")
          .doc(email)
          .collection('products')
          .doc(name)
          .collection('orders')
          .doc(value.docs[0].id)
          .set(OrderModel.toJson(model));
      emit(EditOrderSuccessState());
    }).catchError((e) {
      emit(EditOrderErrorState(e.toString()));
    });
  }

  void checkInvontry({required String code}) async {
    emit(ScanOrderLoadingState());
    try {
      final email = await AppPrefreances().getEmail();
      List<OrderModel> orders = [];
      await FirebaseFirestore.instance
          .collection('inventory')
          .doc(email)
          .collection("products")
          .get()
          .then(
        (products) async {
          for (var product in products.docs) {
            await FirebaseFirestore.instance
                .collection("inventory")
                .doc(email)
                .collection('products')
                .doc(product.id.toString())
                .collection('orders')
                .where('trackingId', isEqualTo: code)
                .get()
                .then((orderDocs) {
              final ordersDocuments = orderDocs.docs;
              for (var order in ordersDocuments) {
                final data = order.data();
                orders.add(OrderModel.fromJson(data));
              }
            });
          }
        },
      );
      orders.sort();
      if (orders.isNotEmpty) {
        final model = orders[0];
        final secondModel = await FirebaseFirestore.instance
            .collection('inventory')
            .doc(email)
            .collection("products")
            .doc(model.name)
            .get();

        final recordModel = RecordModel.fromJson(secondModel.data()!);

        emit(ScanOrderSuccessState(model, recordModel));
      } else {
        emit(ScanOrderErrorState('Item not found in databaseS'));
      }
    } catch (e) {
      emit(ScanOrderErrorState('Error found'));
    }
  }

  void markAsDeleivered(bool isDeleivered, OrderModel model) async {
    emit(DeliveryStatusLoadingState());
    try {
      final email = await AppPrefreances().getEmail();
      if (isDeleivered) {
        FirebaseFirestore.instance
            .collection('inventory')
            .doc(email)
            .collection('products')
            .doc(model.name)
            .get()
            .then((value) {
          FirebaseFirestore.instance
              .collection('inventory')
              .doc(email)
              .collection('products')
              .doc(model.name)
              .update({
            'quantity':
                (value.data()!['quantity'] + int.parse(model.orderQuantity)),
          });
        });

        await FirebaseFirestore.instance
            .collection('inventory')
            .doc(email)
            .collection("products")
            .doc(model.name)
            .collection('orders')
            .where('trackingId', isEqualTo: model.trackingId)
            .where('orderDate', isEqualTo: model.orderDate)
            .get()
            .then((value) {
          FirebaseFirestore.instance
              .collection('inventory')
              .doc(email)
              .collection("products")
              .doc(model.name)
              .collection('orders')
              .doc(value.docs[0].id)
              .update({'deliveryStatus': isDeleivered});
        });
      }

      emit(DeliveryStatusSuccessState());
    } catch (e) {
      emit(DeliveryStatusErrorState(e.toString()));
    }
  }
}
