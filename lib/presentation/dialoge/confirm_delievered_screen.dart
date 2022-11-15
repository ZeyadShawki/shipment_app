import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipment_app/cubit/app_cubit.dart';
import 'package:shipment_app/model/order_model.dart';
import 'package:shipment_app/model/record_model.dart';

class ConfirmDelieveredScreen extends StatelessWidget {
  final OrderModel orderModel;
  final RecordModel recordModel;
  const ConfirmDelieveredScreen(
      {super.key, required this.orderModel, required this.recordModel});

  @override
  Widget build(BuildContext context) {
    final bool isDelieveried = orderModel.deliveryStatus;
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is DeliveryStatusSuccessState) {
          Navigator.of(context).pop();
        } else if (state is DeliveryStatusErrorState) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                      child: Text(
                    isDelieveried
                        ? 'Order already marked as delievered'
                        : 'Successfuly found order',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  )),
                  const SizedBox(height: 20),
                  const Center(
                      child: Text(
                    'Product information',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(recordModel.image),
                      ),
                      const SizedBox(height: 10),
                      Text(recordModel.name),
                      const SizedBox(height: 10),
                      Text(recordModel.quantity.toString()),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.black),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Order information',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(orderModel.orderDate),
                      const SizedBox(height: 10),
                      Text(orderModel.orderId),
                      const SizedBox(height: 10),
                      Text(orderModel.orderQuantity),
                      const SizedBox(height: 10),
                      Text(orderModel.platform),
                      const SizedBox(height: 10),
                      Text(orderModel.trackingId),
                    ],
                  ),
                  if (!isDelieveried)
                    Column(
                      children: [
                        const SizedBox(height: 50),
                        const Text('Mark as deleivered?'),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () => BlocProvider.of<AppCubit>(context)
                                  .markAsDeleivered(true, orderModel),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: const Icon(Icons.check),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () => BlocProvider.of<AppCubit>(context)
                                  .markAsDeleivered(false, orderModel),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: const Icon(Icons.close),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
