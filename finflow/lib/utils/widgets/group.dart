import 'package:finflow/utils/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Group extends StatefulWidget {
  final String title;
  final String bgimage;
  const Group({super.key, required this.title, required this.bgimage});

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  String kPickedNmber = '';
  String kPickedName = '';
  Map<String, String> members = {};
  PhoneContact? _phoneContact;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight,
            ),
            Positioned(
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                width: screenWidth,
                height: screenHeight * .25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.bgimage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(FontAwesomeIcons.arrowLeft),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(FontAwesomeIcons.gear),
                      )
                    ])),
              ),
            ),
            Positioned(
              top: screenHeight * .25 - 60,
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                border: Border.all(color: black, width: 2.7),
                                color: purple,
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Text(
                            widget.title,
                            style: textTheme.displaySmall!.copyWith(
                                fontSize: 29, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          SizedBox(
                            width: screenWidth * .34,
                            child: TextButton(
                              onPressed: () async {
                                bool permission = await FlutterContactPicker
                                    .requestPermission();
                                if (permission) {
                                  if (await FlutterContactPicker
                                      .hasPermission()) {
                                    _phoneContact = await FlutterContactPicker
                                        .pickPhoneContact();
                                    if (_phoneContact != null) {
                                      if (_phoneContact!.fullName!.isNotEmpty) {
                                        setState(() {
                                          kPickedName = _phoneContact!.fullName!
                                              .toString();
                                        });
                                      }
                                      if (_phoneContact!
                                          .phoneNumber!.number!.isNotEmpty) {
                                        setState(() {
                                          kPickedNmber = _phoneContact!
                                              .phoneNumber!.number
                                              .toString();
                                        });
                                      }
                                      if (kPickedName.isNotEmpty &
                                          kPickedNmber.isNotEmpty) {
                                        if (!members.containsKey(kPickedName)) {
                                          setState(() {
                                            members[kPickedName] = kPickedNmber;
                                            print(members);
                                          });
                                        }
                                      }
                                    }
                                  }
                                }
                              },
                              style: ButtonStyle(
                                  elevation: const MaterialStatePropertyAll(5),
                                  shadowColor: MaterialStatePropertyAll(black),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(vertical: 15)),
                                  backgroundColor:
                                      MaterialStatePropertyAll(grey)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Expanded(
                                      flex: 1,
                                      child: Icon(
                                        FontAwesomeIcons.plus,
                                        size: 15,
                                      )),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Add Members',
                                      style: textTheme.displayMedium!
                                          .copyWith(fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          children: [],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
