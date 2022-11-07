import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipment_app/core/resources/Navigator_take_widget.dart';
import 'package:shipment_app/presentation/add_invontery/add_invontery_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                NavigatorTakeWidget.navigatorwithback(context, const AddInvonteryScreen());

              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                color: Colors.blue,
                child: Text(
                  'Check inventory',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            InkWell(
              onTap: (){
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                color: Colors.black,
                child: Text(
                  'Add Shipment',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
