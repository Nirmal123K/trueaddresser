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
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: HexColor('#491d7f'),
                            fontWeight: FontWeight.bold,
                            fontSize: 16))),
                SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        " => Please search users with complete phone number",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: HexColor('#642ab6'),
                                fontWeight: FontWeight.bold,
                                fontSize: 14)))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        " => Private accounts are hide by default, can request them to access",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: HexColor('#642ab6'),
                                fontWeight: FontWeight.bold,
                                fontSize: 14)))),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        " => Rock with tapping on address to see locations on map",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: HexColor('#642ab6'),
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
