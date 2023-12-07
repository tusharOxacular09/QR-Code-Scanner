import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner_for_web_and_mobile_apps/HomePage.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

const bgColor = Color(0xfffafafa);
// QR Code Value : zeoytawvtn

class MyQrCode extends StatefulWidget {
  const MyQrCode({super.key});

  @override
  State<MyQrCode> createState() => _QRScannerState();
}

class _QRScannerState extends State<MyQrCode> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  var barCodeKey = "";
  bool showSuccessAlert = false;
  bool showFailureAlert = false;

  MobileScannerController controller = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                controller.toggleTorch();
              },
              icon: Icon(
                Icons.flash_on,
                color: isFlashOn ? Colors.blue : Colors.grey,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isFrontCamera = !isFrontCamera;
                });
                controller.switchCamera();
              },
              icon: Icon(
                Icons.camera_front,
                color: isFrontCamera ? Colors.blue : Colors.grey,
              ))
        ],
        centerTitle: true,
        title: const Text(
          "QR Scaner",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Place the QR code in the area",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Scanning will be started automatically",
                      style: TextStyle(color: Colors.black54, fontSize: 14))
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      // fit: BoxFit.contain,
                      controller: controller,
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        for (final barcode in barcodes) {
                          // debugPrint('Barcode found! ${barcode.rawValue}');
                          if (barcode.rawValue == "zeoytawvtn" &&
                              !showSuccessAlert) {
                            setState(() {
                              showSuccessAlert = true;
                            });
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green, // Icon color
                                      size: 40.0, // Icon size
                                    ),
                                    Text('Registration Successful'),
                                  ],
                                ),
                                content: const Text(
                                  'You have successfully registered for our service.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                                actions: <Widget>[
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()),
                                        );
                                      },
                                      child: Text("Move"),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(Colors
                                                .blue), // Background color
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.only(
                                                left: 24,
                                                right: 24,
                                                top: 10,
                                                bottom: 10)), // Button padding
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8.0), // Border radius
                                        )),
                                        textStyle:
                                            MaterialStateProperty.all(TextStyle(
                                          color: Colors.white, // Text color
                                          fontSize: 16.0, // Text size
                                          fontWeight:
                                              FontWeight.bold, // Text style
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                            // Stop Scanning After Successfl Scanning
                            controller.stop();
                          } else {
                            if (!showFailureAlert) {
                              setState(() {
                                showFailureAlert = true;
                              });
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.warning,
                                        color: Colors.orange,
                                        size: 40.0,
                                      ),
                                      const Text('Registration Failed'),
                                    ],
                                  ),
                                  content: const Text(
                                    'Incorrect Id found please try again.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  actions: <Widget>[
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () => {
                                          Navigator.pop(context),
                                          setState(() {
                                            showFailureAlert = !showFailureAlert;
                                          }),
                                        },
                                        child: const Text('Try Again'),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(Colors
                                                  .blue), // Background color
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.only(
                                                  left: 24,
                                                  right: 24,
                                                  top: 10,
                                                  bottom:
                                                      10)), // Button padding
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Border radius
                                          )),
                                          textStyle: MaterialStateProperty.all(
                                              TextStyle(
                                            color: Colors.white, // Text color
                                            fontSize: 14.0, // Text size
                                            fontWeight:
                                                FontWeight.bold, // Text style
                                          )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                          }
                        }
                      },
                    ),
                    QRScannerOverlay(
                        overlayColor: bgColor, borderColor: Colors.blue)
                  ],
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Powered by Technocract",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  letterSpacing: 1,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
