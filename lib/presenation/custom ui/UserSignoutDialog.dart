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
            padding: EdgeInsets.all(5.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Are You sure for Logout",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
