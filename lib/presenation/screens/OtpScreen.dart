import 'package:trueaddresser/imports.dart';

class OtpScreen extends StatefulWidget {
  final verificationId;
  final String username;
  final String phoneNumber;
  final String address;
  final String isAccountPrivate;

  const OtpScreen(
      {Key key,
      @required this.verificationId,
      @required this.username,
      @required this.phoneNumber,
      @required this.address,
      @required this.isAccountPrivate})
      : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController userOtpController = TextEditingController();
  AuthService authService = new AuthService();
  DateTime _dateTime = DateTime.now();
  UserModel userModel = UserModel();
  bool _isLoding = false;

  final userRef = FirebaseFirestore.instance.collection("users");
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void setState(fn) {
    print(widget.verificationId);
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text("Otp Verification",
              style: GoogleFonts.roboto(
                  decorationThickness: 5.2,
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
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Verify Otp",
                      style: GoogleFonts.roboto(fontSize: 16),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              CustomTextFiled(
                hintText: "Enter Otp",
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
                        .verifyOTP(widget.verificationId,
                            userOtpController.text.trim(), context)
                        .then((user) async => {
                              if (user != null)
                                {
                                  userModel = UserModel(
                                      uid: user.uid,
                                      username: widget.username,
                                      phoneNumber: widget.phoneNumber,
                                      address: widget.address,
                                      isAcoountPrivate: widget.isAccountPrivate,
                                      timestamp: _dateTime),
                                  await userRef
                                      .doc(user.uid)
                                      .set(userModel.toMap(userModel)),
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
