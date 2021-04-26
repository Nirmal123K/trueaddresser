import 'package:trueaddresser/imports.dart';
import 'package:trueaddresser/presenation/custom%20ui/CustomTextFiled.dart';

class UserSignup extends StatefulWidget {
  @override
  _UserSignupState createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  String userUid;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final DateTime timestamp = DateTime.now();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  AuthService authService = new AuthService();
  bool isPrivate = false;
  var accountPrivate = 'false';
  bool _isLoading = false;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController userPhoneNumberController = new TextEditingController();
  TextEditingController userAddressController = new TextEditingController();

  userSignUp() async {
    
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.phoneSignup(
          phoneNumber: userPhoneNumberController.text.trim(),
          verificationFailed: (error) {
            print(error);
          },
          codeSent: (String verificationId, [int forceResendingToken]) {
            setState(() {
              _isLoading = false;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtpScreen(
                          username: usernameController.text.trim(),
                          phoneNumber: userPhoneNumberController.text.trim(),
                          address: userAddressController.text,
                          isAccountPrivate: accountPrivate.toString(),
                          verificationId: verificationId,
                        )));
          });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        //extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text("Create Account",
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
        body: _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Form(
                    
                    key: _formkey,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "Sign up to explore real",
                                style: GoogleFonts.roboto(fontSize: 16),
                              ),
                            )),
                        SizedBox(
                          height: 05,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "Addresses around the world!",
                                style: GoogleFonts.roboto(fontSize: 16),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFiled(
                          hintText: "UserName",
                          onChange: (value) {},
                          validator: (value) {
                            setState(() {
                              print(value);
                              if (value == null || value.isEmpty) {
                                return _scaffoldKey.currentState.showSnackBar(
                                    errorSnakBar("username is Empty"));
                              } else {
                                return null;
                              }
                            });
                          },
                          icon: Icons.person,
                          textInputype: TextInputType.text,
                          textEditingController: usernameController,
                        ),
                        SizedBox(height: 10),
                        CustomTextFiled(
                          hintText: "Phone Number",
                          onChange: null,
                          validator: (value) {
                            setState(() {
                              if (value == null || value.isEmpty) {
                                return _scaffoldKey.currentState.showSnackBar(
                                    errorSnakBar("username is Empty"));
                              } else {
                                return null;
                              }
                            });
                          },
                          icon: Icons.phone,
                          textInputype: TextInputType.phone,
                          textEditingController: userPhoneNumberController,
                        ),
                        SizedBox(height: 10),
                        CustomTextFiled(
                          hintText: "Address",
                          onChange: null,
                          defaultConfig: false,
                          validator: (value) {
                            setState(() {
                              if (value == null || value.isEmpty) {
                                return _scaffoldKey.currentState.showSnackBar(
                                    errorSnakBar("username is Empty"));
                              } else {
                                return null;
                              }
                            });
                          },
                          height: 100.0,
                          icon: Icons.gps_fixed_rounded,
                          textInputype: TextInputType.streetAddress,
                          textEditingController: userAddressController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CheckboxListTile(
                          value: isPrivate,
                          onChanged: (value) {
                            setState(() {
                              isPrivate = value;
                              if (value == true) {
                                accountPrivate = 'true';
                              } else {
                                accountPrivate = 'false';
                              }
                            });
                          },
                          title: Text("Make Account Private"),
                        ),
                        
                        SizedBox(height: 20),
                        CustomRectengleButton(
                            buttonTitle: "sign up",
                            onClick: () async {
                              userSignUp();
                            })
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
