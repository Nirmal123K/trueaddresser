import 'package:trueaddresser/imports.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController userPhoneNumberController = new TextEditingController();

  bool _isLoading = false;
  final formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  AuthService authService = new AuthService();
  var phone;

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
      setState(() {
        _isLoading = true;
      });
      authService.phoneSignIn(
          scaffoldMessenger: _scaffoldKey,
          phoneNumber: userPhoneNumberController.text.trim(),
          verificationComplete: (phoneAuthCredential) {},
          codeSent: (String verificationId, [int forceResendingToken]) async {
            setState(() {
              _isLoading = false;
            });
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
        backgroundColor: HexColor('#f5f5f5'),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: HexColor('#f5f5f5'),
          centerTitle: true,
          title: Text("welcome back!",
              style: GoogleFonts.comfortaa(
                  decorationThickness: 5.2,
                  textStyle: TextStyle(color: HexColor('#642ab6')))),
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body:  _isLoading
            ? Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
            :  Form(
            key: formkey,
            child: Column(
              children: [
                CustomTextFiled(
                  hintText: "Enter Contact Number",
                  onChange: (value) {},
                  validator: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(
                            errorSnakBar("Please enter contact number first."));
                        return null;
                      } else if (value.length != 10) {
                        _scaffoldKey.currentState.showSnackBar(
                            errorSnakBar("Please enter valid contact number"));
                        return null;
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
      );
  }

  @override
  void dispose() {
    userPhoneNumberController.dispose();
    super.dispose();
  }
}
