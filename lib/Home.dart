import 'package:trueaddresser/imports.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid;
  String _username;
  String phoneNumber = "";
  UserModel _currentUser;

  AuthService authService = new AuthService();
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[HomeScreen(), UserProfile()];

  @override
  void initState() {
    super.initState();
    //getCurrentUser();
  }
  // getCurrentUser()async{
  //   UserModel currentUser = await authService.getUserFromDB(uid: uid);
  //   _currentUser = currentUser;

  //   setState(() {
  //     _username = _currentUser.address;
  //   });
  // }
  void onBottomNavigatonBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onBottomNavigatonBarTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
