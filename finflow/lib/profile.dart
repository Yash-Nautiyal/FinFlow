import 'dart:io';

import 'package:finflow/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  final String email;
  const Profile({super.key, required this.email});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late String firstname;
  late String lastname;
  late String email;
  late String avatar;
  late File? selectedimage;
  @override
  void initState() {
    super.initState();
    firstname = "Johnny";
    lastname = "Jibs";
    email = widget.email;
    avatar = "images/profile.jpg";
    selectedimage = null;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextTheme textStyle = Theme.of(context).textTheme;
    double h = screenHeight / 6;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              Container(
                color: black,
                width: screenWidth,
                height: screenHeight,
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: purple,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(screenWidth, 50.0)),
                  ),
                  width: screenWidth,
                  height: screenHeight / 2.7,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 35, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Profile',
                            style: textStyle.displayMedium!.copyWith(
                                fontSize: 30,
                                color: black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                top: h * 1.41,
                child: Container(
                  decoration: BoxDecoration(boxShadow: const [
                    BoxShadow(
                        blurRadius: 5,
                        color: Colors.black38,
                        offset: Offset(0, 3))
                  ], color: black, borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10, top: 115, bottom: 10),
                    child: Column(children: [
                      //MYProfile--------------------------------------------------------------------

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: GestureDetector(
                            onTap: () {
                              /* _navigatetomyprofile(context); */
                            },
                            child: Container(
                              color: const Color.fromARGB(41, 116, 116, 181),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.key,
                                      color: grey,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      'My Profile',
                                      style: textStyle.displayMedium!.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      FontAwesomeIcons.arrowRight,
                                      color: grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: GestureDetector(
                            onTap: () {
                              /* _navigatetomyprofile(context); */
                            },
                            child: Container(
                              color: const Color.fromARGB(41, 116, 116, 181),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.key,
                                      color: grey,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      'All Trasactions',
                                      style: textStyle.displayMedium!.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      FontAwesomeIcons.arrowRight,
                                      color: grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
//Languages---------------------------------------------------------------------

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Container(
                            color: const Color.fromARGB(41, 116, 116, 181),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.language_rounded,
                                    color: grey,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    'Language',
                                    style: textStyle.displayMedium!.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: 140,
                                    /* child: LanguagePickerDropdown(
                                      initialValue: Languages.bihariLanguages,
                                      onValuePicked: (Language language) {},
                                    ), */
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

//Logout------------------------------------------------------------------------

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog.adaptive(
                                    content: Container(
                                      width: screenWidth * .6,
                                      height: screenHeight * .2,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              'Log out of NewsFeed? ',
                                              style: TextStyle(
                                                  color: purple,
                                                  fontFamily: 'CEra Pro',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'You can always log back in at any time. If you want to switch accounts you can do that by adding an existing account',
                                              style: TextStyle(
                                                  color: purple,
                                                  fontFamily: 'CEra Pro',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'CEra Pro'),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                purple)),
                                                    onPressed: () {
                                                      /* Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              SecondLandingPage(),
                                                        ),
                                                      ); */
                                                    },
                                                    child: Text(
                                                      'Log out',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'CEra Pro',
                                                          color: black),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              color: const Color.fromARGB(41, 116, 116, 181),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.rightFromBracket,
                                      color: grey,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      'Logout',
                                      style: textStyle.displayMedium!.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      FontAwesomeIcons.arrowRight,
/*                                       color: lightgrey,
 */
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              Positioned(
                top: h,
                child: SizedBox(
                  width: screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: black,
                        child: const CircleAvatar(
                          radius: 58,
                          /* backgroundImage: selectedimage == null
                              ? AssetImage(avatar)
                              : FileImage(selectedimage!)
                                  as ImageProvider<Object>, */
                          child: Icon(
                            FontAwesomeIcons.user,
                            size: 50,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$firstname $lastname',
                              style: TextStyle(
                                color: purple,
                                fontFamily: 'Cero Pro',
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                color: grey,
                                fontFamily: 'Cero Pro',
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  /* void _navigatetomyprofile(BuildContext context) async {
    final result = await Navigator.push(
        context,
        ModalBottomSheetRoute(
            showDragHandle: true,
            backgroundColor: purple,
            useSafeArea: true,
            builder: (context) => Myprofile(
                  firstname: firstname,
                  lastname: lastname,
                  selectedimage: selectedimage,
                  avatar: avatar,
                  email: email,
                ),
            isScrollControlled: true));
    setState(() {
      firstname = result['firstname'];
      lastname = result['lastname'];
      email = result['email'];
      avatar = result['avatar'];
      selectedimage = result['selectedimage'];
    });
  } */
}
