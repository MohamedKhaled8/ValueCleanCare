import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:vc/widgets/arrow_back_icons.dart';

import '../../theme/constant/sized.dart';

class QrScan extends StatefulWidget {
 const QrScan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title:  Text('Team Check'.tr,style: TextStyle(fontSize: 16.sp),),
        leading: ArrowBackIcon(ontap: () {
          Get.back();
        }),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
            borderColor: Colors.white,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: screenUtil.setHeight(230)),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
           Positioned(
              left: 100,
              bottom: 210,
              child: Text(
                "place the code inside the frame".tr,
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              )),
             
          Positioned(
            left: 170,
            bottom: 20,
            child: Container(
              height: screenUtil.setHeight(48),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(179, 179, 179, 1),
                borderRadius: BorderRadius.circular(10).w,
              ),
              child: result != null
                  ? Text(
                      ' Accepted: ${result!.code}'.tr,
                      style:  TextStyle(fontSize: 18.sp),
                    )
                  : Container(
                      color: Colors.green, child:  Text('Scan a code'.tr,style: TextStyle(fontSize: 18.sp),)),
            ),
          ),
          SizedBox(
            height: screenUtil.setHeight(50),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('no Permission'.tr)),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
