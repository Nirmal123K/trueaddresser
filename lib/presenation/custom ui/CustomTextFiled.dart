import 'dart:ui';

import 'package:trueaddresser/imports.dart';

class CustomTextFiled extends StatefulWidget {
  final icon;
  final Function onChange;
  final String hintText;
  final bool defaultConfig;
  final Function validator;

  final height;
  final TextInputType textInputype;
  final TextEditingController textEditingController;

  const CustomTextFiled(
      {Key key,
      @required this.icon,
      this.height,
      this.defaultConfig = true,
      @required this.onChange,
      @required this.hintText,
      @required this.textInputype,
      @required this.textEditingController,
      this.validator})
      : super(key: key);

  @override
  _CustomTextFiledState createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  bool internalDefaultConfig;
  Color textfiledcolor = HexColor('#eeeeee');
  Color texticoncolor = HexColor('#642ab6');
  @override
  void initState() {
    internalDefaultConfig = widget.defaultConfig;
    print(internalDefaultConfig);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: internalDefaultConfig ? 60.0 : widget.height,
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: textfiledcolor),
      child: Row(
        children: [
          Container(
            child: Icon(
              widget.icon,
              color: texticoncolor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              //      height: MediaQuery.of(context).size.height,
              child: TextFormField(
                keyboardType: widget.textInputype,
                controller: widget.textEditingController,
                autofocus: false,
                validator: widget.validator,
                onChanged: widget.onChange,
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 16, color: HexColor('#491d7f'))),
                minLines: 1,
                maxLines: internalDefaultConfig ? 1 : 3,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  counterText: "",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
