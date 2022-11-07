import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipment_app/core/resources/Navigator_take_widget.dart';
import 'package:shipment_app/presentation/add_invontery/add_new_record_screen.dart';

class AddInvonteryScreen extends StatelessWidget {
  const AddInvonteryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.red,
            height: 400,

          ),
          SizedBox(
            height: 10.h,
          ),
          InkWell(
            onTap: (){
              NavigatorTakeWidget.navigatorwithback(context, AddNewRecordScreen());
            },
            child: const CircleAvatar(

              child: Icon(
                Icons.add
              ),
            ),
          )
        ],
      ),
    );
  }
}
