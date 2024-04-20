import 'package:finflow/pages/chat/chat.dart';
import 'package:finflow/pages/home/home.dart';
import 'package:finflow/pages/home/widgets/name_image.dart';
import 'package:finflow/pages/profile/profile.dart';
import 'package:finflow/pages/scanner/scan.dart';
import 'package:finflow/pages/stats/stats_screen.dart';
import 'package:finflow/pages/transfer/transfer.dart';
import 'package:finflow/utils/firebase/shared_preference.dart';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});
  static String Name = "";
  static String email = "";
  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  Map<String?, String> chats = {};
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    fetchDetails();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onBottomNavBarTapped(int index) {
    setState(() {
      currentIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void fetchDetails() async {
    final name = await retrieveData("Name");
    final email = await retrieveData("Email");
    Screens.email = email.toString();
    Screens.Name = name.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: [
            const Home(),
            const Transfer(),
            const Statistics(),
            Profile(email: Screens.email)
          ],
        ),
        floatingActionButton: currentIndex != 0
            ? const SizedBox.shrink()
            : FloatingActionButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    ModalBottomSheetRoute(
                      builder: (context) =>
                          Chat(chats: chats), // Pass the 'chats' map
                      isScrollControlled: true,
                      showDragHandle: true,
                    ),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        chats = value as Map<String?,
                            String>; // Update 'chats' in Payment screen
                      });
                    }
                  });
                },
                child: const Icon(Boxicons.bxs_microphone),
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        color: Colors.blueGrey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton.outlined(
                            style: const ButtonStyle(
                                side: MaterialStatePropertyAll(
                                    BorderSide(style: BorderStyle.none))),
                            onPressed: () {
                              _onBottomNavBarTapped(0);
                            },
                            icon: const Icon(
                              Boxicons.bx_home,
                              size: 27,
                            ),
                          ),
                          IconButton.outlined(
                            style: const ButtonStyle(
                                side: MaterialStatePropertyAll(
                                    BorderSide(style: BorderStyle.none))),
                            onPressed: () {
                              _onBottomNavBarTapped(1);
                            },
                            icon: const Icon(
                              Boxicons.bxl_telegram,
                              size: 27,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      elevation: 10,
                      shape: const CircleBorder(),
                      child: IconButton.filled(
                        autofocus: true,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Scan(),
                              ));
                        },
                        padding: const EdgeInsets.all(13.5),
                        icon: const Icon(Boxicons.bx_scan, size: 40),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        color: Colors.blueGrey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton.outlined(
                            style: const ButtonStyle(
                                side: MaterialStatePropertyAll(
                                    BorderSide(style: BorderStyle.none))),
                            onPressed: () {
                              _onBottomNavBarTapped(2);
                            },
                            icon: const Icon(
                              Boxicons.bx_chart,
                              size: 27,
                            ),
                          ),
                          IconButton.outlined(
                            style: const ButtonStyle(
                                side: MaterialStatePropertyAll(
                                    BorderSide(style: BorderStyle.none))),
                            onPressed: () {
                              _onBottomNavBarTapped(3);
                            },
                            icon: const Icon(
                              Boxicons.bx_user,
                              size: 27,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
