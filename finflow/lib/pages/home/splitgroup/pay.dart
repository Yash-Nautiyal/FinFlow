import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/utils/firebase/controllers/Add_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Pay extends StatefulWidget {
  final String phno;
  final String docid;
  final Map<String, Map<String, String>> transactionHistory;

  const Pay(
      {super.key,
      required this.phno,
      required this.docid,
      required this.transactionHistory});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  String amount = ""; // Initialize here
  final add = Get.put(AddController());

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  amount = value;
                },
                onSubmitted: (value) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                style: textTheme.displaySmall!
                    .copyWith(fontSize: 25, color: white),
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  hintStyle: textTheme.displaySmall!.copyWith(fontSize: 17),
                  filled: true,
                  suffix: const Icon(FontAwesomeIcons.circleXmark),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(19)),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(DateTime.now());
                    final Map<String, Map<String, String>> data =
                        widget.transactionHistory;
                    data.addAll({
                      formattedDateTime: {
                        widget.phno.replaceAll('+91', '').replaceAll(' ', ''):
                            amount.toString()
                      }
                    });
                    await add.makeGroupTransaction(widget.docid, data);
                    Navigator.pop(context, {
                      formattedDateTime: {widget.phno: amount}
                    });
                  },
                  child: Text(
                    "Pay",
                    style: textTheme.displayMedium!.copyWith(
                        color: black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
