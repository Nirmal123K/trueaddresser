import 'package:trueaddresser/imports.dart';
import 'package:trueaddresser/presenation/custom%20ui/CustomTextFiled.dart';

class UserSignup extends StatefulWidget {
  @override
  _UserSignupState createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  String userUid;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final DateTime timestamp = DateTime.now();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  AuthService authService = new AuthService();
  bool isPrivate = false;
  var accountPrivate = 'false';

  TextEditingController usernameController = new TextEditingController();
  TextEditingController userPhoneNumberController = new TextEditingController();
  TextEditingController userAddressController = new TextEditingController();

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
          centerTitle: true,
          title: Text("welcome to trueaddress",
              style: GoogleFonts.comfortaa(
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
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  CustomTextFiled(
                    hintText: "Enter Name",
                    onChange: (value) {},
                    validator: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          _scaffoldKey.currentState.showSnackBar(
                              errorSnakBar("please provide full name."));
                          return 'username is empty';
                        } else if (value.length < 3 || value.length > 8) {
                          _scaffoldKey.currentState.showSnackBar(errorSnakBar(
                              "user name is not valid (3 to 8 Characters )"));
                        }
                      });
                    },
                    icon: Icons.person,
                    textInputype: TextInputType.text,
                    textEditingController: usernameController,
                  ),
                  SizedBox(height: 10),
                  CustomTextFiled(
                    hintText: "Enter Contact Number",
                    onChange: null,
                    validator: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          _scaffoldKey.currentState.showSnackBar(
                              errorSnakBar("please provide contact number."));
                          return null;
                        } else if (value.length != 10) {
                          _scaffoldKey.currentState.showSnackBar(
                              errorSnakBar("please provide contact number."));
                        }
                      });
                    },
                    icon: Icons.phone,
                    textInputype: TextInputType.phone,
                    textEditingController: userPhoneNumberController,
                  ),
                  SizedBox(height: 10),
                  CustomTextFiled(
                    hintText: "Enter Address",
                    onChange: null,
                    defaultConfig: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(
                            errorSnakBar("please provide address"));
                        return null;
                      } else if (value.length > 250) {
                        _scaffoldKey.currentState.showSnackBar(errorSnakBar(
                            "address is not valid (maximum 250 Characters)"));
                      }
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
                    title: Text("keep my account private"),
                  ),
                  SizedBox(height: 20),
                  CustomRectengleButton(
                      buttonTitle: "sign up",
                      onClick: () async {
                        // showLoaderDialog(context);
                        if (formkey.currentState.validate()) {
                          await authService.phoneSignup(
                              phoneNumber:
                                  userPhoneNumberController.text.trim(),
                              verificationFailed: (error) {
                                print(error);
                              },
                              codeSent: (String verificationId,
                                  [int forceResendingToken]) {
                                print(verificationId);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OtpScreen(
                                              username: usernameController.text
                                                  .trim(),
                                              phoneNumber:
                                                  userPhoneNumberController.text
                                                      .trim(),
                                              address:
                                                  userAddressController.text,
                                              isAccountPrivate:
                                                  accountPrivate.toString(),
                                              verificationId: verificationId,
                                            )));
                              });
                        } else {}
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
