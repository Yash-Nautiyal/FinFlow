import 'package:finflow/utils/widgets/chips.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ken_burns_slideshow/ken_burns_slideshow.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController textEditingController = TextEditingController();

  late List<String> selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = [];
  }

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
              top: 17,
              child: Container(
                width: screenWidth,
                height: screenHeight * .2,
                child: KenBurnsSlideshow.asset(
                  background: Colors.transparent,
                  foreground: Colors.transparent,
                  animationSequence: [
                    KenBurnsAnimation.leftToRight,
                    KenBurnsAnimation.rightToLeft
                  ],
                  images: const [
                    'images/poly/poly1.png',
                    'images/poly/poly2.png',
                    'images/poly/poly3.png',
                    'images/poly/poly4.png',
                    'images/poly/poly5.png',
                    'images/poly/poly6.png',
                    'images/poly/poly7.png',
                    'images/poly/poly8.png',
                    'images/poly/poly9.png',
                    'images/poly/poly10.jpg',
                  ],
                ),
              ),
            ),
            Positioned(
              top: screenHeight * .1,
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Add New Group",
                        style: textTheme.displayMedium!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 42,
                              backgroundColor: black,
                              child: const CircleAvatar(
                                radius: 40,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                  child: const Icon(Icons.camera_alt)),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: TextField(
                              controller: textEditingController,
                              onChanged: (value) {
                                setState(() {});
                              },
                              onSubmitted: (value) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              onEditingComplete: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              onTap: () {},
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              style: textTheme.displaySmall!
                                  .copyWith(fontSize: 17, color: white),
                              decoration: InputDecoration(
                                suffixIconColor: white,
                                hintText: 'Enter Group Name',
                                hintStyle: textTheme.displaySmall!.copyWith(
                                    color: Colors.white54, fontSize: 17),
                                filled: true,
                                fillColor: grey,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(13),
                                    right: Radius.circular(13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListOfChips(
                      onFiltersChanged: (filters) {
                        selectedFilter = filters;
                      },
                    ),
                    SizedBox(
                      width: screenWidth * .45,
                      child: TextButton(
                        onPressed: () async {
                          bool permission =
                              await FlutterContactPicker.requestPermission();
                          if (permission) {
                            if (await FlutterContactPicker.hasPermission()) {
                              _phoneContact =
                                  await FlutterContactPicker.pickPhoneContact();
                              if (_phoneContact != null) {
                                if (_phoneContact!.fullName!.isNotEmpty) {
                                  setState(() {
                                    kPickedName =
                                        _phoneContact!.fullName!.toString();
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
                            elevation: const MaterialStatePropertyAll(10),
                            shadowColor: MaterialStatePropertyAll(black),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(vertical: 15)),
                            backgroundColor: MaterialStatePropertyAll(grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                                flex: 1, child: Icon(FontAwesomeIcons.plus)),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Add Members',
                                style: textTheme.displayMedium!
                                    .copyWith(fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: grey,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: screenWidth * .53,
                        child: ListView.builder(
                          itemCount: members.length,
                          itemBuilder: (context, index) {
                            String memberName = members.keys.elementAt(index);
                            String memberNumber =
                                members.values.elementAt(index);
                            members.values.elementAt(index);
                            return SizedBox(
                                width: 300,
                                height: 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            memberName,
                                            overflow: TextOverflow.ellipsis,
                                            style: textTheme.displaySmall!
                                                .copyWith(
                                                    fontSize: 15,
                                                    color: purple),
                                          ),
                                          Text(
                                            memberNumber,
                                            style: textTheme.displaySmall!
                                                .copyWith(fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            members.remove(memberName);
                                          });
                                        },
                                        child: const Icon(Icons.close_rounded))
                                  ],
                                ));
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: purple,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          child: Text('Save',
                              style: textTheme.displayMedium!.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w700)),
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
