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

  Color tilteTextColor = HexColor("#491d7f");
  Color customBlueColor = HexColor("#8e00e9");
  Icon customsearchIcon = Icon(
    Icons.search,
    color: Colors.black,
  );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: customAppBar,
          actions: <Widget>[
            IconButton(
                icon: customsearchIcon,
                onPressed: () {
                  setState(() {
                    if (this.customsearchIcon.icon == Icons.search) {
                      this.customsearchIcon = Icon(
                        Icons.cancel,
                        color: HexColor("#491d7f"),
                      );
                      this.customAppBar = CustomTextFiled(
                        hintText: "search here",
                        onChange: (val) {
                          setState(() {
                            phoneNumber = val;
                          });
                        },
                        icon: Icons.search,
                      );
                    } else {
                      this.customsearchIcon = Icon(
                        Icons.search,
                        color: HexColor("#491d7f"),
                      );
                      this.customAppBar = RichText(
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
                    }
                  });
                }),
            IconButton(
                icon: Icon(
                  Icons.info,
                  color: HexColor("#491d7f"),
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
                      String userId = data['uid'].toString();
                      int userLikes = data["likes"];
                      return CustomUserCard(
                        uid: userId,
                          userName: userNames,
                          phoneNumber: phoneNumbers,
                          userLikes: userLikes,
                          address: addresses);
                    });
          },
        ));
  }
}
