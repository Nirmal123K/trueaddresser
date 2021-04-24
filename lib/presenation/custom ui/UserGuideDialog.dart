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
                Text(
                  "User Guide",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "-> Search You have to enter full Number",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "-> Private Account Details not be Displayed",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "-> Tap on Addresses You can Navigate to Map",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
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
