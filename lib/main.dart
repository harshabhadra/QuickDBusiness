import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:quickd_business/views/ui/splash_ui.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

List<Box> boxList = [];
Future<List<Box>> _openBox() async {
  var dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  var docBox = await Hive.openBox("docs");
  boxList.add(docBox);
  return boxList;
}

void main() {
  LicenseRegistry.addLicense(() async* {
    final license =
        await rootBundle.loadString('assets/google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  _openBox();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
