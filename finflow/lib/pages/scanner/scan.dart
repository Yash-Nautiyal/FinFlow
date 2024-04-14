import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:finflow/services/ocr_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;
  File? selectedImage;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  _launchURL(String? link) async {
    if (link != null) {
      Uri url = Uri.parse(link);
      if (await launchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  bool scanQr = true;
  bool scanReceipts = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            scanQr
                ? buildQrView(context)
                : Positioned(
                    top: 70,
                    bottom: 120,
                    left: 20,
                    right: 20,
                    child: scanReceipt(textTheme),
                  ),
            Positioned(
              top: 10,
              left: 0,
              child: IconButton(
                icon: Icon(FontAwesomeIcons.arrowLeft),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
              bottom: 20,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: buildResult(),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  switchOptions(context, textTheme)
                ],
              ),
            ),
            Positioned(
              top: 10,
              child: buildControlButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget scanReceipt(TextTheme textTheme) {
    return DottedBorder(
      dashPattern: const [5, 5],
      borderType: BorderType.RRect,
      radius: const Radius.circular(15),
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: selectedImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          iconColor: MaterialStateProperty.all(Colors.purple),
                        ),
                        onPressed: () {
                          _pickImageFromGallery();
                        },
                        child: Row(
                          children: [
                            Text(
                              'Media',
                              style: textTheme.displaySmall!
                                  .copyWith(fontSize: 20),
                            ),
                            const Icon(FontAwesomeIcons.folder)
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          iconColor: MaterialStateProperty.all(Colors.purple),
                        ),
                        onPressed: () {
                          _pickImageFromCamera();
                        },
                        child: Row(
                          children: [
                            Text(
                              'Camera',
                              style: textTheme.displaySmall!
                                  .copyWith(fontSize: 20),
                            ),
                            const Icon(FontAwesomeIcons.camera)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
            : Image.file(
                selectedImage!,
                fit: BoxFit.contain,
              ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  Future _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
      // Call OCRService to perform OCR on the selected image
      /* final ocrData = await OCRService.performOCR(selectedImage!);
      if (ocrData != null) {
        // Handle OCR response here
        print('OCR Data: $ocrData');
      } else {
        // Handle case when OCR service returns null (error occurred)
        print('OCR Service returned null');
      } */
    }
  }

  SizedBox switchOptions(BuildContext context, TextTheme textTheme) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 40,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    scanReceipts = false;
                    scanQr = true;
                  });
                },
                child: SizedBox(
                  child: Text(
                    'Scan QR',
                    style: textTheme.displayMedium!.copyWith(
                        color: scanQr ? Colors.purple : null,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 2,
            color: Colors.white.withOpacity(.5),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    scanReceipts = true;
                    scanQr = false;
                  });
                },
                child: SizedBox(
                  child: Text(
                    'Scan Receipts',
                    style: textTheme.displayMedium!.copyWith(
                        color: scanReceipts ? Colors.purple : null,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildControlButtons() => scanReceipts
      ? SizedBox.shrink()
      : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                icon: FutureBuilder(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return snapshot.data!
                          ? Icon(Icons.flash_on_rounded, color: Colors.purple)
                          : const Icon(Icons.flash_off_rounded);
                    } else {
                      return Container();
                    }
                  },
                )),
            IconButton(
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return const Icon(Icons.flip_camera_android);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        );

  Widget buildResult() => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(8)),
        child: scanReceipts
            ? TextButton(
                onPressed: () async {
                  if (selectedImage != null) {
                    
                    final combinedData =
                        await OCRService.processReceipt(selectedImage as File);
                    if (combinedData != null) {
                      await OCRService.sendDataToPythonAPI(combinedData);
                    }

                    /* final ocrData = await OCRService.performOCR(
                        selectedImage!.path as File);
                    if (ocrData != null) {
                      print(ocrData);
                      // Handle OCR data, e.g., navigate to the next screen with OCR data
                      // Navigator.push(
                      //context,
                      ///MaterialPageRoute(builder: (context) => NextScreen(ocrData: ocrData)),
                      //);
                    } else {
                      // Handle case when OCR service returns null (error occurred)
                      print('OCR Service returned null');
                    } */
                  } else {
                    // Handle case when no image is selected
                    print('No image selected');
                  }
                },
                child: Text('Next'),
              )
            : Text(
                barcode != null ? "Result: ${barcode!.code}" : "Scan a code!",
                maxLines: 2,
              ),
      );

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.purple,
            borderWidth: 10,
            borderLength: 20,
            borderRadius: 10,
            cutOutSize: MediaQuery.of(context).size.width * .8),
      );

  void onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
    });
  }
}
