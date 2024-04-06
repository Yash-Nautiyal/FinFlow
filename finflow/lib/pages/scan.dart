import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;
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
  bool scanRecipts = false;
  File? selectedImage;
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
                    child: scanRecipt(textTheme)),
            Positioned(
                top: 10,
                left: 0,
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.arrowLeft),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
            Positioned(
                bottom: 20,
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          _launchURL(barcode!.code);
                        },
                        child: buildResult()),
                    const SizedBox(
                      height: 9,
                    ),
                    switchoptions(context, textTheme)
                  ],
                )),
            Positioned(top: 10, child: buildcontrolbuttons()),
          ],
        ),
      ),
    );
  }

  Widget scanRecipt(TextTheme textTheme) {
    return DottedBorder(
      dashPattern: const [5, 5],
      borderType: BorderType.RRect,
      radius: const Radius.circular(15),
      color: white,
      child: Container(
        decoration: BoxDecoration(
            color: green, borderRadius: BorderRadius.circular(15)),
        child: selectedImage == null
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          iconColor: MaterialStatePropertyAll(purple),
                        ),
                        onPressed: () {
                          _pickimagefromgallery();
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
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        iconColor: MaterialStatePropertyAll(purple),
                      ),
                      onPressed: () {
                        _pickimagefromcamera();
                      },
                      child: Row(
                        children: [
                          Text(
                            'Camera',
                            style:
                                textTheme.displaySmall!.copyWith(fontSize: 20),
                          ),
                          const Icon(FontAwesomeIcons.camera)
                        ],
                      ),
                    )
                  ],
                ),
              ])
            : Image.file(selectedImage!),
      ),
    );
  }

  Future _pickimagefromgallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  Future _pickimagefromcamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selectedImage = File(returnedImage!.path);
    });
  }

  SizedBox switchoptions(BuildContext context, TextTheme textTheme) {
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
                    scanRecipts = false;
                    scanQr = true;
                  });
                },
                child: SizedBox(
                  child: Text(
                    'Scan QR',
                    style: textTheme.displayMedium!.copyWith(
                        color: scanQr ? purple : null,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 2,
            color: white.withOpacity(.5),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    scanRecipts = true;
                    scanQr = false;
                  });
                },
                child: SizedBox(
                  child: Text(
                    'Scan Recipts',
                    style: textTheme.displayMedium!.copyWith(
                        color: scanRecipts ? purple : null,
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

  Widget buildcontrolbuttons() => Row(
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
                        ? Icon(
                            Icons.flash_on_rounded,
                            color: purple,
                          )
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
              )),
        ],
      );
  Widget buildResult() => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white24, borderRadius: BorderRadius.circular(8)),
        child: Text(
          barcode != null ? "Result: ${barcode!.code}" : "Scan a code!",
          maxLines: 2,
        ),
      );
  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: purple,
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
