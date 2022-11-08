import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipment_app/core/resources/Navigator_take_widget.dart';
import 'package:shipment_app/cubit/app_cubit.dart';
import 'package:shipment_app/presentation/add_invontery/add_new_record_screen.dart';

class AddInvonteryScreen extends StatelessWidget {
   AddInvonteryScreen({Key? key}) : super(key: key);
  final ScrollController _controller=ScrollController();
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppState>(
      bloc: AppCubit()..getRecords(),
      listener: (context, state) {

      },
      builder: (context, state) {
        if(state is GetRecordSuccessState) {
          return Scaffold(

          body: Padding(
            padding: const EdgeInsets.only(top: 40.0,right: 10,left: 10),
            child:  SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Items',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30.sp
                    ),
                  ),
                   if(state.records.isNotEmpty)...[
                   ListView.separated(
                     controller: _controller,
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>
                          item(
                              url: state.records[index].image,
                              name: state.records[index].name,
                              quantity: state.records[index].quantity,
                          ),
                      separatorBuilder: (context,index)=>SizedBox(height: 10.h,),
                      itemCount: state.records.length),]else...[
                     Center(
                       child: Text('No Items added yet',
                         textAlign: TextAlign.start,
                         style: TextStyle(
                             color: Colors.blue,
                             fontSize: 30.sp
                         ),
                       ),
                     ),
                   ],
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: (){
                      File? temp;
                      context.read<AppCubit>().image=temp;
                      NavigatorTakeWidget.navigatorwithback(context, AddNewRecordScreen());
                    },
                    child: const Center(
                      child: CircleAvatar(

                        child: Icon(

                            Icons.add,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),

                ],
              ),
            ),
          ),
        );
        }else if(state is GetRecordLoadingState){
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(),),
          );
        }else{
          return const Scaffold();
        }
      },
    );
  }

  Widget item({
   required String url,
   required String name,
   required int quantity,
}){
    return Row(
      children: [
        Image(
            height: 120.h,
            width: 120.w,
            fit: BoxFit.cover,
            image: NetworkImage(
          url
        ))  ,
        SizedBox(width: 10.w,),
        Flexible(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp
            ),
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            'Quantity:${quantity.toString()}',
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp
            ),
          ),
        ),
      ],
    );
  }
}
