import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipment_app/core/shared_prefrances/app_prefrances.dart';
import 'package:shipment_app/cubit/app_cubit.dart';
import 'package:shipment_app/presentation/home/home_screen.dart';
import 'package:shipment_app/presentation/login/login_screen.dart';

RegExp ups = RegExp(r'1Z[0-9A-Z]{16}');
RegExp dpd = RegExp(r'1550[0-9]{10}');
RegExp royalMail = RegExp(r'[A-Z]{2}[0-9]{9}GB');
RegExp amazonLogistics = RegExp(r'[A-Z]{1}[0-9]{11}');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppPrefreances.init();
  Widget boot = LoginScreen();
  // ignore: unrelated_type_equality_checks
  if (await AppPrefreances().getEmail() != '') {
    boot = const HomeScreen();
  }
  runApp(MyApp(
    boot: boot,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key, required this.boot});
  Widget boot;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) => BlocProvider(
              create: (context) => AppCubit(),
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                  ),
                  home: boot),
            ));
  }
}
