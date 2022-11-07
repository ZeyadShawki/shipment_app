// ignore: depend_on_referenced_packages
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipment_app/core/shared_prefrances/app_prefrances.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
      required String username}) {
    emit(SignUpLoadingState());
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

  final ImagePicker _picker=ImagePicker();
   File? image;
    String? url;
  void pickImage()async{
    final pick=await _picker.pickImage(source: ImageSource.gallery);
    if(pick==null){
      return;
    }else{
      image=File(pick.path);
      uploadImage();
    }
  }
  void uploadImage()async{
    emit(ImageLoadingState());
    if(image!=null){
   await firebase_storage.
      FirebaseStorage.instance.ref().child('images/${image!.uri.pathSegments.last}')
          .putFile(image as File).then((value)async {
        url =await value.ref.getDownloadURL();
             emit(ImageSuccessState());
      }).catchError((e){
        emit(ImageErrorState(e.toString()));
      });
    }
  }

  void addRecord(RecordModel model)async{
    emit(AddRecordLoadingState());
    FirebaseFirestore.instance.collection('inventory')
        .doc(model.name).set(model.toJson(model))
        .then((value) {
      emit(AddRecordSuccessState());

    }).catchError((e){
      emit(AddRecordErrorState(e.toString()));

    });
  }


}
