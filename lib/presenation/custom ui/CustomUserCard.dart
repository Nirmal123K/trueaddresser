import 'dart:ui' as ui;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share/share.dart';
import 'package:trueaddresser/imports.dart';

class CustomUserCard extends StatefulWidget {
  final String userName;
  final String address;
  final String uid;
  final String phoneNumber;
  final int userLikes;
  const CustomUserCard(
      {Key key,
      this.userName,
      this.address,
      this.phoneNumber,
      this.uid,
      this.userLikes = 0})
      : super(key: key);

  @override
  _CustomUserCardState createState() => _CustomUserCardState();
}

class _CustomUserCardState extends State<CustomUserCard> {
  final double _borderRadius = 24;
  bool isLikeButtonPressed = false;
  String internalUserLikes;
  int likes = 0;
  AuthService _authService = AuthService();
  

  @override
  void initState() {
    internalUserLikes = widget.userLikes.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userName = widget.userName;
    String phoneNumbers = widget.phoneNumber;
    String addresses = widget.address;
    String shareUserDetail = "Name : $userName \nPhoneNumber : +91$phoneNumbers \nAddress : $addresses ";
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        actionPane: SlidableStrechActionPane(),
        actionExtentRatio: 0.30,
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconSlideAction(
                caption: 'Share',
                // color: Colors.indigo,
                icon: Icons.share,
                closeOnTap: false,
                onTap: () => {
                  
                  Share.share(shareUserDetail)
                },
              ),
            ],
          ),
        ],
        child: Stack(
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_borderRadius),
                gradient: LinearGradient(
                    colors: [HexColor('##1b7fbd'), HexColor('#7ad9f5')],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: HexColor('#7ad9f5'),
                    blurRadius: 5,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: CustomPaint(
                size: Size(100, 150),
                painter: CustomCardShapePainter(
                    _borderRadius, HexColor('####2794eb'), HexColor('#23eae6')),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 60,
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.userName,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))),
                          Text(widget.phoneNumber,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16))),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              MapsLauncher.launchQuery(widget.address);
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(widget.address,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
