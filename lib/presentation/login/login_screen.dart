import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipment_app/core/resources/Navigator_take_widget.dart';
import 'package:shipment_app/cubit/app_cubit.dart';
import 'package:shipment_app/presentation/home/home_screen.dart';
import 'package:shipment_app/presentation/signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _username = TextEditingController();
  final TextEditingController _passCont = TextEditingController();
  final  _formState=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is LoginSuccessState){
          Fluttertoast.showToast(msg: "Logged In Successfully");
          NavigatorTakeWidget.navigatornoback(context, const HomeScreen());
        }
        if(state is LoginErrorState){
          Fluttertoast.showToast(msg: state.message);
        }
      },
      builder: (context, state) {
        return  Scaffold(
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
            padding: const EdgeInsets.only(top: 0.0, left: 20,right: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child:Form(
                key: _formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Login to add shipment',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: _username,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'UserName',
                        prefixIcon: Icon(Icons.account_circle),
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

                          suffixIcon: InkWell(
                              onTap: ()=>context.read<AppCubit>().hidePassword(),
                              child: Icon(context.read<AppCubit>().passIcon))),
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Password should not be empty';
                        return null;
                      },
                      onSaved: (value) {
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if(state is LoginLoadingState)...[
                      const Center(child: CircularProgressIndicator(),)
                    ]
                    else...[
                    InkWell(
                      onTap: (){
                        if(_formState.currentState!.validate()) {
                          context.read<AppCubit>().login(_username.text, _passCont.text);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        color: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Login',
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
                          'Don\'t Have Acount Signup',
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
                              NavigatorTakeWidget.navigatorwithback(context, SignUpScreen());
                            },
                            child: Text(
                              'Signup',
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
