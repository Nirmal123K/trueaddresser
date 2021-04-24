// import 'package:trueaddresser/imports.dart';


// abstract class AuthAlert{
//   static Future<void> showErrorDialog(
//       BuildContext context, String errorMessage) async {
//     final authBloc = Provider.of<AuthBloc>(context,listen: false);
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Error', style: TextStyle(color: Colors.white)),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: [
//                   Text(errorMessage, style: TextStyle(color: Colors.white))
//                 ],
//               ),
//             ),
//             actions: [
//               FlatButton(
//                 child: Text(
//                   'Okay',
//                   style: TextStyle(color: Colors.deepPurple),
//                 ),
//                 onPressed: () {
//                   authBloc.clearErrorMessage();
//                   Navigator.of(context).pop();
//                 },
//               )
//             ],
//           );
//         });}
// }