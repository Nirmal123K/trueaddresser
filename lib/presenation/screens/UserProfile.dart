import 'package:trueaddresser/imports.dart';
import 'package:trueaddresser/presenation/custom%20ui/CustomUpdateTextFiled.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  AuthService authService = new AuthService();
  UserModel _currentUser;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool _isLoading = false;
  bool _isAccouontPrivate = false;
  String username = "hello";
  String phoneNumber = "Loading";
  String address = "Loding";

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Widget customAppBar = RichText(
      text: TextSpan(
          style: new TextStyle(
            color: Colors.black,
          ),
          children: <TextSpan>[
        TextSpan(
            text: "True",
            style: GoogleFonts.robotoCondensed(
                textStyle: TextStyle(
                    color: HexColor("#172047"),
                    fontWeight: FontWeight.bold,
                    fontSize: 30))),
        TextSpan(
            text: " Addresser",
            style: GoogleFonts.robotoCondensed(
                textStyle: TextStyle(
                    color: HexColor("#8e00e9"),
                    fontWeight: FontWeight.bold,
                    fontSize: 27))),
      ]));

  getUser() async {
    _isLoading = true;
    var user = authService.getCurrentUID();
    UserModel userModel = await authService.getUserFromDB(uid: user);
    _currentUser = userModel;
    setState(() {
      _isLoading = false;
      username = _currentUser.username;
      phoneNumber = _currentUser.phoneNumber;
      address = _currentUser.address;
      _isAccouontPrivate = _currentUser.isAcoountPrivate == 'true';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: customAppBar,
        ),
        body: _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                    child: Column(
                  children: [
                    Center(child: Image.asset("assets/person.png", scale: 8)),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        username.toUpperCase(),
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: CustomTextFiled(
                        icon: Icons.person,
                        onChange: null,
                        hintText: username,
                        textInputype: TextInputType.text,
                        textEditingController: null,
                        putInitalValue: true,
                        initalText: username,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: (){
                          _scaffoldKey.currentState.showSnackBar(errorSnakBar("Phone Number can't Edit"));
                        },
                        child: CustomTextFiled(
                          icon: Icons.phone,
                          onChange: null,
                          hintText: phoneNumber,
                          enable: false,
                          textInputype: TextInputType.phone,
                          textEditingController: null,
                          putInitalValue: true,
                          initalText: phoneNumber,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: CustomTextFiled(
                        icon: Icons.person,
                        onChange: null,
                        hintText: address,
                        defaultConfig: false,
                        height: 100.0,
                        textInputype: TextInputType.text,
                        textEditingController: null,
                        putInitalValue: true,
                        initalText: address,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: CheckboxListTile(
                          value: _isAccouontPrivate,
                          title: Text("Make Account Private"),
                          onChanged: (value) {
                            setState(() {
                              _isAccouontPrivate = value;
                              if (value == true) {
                              } else {}
                            });
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: 150,
                            child: CustomRectengleButton(
                              buttonTitle: "cancel",
                              buttonOutline: true,
                              onClick: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                    (route) => false);
                              },
                            )),
                        Container(
                            width: 150,
                            child: CustomRectengleButton(
                                buttonTitle: "update", onClick: () {})),
                      ],
                    ),
                  ],
                )),
              ),
      ),
    );
  }
}
