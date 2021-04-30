import 'package:trueaddresser/imports.dart';

class UserDeleteDialog extends StatefulWidget {
  final String userUid;

  const UserDeleteDialog({Key key, this.userUid}) : super(key: key);
  @override
  _UserDeleteDialogState createState() => _UserDeleteDialogState();
}

class _UserDeleteDialogState extends State<UserDeleteDialog> {
  AuthService _authService = new AuthService();
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
                          onClick: () {
                            _authService.deleteUser(widget.userUid).then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SplashScreen()),
                                    (route) => false));
                          }),
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
