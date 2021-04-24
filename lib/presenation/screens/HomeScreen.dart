import 'package:trueaddresser/imports.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = new AuthService();
  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Card(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search...'),
              onChanged: (val) {
                setState(() {
                  phoneNumber = val;
                });
              },
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                onPressed: () => authService.signOutUser().then((value) async {
                      Future.delayed(Duration(seconds: 1), () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()),
                            (route) => false);
                      });
                    }))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: (phoneNumber != "" && phoneNumber != null)
              ? FirebaseFirestore.instance
                  .collection('users')
                  .where('phoneNumber', isEqualTo: phoneNumber)
                  .where('isAcoountPrivate', isEqualTo: 'false')
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('users')
                  .where('isAcoountPrivate', isEqualTo: 'false')
                  .snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data.docs[index];
                      String userNames =
                          data['username'].toString().toUpperCase();
                      String phoneNumbers = data['phoneNumber'].toString();
                      String addresses = data['address'].toString();

                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          color: Colors.redAccent,
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("UserName : $userNames",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Phone Number : $phoneNumbers",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800)),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    MapsLauncher.launchQuery(addresses);
                                  },
                                  child: Text("Address : $addresses",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
          },
        ));
  }
}
