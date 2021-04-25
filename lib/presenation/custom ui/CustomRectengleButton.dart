import 'package:trueaddresser/imports.dart';

class CustomRectengleButton extends StatefulWidget {
  final String buttonTitle;

  final Function onClick;
  final bool buttonOutline;
  const CustomRectengleButton(
      {Key key,
      @required this.buttonTitle,
      this.buttonOutline = false,
      @required this.onClick})
      : super(key: key);
  @override
  _CustomRectengleButtonState createState() => _CustomRectengleButtonState();
}

class _CustomRectengleButtonState extends State<CustomRectengleButton> {
  bool internalButtonOutline;
  Color rectengleButtonbluecolor = HexColor("#8e00e9");
  Color rectengleButtonwhitecolor = HexColor("#ffffff");
  @override
  void initState() {
    internalButtonOutline = widget.buttonOutline;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          color: internalButtonOutline
              ? rectengleButtonwhitecolor
              : rectengleButtonbluecolor,
          border: internalButtonOutline
              ? Border.all()
              : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            widget.buttonTitle,
            style: GoogleFonts.poppins(
              letterSpacing: 1,
              fontSize: 20,
              color: internalButtonOutline ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
