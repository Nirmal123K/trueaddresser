import 'package:trueaddresser/imports.dart';
import 'package:trueaddresser/presenation/custom%20ui/UserSignoutDialog.dart';
import 'package:trueaddresser/presenation/custom%20ui/CustomUserCard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = new AuthService();
  String phoneNumber = "";

  Color tilteTextColor = HexColor("#172047");
  Color customBlueColor = HexColor("#8e00e9");
  Icon customsearchIcon = Icon(
    Icons.search,
    color: Colors.black,
  );
  Widget customAppBar = RichText(
      text: TextSpan(
          style: new TextStyle(
            color: Colors.black,
          ),
          children: <TextSpan>[
        TextSpan(
            text: "true",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25))),
        TextSpan(
            text: " addresser",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22))),
      ]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: customAppBar,
          actions: <Widget>[
            IconButton(
                icon: customsearchIcon,
                onPressed: () {
                  setState(() {
                    if (this.customsearchIcon.icon == Icons.search) {
                      this.customsearchIcon = Icon(
                        Icons.cancel,
                        color: Colors.black,
                      );
                      this.customAppBar = Card(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Search...'),
                          onChanged: (val) {
                            setState(() {
                              phoneNumber = val;
                            });
                          },
                        ),
                      );
                    } else {
                      this.customsearchIcon = Icon(
                        Icons.search,
                        color: Colors.black,
                      );
                      this.customAppBar = RichText(
                          text: TextSpan(
                              style: new TextStyle(
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                            TextSpan(
                                text: "true",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25))),
                            TextSpan(
                                text: " addresser",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22))),
                          ]));
                    }
                  });
                }),
            IconButton(
                icon: Icon(
                  Icons.info,
                  color: Colors.lightBlue,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return UserGuideDialog();
                      });
                }),
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return UserSignoutDialog();
                    });
              },
              // onPressed: () => authService.signOutUser().then((value) async {
              //       Future.delayed(Duration(seconds: 1), () {
              //         Navigator.of(context).pushAndRemoveUntil(
              //             MaterialPageRoute(
              //                 builder: (context) => SplashScreen()),
              //             (route) => false);
              //       });
              //     }
            )
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

                      return CustomUserCard(
                          userName: userNames,
                          phoneNumber: phoneNumbers,
                          address: addresses);
                    });
          },
        ));
  }
}
