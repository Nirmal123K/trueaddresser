import 'package:flutter_icons/flutter_icons.dart';
import 'package:trueaddresser/imports.dart';
//import 'package:trueaddresser/presenation/custom%20ui/CustomAlertDialog.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color tilteTextColor = HexColor("#172047");
  Color customBlueColor = HexColor("#8e00e9");
  Color customWhiteColor = HexColor("#ffffff");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        //extendBodyBehindAppBar: true,
        body: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                RichText(
                    text: TextSpan(
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                      TextSpan(
                          text: "true",
                          style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                  color: customBlueColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40))),
                      TextSpan(
                          text: "addresser",
                          style: GoogleFonts.comfortaa(
                              textStyle: TextStyle(
                                  color: tilteTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40))),
                    ])),
                SizedBox(
                  height: 10,
                ),
                Text("Sexplore real addresses around you",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: tilteTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16))),
                SizedBox(
                  height: 170,
                ),
                CustomRectengleButton(
                    buttonTitle: "create new account",
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserSignup()));
                    }),
                SizedBox(
                  height: 20,
                ),
                CustomRectengleButton(
                    buttonTitle: "log in",
                    buttonOutline: true,
                    onClick: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => UserLogin()));
                    }),
                Spacer()
              ],
            ),
          ),
        ));
  }
}
