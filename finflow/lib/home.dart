import 'package:finflow/color.dart';
import 'package:finflow/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> image = [
    'images/money.svg',
    'images/secure.svg',
    'images/happy.svg'
  ];
  List<String> text = [
    'The best app for finance, banking, & e-wallet today',
    'Manage finances easily with secure payment',
    'Have an amazing experience with FinFlow right now!'
  ];
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: screenwidth,
            height: screenheight,
          ),
          Positioned(
            top: 30,
            child: SizedBox(
              width: screenwidth,
              height: screenheight * .8,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    if (pageController.page != null) {
                      currentPage = pageController.page!.round();
                    }
                  });
                },
                controller: pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  currentPage = index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SvgPicture.asset(
                            image[index],
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            text[index],
                            style: TextStyle(
                                fontFamily: 'Century',
                                color: black,
                                fontSize: 35,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: SizedBox(
              width: screenwidth,
              child: Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: currentPage == 0 ? 27 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: currentPage == 0 ? blue : grey),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: currentPage == 1 ? 27 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: currentPage == 1 ? blue : grey),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: currentPage == 2 ? 27 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: currentPage == 2 ? blue : grey),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (currentPage == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Payment(),
                            ));
                      }
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: darkgrey,
                                blurRadius: 8,
                                offset: Offset(0, 8))
                          ],
                          color: blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(23))),
                      child: Text(
                        currentPage == 2 ? 'Get Started!' : 'Next',
                        style: TextStyle(
                            fontFamily: 'Century',
                            color: black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
