import 'dart:math';

import 'package:finflow/color.dart';
import 'package:finflow/seeall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:palette_generator/palette_generator.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Map<String?, String> chats = {};
  Map<IconData, Map<String, Color>> icons = {
    FontAwesomeIcons.bolt: {
      'Electicity': const Color.fromARGB(255, 244, 203, 80)
    },
    Icons.wifi: {'Internet': const Color.fromARGB(255, 248, 144, 7)},
    FontAwesomeIcons.droplet: {'Water': Colors.blue},
    FontAwesomeIcons.wallet: {'Wallet': Colors.purple},
    Icons.medical_services_rounded: {'Assurance': Colors.green},
    FontAwesomeIcons.bagShopping: {'Shopping': Colors.orangeAccent},
    Boxicons.bxs_discount: {'Deals': Colors.pinkAccent},
    FontAwesomeIcons.cartShopping: {'Merchant': Colors.deepPurple},
    FontAwesomeIcons.shieldHeart: {'Health': Colors.lightGreen},
    FontAwesomeIcons.mobile: {'Moblie': Colors.lightBlueAccent},
    FontAwesomeIcons.motorcycle: {'Motor': Colors.brown},
    FontAwesomeIcons.car: {'Car': Colors.blueGrey},
    Boxicons.bxs_tv: {'Television': const Color.fromARGB(255, 33, 61, 243)},
  };
  bool seeall = false;
  Color? iconcolor;
  @override
  void initState() {
    super.initState();
    _extractImageColor();
  }

  Future<void> _extractImageColor() async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            const AssetImage('images/Card.jpg'));
    Color? mainColor = paletteGenerator.dominantColor?.color;
    setState(() {
      if (mainColor != null) {
        iconcolor = mainColor;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: screenwidth,
        height: screenheight,
        child: Padding(
          padding: const EdgeInsets.only(left: 11, right: 11, top: 20),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                child: Icon(
                                  LineAwesomeIcons.user,
                                  size: 25,
                                ),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Good Morning',
                                      style: TextStyle(
                                          fontFamily: 'Century',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Andrew Anuewwww',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontFamily: 'Century',
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 248, 236, 236),
                            child: IconButton(
                              color: black,
                              icon: const Icon(LineAwesomeIcons.bell),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: screenheight * .35,
                    width: screenwidth - 30,
                    child: Card(
                      shadowColor: lightblue,
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/Card.jpg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 13),
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Andrew Ane',
                                            style: TextStyle(
                                                color: white,
                                                fontFamily: 'CEntury',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text.rich(TextSpan(children: [
                                            TextSpan(
                                              text: '.... .... .... ',
                                              style: TextStyle(
                                                  color: white,
                                                  height: .75,
                                                  fontFamily: 'CEntury',
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            TextSpan(
                                              text: '2132',
                                              style: TextStyle(
                                                  color: white,
                                                  fontFamily: 'CEntury',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ]))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Image.asset('images/visa.png'))
                                  ],
                                ),
                                const SizedBox(height: 35),
                                Row(
                                  children: [
                                    Text(
                                      'Your Balance',
                                      style: TextStyle(
                                          color: white,
                                          fontFamily: 'CEntury',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Boxicons.bxs_lock_open,
                                      color: white,
                                    )
                                  ],
                                ),
                                Text(
                                  '\$845.00',
                                  style: TextStyle(
                                      color: white,
                                      height: 1.3,
                                      fontFamily: 'CEntury',
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, left: 8, right: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: blue,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(13.5),
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Color(
                                                                      0xFFBBCCF4)),
                                                          child: Icon(
                                                            Boxicons
                                                                .bxs_paper_plane,
                                                            size: 25,
                                                            color: iconcolor,
                                                          )),
                                                      Text(
                                                        'Transfer',
                                                        style: TextStyle(
                                                            color: white,
                                                            fontFamily:
                                                                'Cera Pro',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(13.5),
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Color(
                                                                      0xFFBBCCF4)),
                                                          child: Icon(
                                                            FontAwesomeIcons
                                                                .handHoldingDollar,
                                                            size: 25,
                                                            color: iconcolor,
                                                          )),
                                                      Text(
                                                        'Request',
                                                        style: TextStyle(
                                                            color: white,
                                                            fontFamily:
                                                                'Cera Pro',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(13.5),
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xFFBBCCF4)),
                                                        child: Transform.rotate(
                                                            angle:
                                                                90 * pi / 180,
                                                            child: Icon(
                                                              FontAwesomeIcons
                                                                  .arrowRightArrowLeft,
                                                              size: 25,
                                                              color: iconcolor,
                                                            )),
                                                      ),
                                                      Text(
                                                        'In and Out',
                                                        style: TextStyle(
                                                            color: white,
                                                            fontFamily:
                                                                'CEra Pro',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Services',
                                  style: TextStyle(
                                      fontFamily: 'Century',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const SeeAll(),
                                        ));
                                  },
                                  child: Text(
                                    'See all',
                                    style: TextStyle(
                                        fontFamily: 'Century',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: lightblue),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: AnimationLimiter(
                                child: GridView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: icons.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 1.5,
                                    mainAxisExtent: 100,
                                    crossAxisCount: 4,
                                  ),
                                  itemBuilder: (context, index) {
                                    IconData icon = icons.keys.elementAt(index);
                                    String label = icons[icon]!.keys.first;
                                    Color color = icons[icon]!.values.first;

                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: ScaleAnimation(
                                        curve: Easing.standardDecelerate,
                                        child: Column(
                                          children: [
                                            Material(
                                              elevation: 8,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(17),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderColor),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(50),
                                                  ),
                                                  color: color.withOpacity(.15),
                                                ),
                                                child: Icon(
                                                  icon,
                                                  color: color,
                                                  size: 26,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              label,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Cera Pro',
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.8),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
