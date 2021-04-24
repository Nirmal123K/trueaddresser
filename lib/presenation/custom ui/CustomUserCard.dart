import 'dart:ui' as ui;
import 'package:trueaddresser/imports.dart';

class CustomUserCard extends StatefulWidget {
  final String userName;
  final String address;
  final String phoneNumber;

  const CustomUserCard({Key key, this.userName, this.address, this.phoneNumber})
      : super(key: key);

  @override
  _CustomUserCardState createState() => _CustomUserCardState();
}

class _CustomUserCardState extends State<CustomUserCard> {
  final double _borderRadius = 24;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              gradient: LinearGradient(
                  colors: [Color(0xff6DC8F3), Color(0xff73A1F9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff73A1F9),
                  blurRadius: 12,
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
                  _borderRadius, Color(0xff6DC8F3), Color(0xff73A1F9)),
            ),
          ),
          Positioned.fill(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 100,
                  ),
                  flex: 2,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.userName,
                          style: GoogleFonts.ptSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))),
                      Text(widget.phoneNumber,
                          style: GoogleFonts.ptSans(
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
                              width: 8,
                            ),
                            Flexible(
                              child: Text(widget.address,
                                  style: GoogleFonts.ptSans(
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
              ],
            ),
          ),
        ],
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