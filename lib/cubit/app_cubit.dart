// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shipment_app/core/shared_prefrances/app_prefrances.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  IconData passIcon=Icons.remove_red_eye_rounded;
  bool obscure=false;
  void hidePassword(){
   passIcon= obscure?Icons.visibility_off:Icons.visibility;
    obscure=!obscure;
    emit(HidePassword());
  }


  void login(String username, String password)async {
    emit(LoginLoadingState());
    final snap = await FirebaseFirestore.instance.collection('users').doc(
        username).get();
    if (snap.exists) {
      String email=snap.data()!['email'];
      AppPrefreances().saveEmail(email);
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
            emit(LoginSuccessState());
      }).catchError((e) {

        emit(LoginErrorState(e.toString()));
      });
    }else{
      emit(LoginErrorState('The email or password is incorrect'));

    }

  }
  void signUp({required String email,required String password,required String username}) {
    emit(SignUpLoadingState());
    FirebaseAuth.instance.
    createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
        FirebaseFirestore.instance.collection('users').doc(username).set(
          {
            "email":email
          }
        );
        emit(SignUpSuccessState());
    }).catchError((e){
      emit(SignUpErrorState(e.toString()));
    });
  }
}
