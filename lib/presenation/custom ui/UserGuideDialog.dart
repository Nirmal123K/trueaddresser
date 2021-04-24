import 'package:trueaddresser/imports.dart';

class UserGuideDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Guide",
                    style: GoogleFonts.ptSans(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18))),
                SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        " => Please search users with complete phone number",
                        style: GoogleFonts.ptSans(
                            textStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        " => Private accounts are hide by default, can request them to access",
                        style: GoogleFonts.ptSans(
                            textStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        " => Rock with tapping on address to see locations on map",
                        style: GoogleFonts.ptSans(
                            textStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)))),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 150,
                  child: CustomRectengleButton(
                      buttonTitle: "close",
                      onClick: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
