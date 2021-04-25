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
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor('#f5f5f5'),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: HexColor('#f5f5f5'),
        currentIndex: _selectedIndex,
        onTap: onBottomNavigatonBarTap,
        selectedItemColor: HexColor('#f46188'),
        selectedIconTheme: IconThemeData(color: HexColor('#491d7f')),
        items: [
          BottomNavigationBarItem(
              backgroundColor: HexColor('#491d7f'),
              activeIcon: Icon(
                Icons.home_outlined,
                color: HexColor('#f46188'),
                size: 30,
              ),
              icon: Icon(
                Icons.home_outlined,
                color: HexColor('#491d7f'),
                size: 30,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.person_outline,
                color: HexColor('#f46188'),
                size: 30,
              ),
              icon: Icon(
                Icons.person_outline,
                color: HexColor('#491d7f'),
                size: 30,
              ),
              label: "Profile")
        ],
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
