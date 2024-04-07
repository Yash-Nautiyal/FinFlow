import 'package:finflow/pages/login/phone.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/utils/firebase/shared_preference.dart';
import 'package:flutter/material.dart';

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

        appBar: AppBar(
          backgroundColor: purple,
          centerTitle: true,
          title: Text(
            'Sign in',
            style: textTheme.displayMedium!
                .copyWith(color: Colors.white, fontSize: 25),
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
                  Text('Enter your Details',
                      style: textTheme.displayMedium!.copyWith(fontSize: 15)),

                  //Input Email-------------------------------------------------------------------

                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.045),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: firstname,
                      onChanged: (value) {
                        LoginPage.fn = value;
                      },
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        hintStyle:
                            textTheme.displaySmall!.copyWith(fontSize: 17),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.045),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      controller: lastname,
                      onChanged: (value) {
                        LoginPage.ln = value;
                      },
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        hintStyle:
                            textTheme.displaySmall!.copyWith(fontSize: 17),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.045),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      onChanged: (value) {
                        LoginPage.email = value;
                      },
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle:
                            textTheme.displaySmall!.copyWith(fontSize: 17),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: white),
                          borderRadius: BorderRadius.all(Radius.circular(13)),
                        ),
                      ),
                    ),
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
