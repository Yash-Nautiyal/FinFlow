import 'package:finflow/utils/Colors/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isshown = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
//Heading-----------------------------------------------------------------------

        appBar: AppBar(
          backgroundColor: purple,
          centerTitle: true,
          title: Text(
            'Sign in',
            style: TextStyle(
              fontFamily: 'Cera Pro',
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: black,
            ),
          ),
        ),
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
                  Text(
                    'Enter your Phone Number',
                    style: TextStyle(
                      fontFamily: 'Cera Pro',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: black,
                    ),
                  ),

                  //Input Email-------------------------------------------------------------------

                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.045),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: email,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      style: TextStyle(
                        color: black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'UserName',
                        hintStyle:
                            TextStyle(color: grey, fontFamily: 'CEra Pro'),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.045),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: email,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      style: TextStyle(
                        color: black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle:
                            TextStyle(color: grey, fontFamily: 'CEra Pro'),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                      ),
                    ),
                  ),

                  //Input Password----------------------------------------------------------------

                  //Forgot Password---------------------------------------------------------------

                  //Sign in Button----------------------------------------------------------------
                  SizedBox(
                    height: screenHeight * .06,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Sign in',
                        )),
                  ),

                  //Google Sign in Button---------------------------------------------------------

                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont have an account? ",
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Register Here",
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ),
      )),
    );
  }
}
