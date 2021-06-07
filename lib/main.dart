import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petbook_app/src/providers/firepets_provider.dart';
import 'package:petbook_app/src/providers/petfinder_provider.dart';
import 'package:petbook_app/src/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PetfinderProvider()),
        ChangeNotifierProvider(create: (_) => FirepetsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(255, 143, 101, 1),
          primaryColorDark: Color.fromRGBO(37, 20, 94, 1),
          textTheme: TextTheme(
            headline1: TextStyle(
                fontFamily: 'Poppins',
                color: Color.fromRGBO(37, 20, 94, 1),
                height: 1.8),
            headline2: TextStyle(
                fontFamily: 'Poppins',
                color: Color.fromRGBO(37, 20, 94, 1),
                height: 1.8),
            bodyText1: TextStyle(
                fontFamily: 'Poppins',
                color: Color.fromRGBO(37, 20, 94, 1),
                height: 1.8),
            bodyText2: TextStyle(
                fontFamily: 'Poppins',
                color: Color.fromRGBO(37, 20, 94, 1),
                height: 1.5),
          ),
        ),
        title: 'PetBook App',
        initialRoute: 'login',
        routes: getRoutes(),
      ),
    );
  }
}
