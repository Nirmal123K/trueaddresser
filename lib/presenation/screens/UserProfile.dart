import 'package:trueaddresser/imports.dart';
import 'package:trueaddresser/presenation/custom%20ui/UserDeleteDialog.dart';

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
  bool _isAccouontPrivate;
  String uid;
  String username = "hello";
  String phoneNumber = "Loading";
  String address = "Loding";
  int userLikes;

  String updatedIsAccountPrivate;
  DateTime _currentDate = DateTime.now();
  @override
  void initState() {
    getUser();
    super.initState();
  }

  Widget customAppBar = RichText(
      text: TextSpan(
          style: new TextStyle(
            color: HexColor("#491d7f"),
          ),
          children: <TextSpan>[
        TextSpan(
            text: "true",
            style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                    color: HexColor("#491d7f"),
                    fontWeight: FontWeight.bold,
                    fontSize: 20))),
        TextSpan(
            text: "addresser",
            style: GoogleFonts.comfortaa(
                textStyle: TextStyle(
                    color: HexColor("#491d7f"),
                    fontWeight: FontWeight.bold,
                    fontSize: 20))),
      ]));

  getUser() async {
    _isLoading = true;
    var user = authService.getCurrentUID();
    UserModel userModel = await authService.getUserFromDB(uid: user);
    _currentUser = userModel;
    setState(() {
      _isLoading = false;
      uid = _currentUser.uid;
      username = _currentUser.username;
      phoneNumber = _currentUser.phoneNumber;
      address = _currentUser.address;
      userLikes = _currentUser.likes;
      _isAccouontPrivate = _currentUser.isAcoountPrivate == 'true';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: HexColor('#f5f5f5'),
        appBar: AppBar(
          backgroundColor: HexColor('#f5f5f5'),
          elevation: 0.0,
          title: customAppBar,
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){
              showDialog(context: context, builder: (context){
                return UserDeleteDialog(userUid: uid,);
              });
            })
          ],
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
                    Center(child: Image.asset("assets/person.png", scale: 10)),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(username.toUpperCase(),
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: HexColor('#491d7f'),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22))),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: CustomTextFiled(
                        icon: Icons.person,
                        onChange: (value) {
                          username = value;
                        },
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
                        onTap: () {
                          _scaffoldKey.currentState.showSnackBar(
                              errorSnakBar("Phone Number can't Edit"));
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
                        onChange: (value) {
                          address = value;
                        },
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
                                updatedIsAccountPrivate = "true";
                              } else {
                                updatedIsAccountPrivate = "false";
                              }
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
                                buttonTitle: "update",
                                onClick: () {
                                  print(updatedIsAccountPrivate);
                                  authService
                                      .updateUserData(
                                          uid: uid,
                                          username: username,
                                          phoneNumber: phoneNumber,
                                          likes: userLikes,
                                          address: address,
                                          isAccountPrivate:
                                              updatedIsAccountPrivate,
                                          timestamp: _currentDate)
                                      .then((value) => {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home()),
                                                (route) => false)
                                          });
                                })),
                      ],
                    ),
                  ],
                )),
              ),
      ),
    );
  }
}
