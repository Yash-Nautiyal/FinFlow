import 'package:finflow/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class Mycard extends StatefulWidget {
  const Mycard({super.key});

  @override
  State<Mycard> createState() => _MycardState();
}

class _MycardState extends State<Mycard> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'My Cards',
            style: TextStyle(fontFamily: 'Century', fontSize: 20),
          ),
        ),
        body: SizedBox(
          width: screenwidth,
          height: screenheight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(children: [
              Expanded(
                child: SizedBox(
                  width: screenwidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'M-Card',
                                      style: TextStyle(
                                          fontFamily: 'Cera Pro',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: 4,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: blue,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(17),
                                            )),
                                        child: const Text(
                                          'Active',
                                          style: TextStyle(
                                              fontFamily: 'Century',
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: grey,
                                      ),
                                      child: const Icon(
                                          Boxicons.bx_dots_horizontal_rounded),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Card(
                          shadowColor: lightblue,
                          elevation: 10,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(19)),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/Card.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(19)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 13),
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'M-Card',
                                            style: TextStyle(
                                                fontFamily: 'Cera Pro',
                                                color: white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child:
                                                Image.asset('images/visa.png'))
                                      ],
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                        text: '.... .... .... ',
                                        style: TextStyle(
                                            color: white,
                                            height: .75,
                                            fontFamily: 'Cera Pro',
                                            fontSize: 55,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      TextSpan(
                                        text: '2132',
                                        style: TextStyle(
                                            color: white,
                                            fontFamily: 'Century',
                                            fontSize: 27,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ])),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Card Holder Name',
                                              style: TextStyle(
                                                  color: white,
                                                  fontFamily: 'CEntury',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Andrew Aue',
                                              style: TextStyle(
                                                  color: white,
                                                  fontFamily: 'CEntury',
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Expire Date',
                                              style: TextStyle(
                                                  color: white,
                                                  fontFamily: 'CEntury',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '02/12',
                                              style: TextStyle(
                                                  color: white,
                                                  fontFamily: 'CEntury',
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            const SizedBox(
                                              width: 65,
                                              height: 50,
                                            ),
                                            Positioned(
                                              left: 0,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    white.withOpacity(.6),
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    grey.withOpacity(.4),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'E-Card',
                                      style: TextStyle(
                                          fontFamily: 'Cera Pro',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      elevation: 4,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: blue,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(17),
                                            )),
                                        child: const Text(
                                          'Active',
                                          style: TextStyle(
                                              fontFamily: 'Century',
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: grey,
                                      ),
                                      child: const Icon(
                                          Boxicons.bx_dots_horizontal_rounded),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Card(
                          shadowColor: lightblue,
                          elevation: 10,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(19)),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/Card3.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(19)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 13),
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'E-Card',
                                            style: TextStyle(
                                                fontFamily: 'Cera Pro',
                                                color: white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child:
                                                Image.asset('images/visa.png'))
                                      ],
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                        text: '.... .... .... ',
                                        style: TextStyle(
                                            color: white,
                                            height: .75,
                                            fontFamily: 'Cera Pro',
                                            fontSize: 55,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      TextSpan(
                                        text: '2132',
                                        style: TextStyle(
                                            color: white,
                                            fontFamily: 'Century',
                                            fontSize: 27,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ])),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Card Holder Name',
                                              style: TextStyle(
                                                  color: white,
                                                  fontFamily: 'CEntury',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Andrew Aue',
                                              style: TextStyle(
                                                  color: white,
                                                  fontFamily: 'CEntury',
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Expire Date',
                                              style: TextStyle(
                                                  color: white,
                                                  fontFamily: 'CEntury',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '02/12',
                                              style: TextStyle(
                                                  color: white,
                                                  fontFamily: 'CEntury',
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            const SizedBox(
                                              width: 65,
                                              height: 50,
                                            ),
                                            Positioned(
                                              left: 0,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    white.withOpacity(.6),
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    grey.withOpacity(.4),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: screenwidth,
                height: screenheight * .11,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'X-Card',
                      style: TextStyle(
                          fontFamily: 'Cera Pro',
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                                color: darkgrey)
                          ],
                          color: blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(19)),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Boxicons.bx_plus,
                                color: white,
                                size: 34,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
