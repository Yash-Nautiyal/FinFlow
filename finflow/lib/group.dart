import 'package:finflow/chips.dart';
import 'package:finflow/colors.dart';
import 'package:flutter/material.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              child: CircleAvatar(
                                radius: 40,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                  child: Icon(Icons.camera_alt)),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: screenWidth * .45,
                        child: TextButton(
                          onPressed: () {},
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
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: [],
                    ),
                    Divider(
                      color: grey,
                    )
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
