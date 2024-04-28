import 'dart:ffi';
import 'dart:math';

import 'package:finflow/pages/home/splitgroup/chips.dart';
import 'package:finflow/pages/home/splitgroup/pay.dart';
import 'package:finflow/screens.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/utils/firebase/controllers/Add_controller.dart';
import 'package:finflow/utils/firebase/controllers/fetch_controller.dart';
import 'package:finflow/utils/firebase/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  List<String> filters = ['History', 'Stats', 'Balances', 'Total'];
  String kPickedNmber = '';
  String kPickedName = '';
  Map<String, Map<String, double>> dues = {};
  Map<String, String> members = {};
  Map<String, Map<String, Color>> memberscolor = {};
  PhoneContact? _phoneContact;
  late List<String> selectedFilter;
  late PageController pageController;
  late String groupStarter; // To store the first member who started the group
  Map<String, Map<String, String>> transactionHistory = {};

  @override
  void initState() {
    super.initState();
    selectedFilter = [];
    add();
    pageController = PageController(initialPage: 0);
    storeMemberNamesWithColors();
    groupStarter = "";
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void add() async {
    transactionHistory.addAll(
        await getHistory(widget.docname) as Map<String, Map<String, String>>);
    dues.addAll(
        await getDues(widget.docname) as Map<String, Map<String, double>>);
  }

  final fetchController = FetchController.instance;
  final addController = Get.put(AddController());

  Map<String, Map<String, String>> memberPayOrOwes = {};

  Future<Map<String, Map<String, String>>?> getHistory(String docname) async {
    final Map<String, Map<String, String>> history = {};
    try {
      UserModal3 groupDetails = await fetchController.getGroupdetail(docname);
      groupStarter = groupDetails.member.keys.first;
      groupDetails.transactions.forEach((date, transaction) {
        // Initialize an empty map to store transaction details
        final transactionMap = <String, String>{};
        // Iterate through the transaction details and add them to the map
        transaction.forEach((member, amount) {
          transactionMap[member] = amount.toString();
        });
        // Add the transaction map to the history using the date as key
        history[date] = transactionMap;
      });
      return history;
    } catch (e) {
      print("Error getting transaction history: $e");
      return null;
    }
  }

  Future<Map<String, Map<String, double>>?> getDues(String docname) async {
    final Map<String, Map<String, double>> history = {};
    try {
      UserModal3 groupDetails = await fetchController.getGroupdetail(docname);
      groupDetails.dues.forEach((index, data) {
        // Cast 'data' to Map<String, double> before assigning
        history[index] = data.cast<String, double>();
      });
      return history;
    } catch (e) {
      print("Error getting dues data: $e");
      return null;
    }
  }

  void storeMemberNamesWithColors() async {
    try {
      UserModal3 groupDetails =
          await fetchController.getGroupdetail(widget.docname);
      final memberMap = groupDetails.member as Map<String, dynamic>;
      final memberList = memberMap.keys.toList();
      final membernoList = memberMap.values.toList();

      for (int index = 0; index < memberList.length; index++) {
        final usedColors = <Color>{};

        Color randomColor;
        do {
          int red = Random().nextInt(156) +
              100; // Limiting red component to 100-255 range
          int green = Random().nextInt(156) +
              100; // Limiting green component to 100-255 range
          int blue = Random().nextInt(156) +
              100; // Limiting blue component to 100-255 range
          randomColor = Color.fromARGB(255, red, green, blue);
        } while (usedColors.contains(randomColor));

        usedColors.add(randomColor);
        final data = {memberList[index].toString(): randomColor};
        if (!memberscolor.containsKey(memberList[index])) {
          memberscolor[membernoList[index]] = data;
        }
      }
      setState(() {});
    } catch (e) {
      print("Error storing member names with colors: $e");
    }
  }

  Future<Map<String, double>> splitAmount(
      double amount, List<String> members) async {
    final numMembers = members.length;
    final baseAmount = amount / numMembers;

    // Map to store phone:amount
    final Map<String, double> splitMap = {};

    // Iterate through members
    for (final member in members) {
      final paidAmount =
          await getMemberPayment(member); // Wait for the payment amount
      double difference = 0.0;

      if (paidAmount <= baseAmount) {
        difference = baseAmount - paidAmount;
      } else {
        difference = baseAmount - paidAmount;
        // Redistribute the excess amount among all members
        double excessSplitAmount = difference / numMembers;
        for (final m in members) {
          if (m != member) {
            splitMap[m] = (splitMap[m] ?? 0) + excessSplitAmount;
          }
        }
      }
      splitMap[member] = difference;
    }
    return splitMap;
  }

// Replace this with your actual logic to get member payment
  Future<double> getMemberPayment(String member) async {
    double amount = 0.0;
    try {
      UserModal3 groupDetails =
          await fetchController.getGroupdetail(widget.docname);
      groupStarter = groupDetails.member.keys.first;
      groupDetails.transactions.forEach((date, membersMap) {
        if (membersMap.keys.contains(member)) {
          amount = double.parse(membersMap[member].toString());
          print("$amount:$member");
        }
      });
      return amount; // Move the return statement outside the forEach loop
    } catch (e) {
      print("Error getting transaction history: $e");
      return amount;
    }
  }

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
              bottom: 10,
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
                              firstselected: true,
                              filters: filters,
                              onFiltersChanged: (p0) {
                                selectedFilter = p0;
                                pageController.animateToPage(
                                  filters.indexOf(selectedFilter.first),
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              },
                            ),
                            Divider(
                              color: grey,
                            ),
                            Expanded(
                              child: PageView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: pageController,
                                children: [
                                  // History Page
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Group stared by $groupStarter",
                                          style: textTheme.displayMedium!
                                              .copyWith(fontSize: 20),
                                        ),
                                        Expanded(
                                            child: transactionHistory.isNotEmpty
                                                ? ListView.builder(
                                                    itemCount:
                                                        transactionHistory
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final date =
                                                          transactionHistory
                                                              .keys
                                                              .elementAt(index);
                                                      return transactionHistory[
                                                                  date]!
                                                              .isNotEmpty
                                                          ? Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(transactionHistory[date]!.keys.first.replaceAll('+91', '').replaceAll(' ',
                                                                                '') ==
                                                                            Screens.phonenumber.replaceAll('+91', '').replaceAll(' ',
                                                                                '')
                                                                        ? 'You'
                                                                        : memberscolor[transactionHistory[date]!.keys.first.replaceAll('+91', '').replaceAll(' ',
                                                                                '')]!
                                                                            .keys
                                                                            .first),
                                                                    const SizedBox(
                                                                      width: 6,
                                                                    ),
                                                                    Text(transactionHistory[
                                                                            date]!
                                                                        .values
                                                                        .first),
                                                                    const SizedBox(
                                                                      width: 6,
                                                                    ),
                                                                  ],
                                                                ),
                                                                ListView
                                                                    .builder(
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {},
                                                                )
                                                              ],
                                                            )
                                                          : const SizedBox
                                                              .shrink();
                                                    },
                                                  )
                                                : const SizedBox.shrink())
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: purple,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () async {
                                  Navigator.push(
                                          context,
                                          ModalBottomSheetRoute(
                                              builder: (context) {
                                                double height =
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.4;
                                                return SizedBox(
                                                  height: height,
                                                  child: Pay(
                                                    transactionHistory:
                                                        transactionHistory,
                                                    docid: widget.docname,
                                                    phno: Screens.phonenumber,
                                                  ),
                                                );
                                              },
                                              showDragHandle: true,
                                              isScrollControlled: true))
                                      .then((value) async {
                                    // Check if value is not null and contains necessary data
                                    if (value != null &&
                                        value is Map<String,
                                            Map<String, String>>) {
                                      final memberno =
                                          memberscolor.keys.toList();
                                      setState(() {
                                        transactionHistory.addAll(value);
                                      });
                                      final date = transactionHistory.keys.last;
                                      final index = dues.isNotEmpty
                                          ? int.parse(dues.keys.last)
                                          : 0;
                                      dues.addAll({
                                        "${index + 1}": await splitAmount(
                                            double.parse(
                                                transactionHistory[date]!
                                                    .values
                                                    .first),
                                            memberno)
                                      });
                                      await addController.addGroupDues(
                                          widget.docname, dues);
                                    }
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
                      style: textTheme.displayMedium!
                          .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: memberscolor.length,
                        itemBuilder: (context, index) {
                          final memberno = memberscolor.keys.elementAt(index);
                          final memberName = memberscolor[memberno]!.keys.first;
                          final color = memberscolor[memberno]!.values.first;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: color,
                                  radius: 5,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  memberno
                                              .replaceAll('+91', '')
                                              .replaceAll(' ', '') ==
                                          Screens.phonenumber
                                              .replaceAll('+91', '')
                                              .replaceAll(' ', '')
                                      ? "You"
                                      : memberName,
                                  style: textTheme.displaySmall!
                                      .copyWith(fontSize: 15),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
