import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipment_app/core/extension/is_numric_fun.dart';
import 'package:shipment_app/core/resources/Navigator_take_widget.dart';
import 'package:shipment_app/model/order_model.dart';
import 'package:shipment_app/presentation/add_invontery/order_screen.dart';

import '../../cubit/app_cubit.dart';

class AddOrderScreen extends StatefulWidget {
   const AddOrderScreen({Key? key, required this.name, required this.image}) : super(key: key);
   final String name;
   final String image;
  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final TextEditingController _platCont=TextEditingController();

  final TextEditingController _orderIdCont=TextEditingController();

  final TextEditingController _trackIdCont=TextEditingController();
  final  _formKey=GlobalKey<FormState>();
  bool _dilveryStatus=false;
 int? group=2;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    if(state is AddOrderSuccessState){
      Navigator.pop(context);
      NavigatorTakeWidget.navigatornoback(context, OrderScreen(image:widget.image,name: widget.name));
    }
  },
  builder: (context, state) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.only(top: 40,left: 20,right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _platCont,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'platform',
                ),
                validator: (String? value) {
                  if (value!.isEmpty) return 'platform should not be empty';
                  return null;
                },
                onSaved: (value) {
                },
                onFieldSubmitted: (value) {},
              ),
              SizedBox(height: 10.h,),
              TextFormField(
                controller: _orderIdCont,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Order Id',
                ),
                validator: (String? value) {

                  if (value!.isEmpty&&value.isNumeric(value.toString())) return 'Order Id should not be empty and be number';
                  return null;
                },
                onSaved: (value) {
                },
                onFieldSubmitted: (value) {},
              ),
              SizedBox(height: 10.h,),

              TextFormField(
                controller: _trackIdCont,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Track Id',
                ),
                validator: (String? value) {
                  if (value!.isEmpty&&value.isNumeric(value.toString())) {
                    return 'Track Id should not be empty and be number';
                  }
                  return null;
                },
                onSaved: (value) {
                },
                onFieldSubmitted: (value) {},
              ),
              SizedBox(height: 10.h,),
              Text(

                'Delivery Status',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.sp,
                  decoration: TextDecoration.underline
                ),
              ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                    SizedBox(
                      width: 150.w,
                       child: RadioListTile (
                       title: const Text('Yes'),
                      selected: _dilveryStatus,
                       value: 1,
                       groupValue: group,
                       onChanged: (value){
                         setState(() {
                           group=value;
                           _dilveryStatus=true;
                         });
                       },
                   ),
                    ),
                   SizedBox(
                     width: 150.w,
                     child: RadioListTile (
                       title: const Text('No'),
                       selected: _dilveryStatus,
                       value: 2,
                       groupValue: group,
                       onChanged: (value){
                         setState(() {
                           group=value;
                           _dilveryStatus=false;
                         });
                       },
                     ),
                   ),
                 ],
               ),
              if(state is !AddOrderLoadingState)...[
              InkWell(
                onTap: () {

                  if(_formKey.currentState!.validate()&&_trackIdCont.text.isNumeric(_trackIdCont.text)&&_orderIdCont.text.isNumeric(_orderIdCont.text)){
                     context.read<AppCubit>().addOrders(
                         name: widget.name,
                         model: OrderModel(
                             platform: _platCont.text,
                             orderId: _orderIdCont.text.split('.').first,
                             trackingId: _trackIdCont.text.split('.').first,
                             deliveryStatus: _dilveryStatus));


                  }else{
                    Fluttertoast.showToast(msg: 'Please make sure you added all requierments right');
                  }
                }
                ,
                child: Container(
                  width: double.infinity,
                  color: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Add Order',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp),
                  ),
                ),
              ),]else...[
                const Center(child: CircularProgressIndicator(),),
              ]
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
