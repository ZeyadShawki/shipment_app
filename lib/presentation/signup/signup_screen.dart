import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../cubit/app_cubit.dart';
import '../home/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _passCont = TextEditingController();
  final TextEditingController _usernameCont = TextEditingController();

  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is SignUpSuccessState){
          Fluttertoast.showToast(msg: "Signed Up Successfully");
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>const HomeScreen()), (route) => false);
        }
        if(state is SignUpErrorState){
          Fluttertoast.showToast(msg: state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Colors.transparent,

              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
          ),
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding:
                const EdgeInsets.only(top: 0.0,left: 20,right: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'SignUp to add shipment',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: _usernameCont,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'UserName',
                        prefixIcon: Icon(Icons.account_circle),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) return 'UserName should not be empty';
                        return null;
                      },
                      onSaved: (value) {
                      },
                      onFieldSubmitted: (value) {},
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: _emailCont,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Adress',
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Email should not be empty';
                        return null;
                      },
                      onSaved: (value) {
                      },
                      onFieldSubmitted: (value) {},
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: _passCont,
                      obscureText: context.read<AppCubit>().obscure,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon:InkWell(
                              onTap: ()=>context.read<AppCubit>().hidePassword(),
                              child: Icon(context.read<AppCubit>().passIcon))),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Password should not be empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if(state is SignUpLoadingState)...[
                      const Center(child: CircularProgressIndicator(),)
                    ]
                    else...[
                    InkWell(
                      onTap: () {
                        if (_formState.currentState!.validate()) {
                          context.read<AppCubit>().signUp(
                              username: _usernameCont.text,
                              password: _passCont.text,
                              email: _emailCont.text);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        color: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'Have an Acount ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        TextButton(
                            onPressed: () {
                             Navigator.pop(context);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            )),
                      ],
                    )],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
