import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shipment_app/core/extensions/string_extension.dart';
import 'package:shipment_app/core/resources/Navigator_take_widget.dart';
import 'package:shipment_app/cubit/app_cubit.dart';
import 'package:shipment_app/presentation/add_invontery/add_invontery_screen.dart';
import 'package:shipment_app/presentation/add_shipment/add_shipment_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String code = '';
  String type = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PermissionStatus>(
          future: Permission.camera.request(),
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.hasData) {
              if (snapshot.data!.isGranted) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          NavigatorTakeWidget.navigatorwithback(
                              context, AddInvonteryScreen());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          color: Colors.blue,
                          child: Text(
                            'Check inventory',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const AddShipmentScreen())),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          color: Colors.black,
                          child: Text(
                            'Add Shipment',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () async {
                          String barcodeScanRes =
                              await FlutterBarcodeScanner.scanBarcode(
                            "#ff6666",
                            "Cancel",
                            false,
                            ScanMode.BARCODE,
                          );

                          code = barcodeScanRes.getCode();
                          type = barcodeScanRes.getType();
                          if (mounted)
                          {
                            final bool=await context.read<AppCubit>().checkInvontry(code: code, type: type);
                            if(bool){
                              Fluttertoast.showToast(msg: "Added quantity successfuly");
                            }else{
                              Fluttertoast.showToast(msg: "not found item with this tracking id or name");
                            }
                          }

                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          color: Colors.black,
                          child: Text(
                            'Add BarCode',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        '$code\n$type',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('Please Confirm Permission'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
