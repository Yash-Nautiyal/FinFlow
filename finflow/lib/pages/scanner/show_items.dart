import 'package:finflow/services/ocr_service.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShowItems extends StatefulWidget {
  final Map<String, dynamic> data;
  const ShowItems({super.key, required this.data});

  @override
  State<ShowItems> createState() => _ShowItemsState();
}

class _ShowItemsState extends State<ShowItems> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0).copyWith(top: 25),
          child: Column(
            children: [
              Text(
                'Scanned Information',
                style: textTheme.displayMedium!.copyWith(fontSize: 22),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    'Merchant Name: ',
                    style: textTheme.displaySmall!.copyWith(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.data['ocr_data']['Merchant_Name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.displaySmall!
                        .copyWith(fontSize: 18, color: white),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Text(
                    'Date: ',
                    style: textTheme.displaySmall!.copyWith(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.data['ocr_data']['Date'].toString() == "null"
                        ? 'N/A'
                        : widget.data['ocr_data']['Date'].toString(),
                    style: textTheme.displaySmall!
                        .copyWith(fontSize: 18, color: white),
                  ),
                  const Spacer(),
                  Text(
                    'Time: ',
                    style: textTheme.displaySmall!.copyWith(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.data['ocr_data']['Time'].toString() == "null"
                        ? 'N/A'
                        : widget.data['ocr_data']['Time'].toString(),
                    style: textTheme.displaySmall!
                        .copyWith(fontSize: 18, color: white),
                  ),
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Text(
                    'Items: ',
                    style: textTheme.displaySmall!.copyWith(fontSize: 15),
                  ),
                  const Spacer(),
                  Text(
                    'Total: ',
                    style: textTheme.displaySmall!.copyWith(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: widget.data['ocr_data']['Currency'].toString() ==
                                "null"
                            ? ''
                            : widget.data['ocr_data']['Currency'].toString(),
                        style: textTheme.displaySmall!
                            .copyWith(fontSize: 18, color: Colors.redAccent)),
                    TextSpan(
                        text: "${widget.data['ocr_data']['Total']}",
                        style: textTheme.displaySmall!
                            .copyWith(fontSize: 18, color: Colors.redAccent))
                  ]))
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              Divider(
                color: grey,
              ),
              Divider(
                color: grey,
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: [
                  Text(
                    'Tax: ',
                    style: textTheme.displaySmall!.copyWith(fontSize: 15),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.data['ocr_data']['Tax'].toString(),
                    style: textTheme.displaySmall!
                        .copyWith(fontSize: 18, color: white),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: textTheme.displaySmall!.copyWith(fontSize: 18),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(purple),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await OCRService.sendDataToPythonAPI(widget.data);
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                    },
                    child: loading
                        ? SpinKitCircle(
                            color: black,
                          )
                        : Text(
                            'Save',
                            style:
                                textTheme.displaySmall!.copyWith(fontSize: 18),
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
