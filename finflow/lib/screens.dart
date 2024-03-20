import 'package:finflow/chat.dart';
import 'package:finflow/color.dart';
import 'package:finflow/mycards.dart';
import 'package:finflow/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

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
          children: const [
            Payment(),
            Mycard(),
          ],
        ),
        floatingActionButton: currentIndex != 0
            ? const SizedBox.shrink()
            : FloatingActionButton(
                backgroundColor: firstSuggestionBoxColor,
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
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              _onBottomNavBarTapped(0);
                            },
                            icon: Icon(
                              Boxicons.bxs_home,
                              size: 27,
                              color: currentIndex == 0 ? blue : black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Boxicons.bx_chart,
                              size: 27,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton.filled(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(lightblue)),
                  onPressed: () {},
                  padding: const EdgeInsets.all(13),
                  icon: const Icon(Boxicons.bx_scan, size: 35),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              _onBottomNavBarTapped(1);
                            },
                            icon: Icon(
                              Boxicons.bx_credit_card,
                              size: 27,
                              color: currentIndex == 1 ? blue : black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
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
