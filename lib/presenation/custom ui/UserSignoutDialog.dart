import 'package:trueaddresser/imports.dart';

class UserSignoutDialog extends StatefulWidget {
  @override
  _UserSignoutDialogState createState() => _UserSignoutDialogState();
}

class _UserSignoutDialogState extends State<UserSignoutDialog> {
  AuthService authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "are you sure you want to signout.",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: HexColor('#491d7f'),
                          fontWeight: FontWeight.normal,
                          fontSize: 16)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
                      child: CustomRectengleButton(
                          buttonTitle: "close",
                          buttonOutline: true,
                          onClick: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Container(
                      width: 150,
                      child: CustomRectengleButton(
                        buttonTitle: "Yes",
                        onClick: () =>
                            authService.signOutUser().then((value) async {
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen()),
                                (route) => false);
                          });
                        }),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
