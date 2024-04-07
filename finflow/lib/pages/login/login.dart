import 'package:finflow/pages/login/phone.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/utils/firebase/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String fn = "";
  static String ln = "";
  static String email = "";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  bool isshown = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
//Heading-----------------------------------------------------------------------

        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: screenWidth,
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * .04, vertical: screenHeight * .025),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * .3,
                    child: Column(
                      children: [
                        Expanded(
                            child: SvgPicture.asset(
                          "images/signup.svg",
                          fit: BoxFit.contain,
                        )),
                      ],
                    ),
                  ),

                  //Input Email-------------------------------------------------------------------

                  Column(
                    children: [
                      Text('Sign Up',
                          style: textTheme.displayMedium!.copyWith(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('Enter the Details',
                            style: textTheme.displayMedium!.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.015),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          controller: firstname,
                          onChanged: (value) {
                            LoginPage.fn = value;
                          },
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          style: textTheme.displaySmall!.copyWith(fontSize: 17),
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            filled: true,
                            hintStyle:
                                textTheme.displaySmall!.copyWith(fontSize: 15),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.025),
                        child: TextField(
                          style: textTheme.displaySmall!.copyWith(fontSize: 17),
                          keyboardType: TextInputType.name,
                          controller: lastname,
                          onChanged: (value) {
                            LoginPage.ln = value;
                          },
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Last Name',
                            hintStyle:
                                textTheme.displaySmall!.copyWith(fontSize: 15),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.025),
                        child: TextField(
                          style: textTheme.displaySmall!.copyWith(fontSize: 17),
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          onChanged: (value) {
                            LoginPage.email = value;
                          },
                          onTapOutside: (event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Email',
                            hintStyle:
                                textTheme.displaySmall!.copyWith(fontSize: 15),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: purple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(13)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: screenHeight * .06,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        String? userId = await retrieveData('UserID');
                        // Print the retrieved data
                        print(userId);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MyPhone()));
                      },
                      child: Text(
                        'Sign in',
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
