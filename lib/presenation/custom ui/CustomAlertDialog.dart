import 'package:flutter_icons/flutter_icons.dart';
import 'package:trueaddresser/imports.dart';


Future customAlertDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      'Error',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'No Internet Connetion',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.redAccent,
                      child: Text(
                        'colse',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: -60,
              child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 60,
                  child: Icon(
                    Feather.alert_triangle,
                    color: Colors.yellow,
                    size: 80,
                  )),
            )
          ],
        ),
      )   ;   });
}
