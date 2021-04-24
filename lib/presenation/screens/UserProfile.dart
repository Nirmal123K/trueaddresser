import 'package:trueaddresser/imports.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  AuthService authService = new AuthService();
  UserModel _currentUser;
  String username = "hello";
  @override
  void initState() {
  //  getUser();
    super.initState();
  }

  // getUser() async {
  //   var user = authService.getCurrentUser();
  //   UserModel userModel = await authService.getUserFromDB(uid: user.uid);
  //   _currentUser = userModel;
  //   setState(() {
  //     username = _currentUser.username;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(username),
      ),
    );
  }
}
