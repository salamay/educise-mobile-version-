import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:educise/API/Get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
class QRWidget extends StatefulWidget {
  String token;
  QRWidget({this.token});
  @override
  _QRWidgetState createState() => _QRWidgetState();
}

class _QRWidgetState extends State<QRWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;


// In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }
  showSuccess(){
    return  AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        title: 'Success',
        desc:"Success",
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        })..show();
  }
  showFailed(int statusCode,String message){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'Error',
        desc:"Finished with response code ${statusCode} \n ${message}",
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }
  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 400.0;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea
              ),
            ),
            ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                        'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}'),
                        FlatButton(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            onPressed: (){
                              setState(() {
                                this.controller.resumeCamera();
                              });
                            },
                            child: Text(
                              "Scan again",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            )
                        )
                      ],
                    ),
                  )
                  : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Scan a code'),
                  ),
            ),
          )
        ],
      ),
    );
  }
  void _onQRViewCreated(QRViewController controller) async{
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async{
      this.controller.pauseCamera();
      setState(() {
        result = scanData;
      });
      final response= await Get().getData(context, "http://192.168.43.36:8080/signattendance/${result.code}",widget.token);
      if(response.statusCode == 200){
        this.controller.pauseCamera();
        showSuccess();
      }else if(response.statusCode==403){
        this.controller.pauseCamera();
        showFailed(response.statusCode,"You are not authorized");
      }
      else{
        this.controller.pauseCamera();
        showFailed(response.statusCode,response.body);

      }
    });
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
