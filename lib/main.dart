import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickd_business/views/ui/splash_ui.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license =
        await rootBundle.loadString('assets/google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'QuickD Business',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: Colors.deepPurple,
                  accentColor: Colors.deepPurpleAccent,
                  cursorColor: Colors.deepPurple,
                  primarySwatch: Colors.deepPurple,
                  textTheme: GoogleFonts.openSansTextTheme(
                      Theme.of(context).textTheme)),
              home: SplashScreen(),
            );
          } else {
            return MaterialApp(
                home: Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ));
          }
        });
  }
}
