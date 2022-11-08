import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipment_app/core/resources/Navigator_take_widget.dart';
import 'package:shipment_app/cubit/app_cubit.dart';
import 'package:shipment_app/model/record_model.dart';
import 'package:shipment_app/presentation/add_invontery/add_invontery_screen.dart';

class AddNewRecordScreen extends StatelessWidget {
  final TextEditingController _name=TextEditingController();
  final TextEditingController _quantity=TextEditingController();
  final _formKey=GlobalKey<FormState>();
   AddNewRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is AddRecordSuccessState){
          NavigatorTakeWidget.navigatorwithback(context,AddInvonteryScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body:  Padding(
            padding: const EdgeInsets.only(top: 60.0,left: 20,right: 20),
            child:  SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        context.read<AppCubit>().pickImage();

                      },
                      child: Container(
                          color: Colors.grey,
                          width: double.infinity,
                          child:context.read<AppCubit>().image!=null? Image.file(
                            context.read<AppCubit>().image as File,fit: BoxFit.cover,):const Icon(Icons.add,size: 100)
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    if(state is ImageLoadingState)...[
                      const Center(child: LinearProgressIndicator(),),
                    ],
                    SizedBox(height: 25.h,),
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Name should not be empty';
                        return null;
                      },
                      onSaved: (value) {
                      },
                      onFieldSubmitted: (value) {},
                    ),
                    SizedBox(height: 25.h,),
                    TextFormField(
                      controller: _quantity,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mutual Quantity',
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Quantity should not be empty';
                        return null;
                      },
                      onSaved: (value) {
                      },
                      onFieldSubmitted: (value) {},
                    ),
                    SizedBox(height: 25.h,),
                    if(state is !ImageLoadingState && state is !AddRecordLoadingState )...[
                    InkWell(
                      onTap: () {
                        if(_formKey.currentState!.validate()&&context.read<AppCubit>().url!=null){
                          var num=int.parse(_quantity.text.split('.').first);
                          context.read<AppCubit>().addRecord(
                              RecordModel(
                                  image: context.read<AppCubit>().url.toString(),
                                  name: _name.text,
                                  quantity: num.toInt()));
                        }else{
                          Fluttertoast.showToast(msg: 'Please make sure you added all requierments');
                        }
                      }
                      ,
                      child: Container(
                        width: double.infinity,
                        color: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Add Record',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ),
                      ),
                    ),],
                    if(state is AddRecordLoadingState)...[
                      const Center(child: CircularProgressIndicator(),)
                    ],
                    SizedBox(height: 30.h,),
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
