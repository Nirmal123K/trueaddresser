import 'package:trueaddresser/imports.dart';

class LoginOTPScreen extends StatefulWidget {
  final String verficationId;

  const LoginOTPScreen({Key key, this.verficationId}) : super(key: key);
  @override
  _LoginOTPScreenState createState() => _LoginOTPScreenState();
}

class _LoginOTPScreenState extends State<LoginOTPScreen> {
  TextEditingController userOtpController = TextEditingController();
  AuthService authService = new AuthService();
  var tempotp;

  final userRef = FirebaseFirestore.instance.collection("users");
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("verification",
              style: GoogleFonts.comfortaa(
                  textStyle: TextStyle(color: Colors.black))),
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              }),
        ),
        body: Container(
          child: Column(
            children: [
              CustomTextFiled(
                hintText: "Enter OTP",
                onChange: null,
                icon: Icons.message,
                textInputype: TextInputType.number,
                textEditingController: userOtpController,
              ),
              SizedBox(
                height: 20,
              ),
              CustomRectengleButton(
                  buttonTitle: "Verify",
                  onClick: () {
                    authService
                        .verifyOTP(widget.verficationId,
                            userOtpController.text.trim(), context)
                        .then((user) => {
                              if (user != null)
                                {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                      (route) => false)
                                }
                              else
                                {
                                  Navigator.of(context).pop(),
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(content: Text(errortext)))
                                }
                            });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
