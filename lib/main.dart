import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trueaddresser/imports.dart';
import 'package:trueaddresser/logic/auth_service.dart';
import 'package:trueaddresser/presenation/custom%20ui/Provider_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // var uid = prefs.getString('uid');
  // print(uid);
  // runApp(MaterialApp(
  //    debugShowCheckedModeBanner: false,
  //   home: uid == null
  //       ? SplashScreen()
  //       : HomeScreen(
  //           uid: uid,
  //         ),
  // ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Providers(
      auth: AuthService(),
      db: FirebaseFirestore.instance,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AppStart(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AppStart extends StatefulWidget {
  @override
  _AppStartState createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  bool isLoggedIn = false;
  String userId;
  User user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    checkUserLoggedStatus();
    super.initState();
  }

  checkUserLoggedStatus() async {
    print(user.uid);
    if (user == null) {
      setState(() {
        isLoggedIn = false;
      });
    } else {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterDemo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (isLoggedIn ?? false) ? Home() : SplashScreen(),
    );
  }
}

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final AuthService auth = Provider.of(context).auth;
//     return StreamBuilder<String>(
//       stream: auth.onAuthStateChanged,
//         builder: (context, AsyncSnapshot<String> snapshot) {
//           if(snapshot.connectionState == ConnectionState.active){
//             final bool signedIn = snapshot.hasData;
//             return signedIn ? HomeScreen() :SplashScreen();
//           }
//           return Container();
//         });
//   }
// }
