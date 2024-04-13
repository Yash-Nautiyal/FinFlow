import 'dart:math';

import 'package:finflow/pages/home/splitgroup/chips.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/utils/firebase/controllers/fetch_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Group extends StatefulWidget {
  final String title;
  final String bgimage;
  final String docname;
  const Group(
      {super.key,
      required this.title,
      required this.bgimage,
      required this.docname});

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  String kPickedNmber = '';
  String kPickedName = '';
  Map<String, String> members = {};
  PhoneContact? _phoneContact;
  late List<String> selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = [];
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final fetch = Get.put(FetchController());
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                width: screenWidth,
                height: screenHeight * .25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.bgimage),
                      fit: BoxFit.cover,
                      opacity: .6),
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
                                image: DecorationImage(
                                    image: AssetImage(widget.bgimage),
                                    fit: BoxFit.cover),
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
                          children: [
                            ListOfChips(
                              onFiltersChanged: (p0) {
                                selectedFilter = p0;
                              },
                            ),
                            Divider(
                              color: grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: screenHeight * .35 - 65,
                bottom: screenHeight * .56,
                left: screenWidth * .65,
                right: 0,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Members:',
                        style: textTheme.displayMedium!.copyWith(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: fetch.getGroupdetail(widget.docname),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                final memberMap = snapshot.data!.member
                                    as Map<String, dynamic>;
                                final memberList = memberMap.keys.toList();
                                return ListView.builder(
                                  itemCount: memberList.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 4,
                                          backgroundColor:
                                              niceColors[Random().nextInt(19)],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          memberList[index],
                                          style: textTheme.displaySmall!
                                              .copyWith(fontSize: 16),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text("${snapshot.error}"),
                                );
                              } else {
                                return SizedBox();
                              }
                            } else {
                              return SpinKitDoubleBounce(
                                color: purple,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
