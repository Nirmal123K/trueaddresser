import 'package:trueaddresser/imports.dart';


class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController userPhoneNumberController = new TextEditingController();

  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  AuthService authService = new AuthService();

  // login() async {
  //   if (formkey.currentState.validate()) {
  //     //formkey.currentState.save();
  //     showLoaderDialog(context);
  //     authService
  //         .signinEmail(email, password, context, _scaffoldKey)
  //         .then((value) async {
  //       if (value != null) {
  //         print(value.uid);
  //         HelperFunctions.saveUserLoggedInDeatils(userId: value.uid);

  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => HomeScreen(
  //                       uid: value.uid,
  //                     )),
  //             (route) => false);
  //       } else {
  //         Navigator.of(context).pop();
  //       }
  //     });
  //   } else {
  //     print(errortext);
  //   }
  // }

  login() async {
    var validate = formkey.currentState.validate();
    print("validate ois $validate");
    if (formkey.currentState.validate()) {
      
      authService.phoneSignIn(
          scaffoldMessenger: _scaffoldKey,
          phoneNumber: userPhoneNumberController.text.trim(),
          verificationComplete: (phoneAuthCredential) {},
          codeSent: (String verificationId, [int forceResendingToken]) async {
           

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LoginOTPScreen(
                      verficationId: verificationId,
                    )));
          },
          verificationFailed: (code) {
            //  print(code);
          },
          context: context);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text("Log In",
              style: GoogleFonts.roboto(
                  decorationThickness: 5.2,
                  textStyle: TextStyle(color: Colors.black))),
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Container(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Welcome back!",
                        style: GoogleFonts.roboto(fontSize: 16),
                      ),
                    )),
                SizedBox(
                  height: 05,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text("Please log in to continue!",
                          style: GoogleFonts.roboto(fontSize: 16)),
                    )),
                SizedBox(height: 10),
                CustomTextFiled(
                  hintText: "Phone Number",
                  onChange: (value) {},
                  validator: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(
                            errorSnakBar("Phone Number is Empty"));
                        return 'phone number is empty';
                      } else if (value.length != 10) {
                        _scaffoldKey.currentState.showSnackBar(
                            errorSnakBar("Phone Number is not valid"));
                        return 'phone number is empty';
                      } else {
                        return null;
                      }
                    });
                  },
                  icon: Icons.phone,
                  textInputype: TextInputType.phone,
                  textEditingController: userPhoneNumberController,
                ),
                SizedBox(height: 30),
                CustomRectengleButton(
                    buttonTitle: "log in", onClick: () => login()),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userPhoneNumberController.dispose();
    super.dispose();
  }
}
