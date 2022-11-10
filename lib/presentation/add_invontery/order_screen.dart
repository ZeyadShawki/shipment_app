import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shipment_app/cubit/app_cubit.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key, required this.image, required this.name})
      : super(key: key);
  final String image;
  final String name;
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      bloc: AppCubit()..getOrders(name),
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetOrderSuccessState) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
              child: SingleChildScrollView(
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image(
                          height: 200.h,
                          width: 200.w,
                          fit: BoxFit.cover,
                          image: NetworkImage(image)),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "product: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.sp,
                              decoration: TextDecoration.underline),
                        ),
                        TextSpan(
                          text: name,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 28.sp,
                              decoration: TextDecoration.underline),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Orders Count:${state.orders.length} ",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20.sp,
                          decoration: TextDecoration.underline),
                    ),
                    ListView.separated(
                        controller: _controller,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return orderItem(
                              platform: state.orders[index].platform,
                              orderId: state.orders[index].orderId,
                              trackingId: state.orders[index].trackingId,
                              dilvered: state.orders[index].deliveryStatus);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10.h,
                            ),
                        itemCount: state.orders.length),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Center(
                        child: CircleAvatar(
                          child: Icon(
                            Icons.add,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is GetOrderLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image(
                          height: 200.h,
                          width: 200.w,
                          fit: BoxFit.cover,
                          image: NetworkImage(image)),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "product: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.sp,
                              decoration: TextDecoration.underline),
                        ),
                        TextSpan(
                          text: name,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 28.sp,
                              decoration: TextDecoration.underline),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 400.h,
                      child: Center(
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "No Orders Yet Added",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 28.sp,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget orderItem(
      {required String platform,
      required String orderId,
      required String trackingId,
      required bool dilvered}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "platfrom: ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              platform,
              style: TextStyle(fontSize: 15.sp),
            )
          ],
        ),
        Row(
          children: [
            Text(
              "orderId: ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              orderId,
              style: TextStyle(fontSize: 15.sp),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "trackingId: ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              trackingId,
              style: TextStyle(fontSize: 15.sp),
            ),
          ],
        ),
        if (dilvered) ...[
          Icon(
            Icons.check_circle_outline_outlined,
            color: Colors.green,
            size: 25.r,
          )
        ] else ...[
          Icon(
            Icons.highlight_remove_outlined,
            size: 25.r,
            color: Colors.red,
          )
        ]
      ],
    );
  }
}
