import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finflow/pages/login/login.dart';
import 'package:finflow/screens.dart';
import 'package:finflow/utils/firebase/firebase_options.dart';
import 'package:finflow/utils/firebase/shared_preference.dart';
import 'package:finflow/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: retrieveData('UserID'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final uid = snapshot.data;
          print(uid);
          if (uid != null) {
            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    final userData = snapshot.data;
                    if (userData != null && userData.exists) {
                      return const Screens();
                    } else {
                      return const LoginPage();
                    }
                  } else {
                    return const Scaffold(
                        body: Center(child: CircularProgressIndicator()));
                  }
                } else {
                  return const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                }
              },
            );
          } else {
            // UID is null, navigate to LoginPage
            return LoginPage();
          }
        } else {
          // Show loading indicator while waiting for data
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
