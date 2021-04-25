import 'dart:ui';

import 'package:trueaddresser/imports.dart';

class CustomTextFiled extends StatefulWidget {
  final icon;
  final Function onChange;
  final String hintText;
  final String initalText;
  final bool defaultConfig;
  final Function validator;
  final bool enable;
  final height;
  final TextInputType textInputype;
  final TextEditingController textEditingController;
  final bool putInitalValue;

  const CustomTextFiled(
      {Key key,
      @required this.icon,
      this.height,
      this.enable = true,
      this.defaultConfig = true,
      @required this.onChange,
      @required this.hintText,
      @required this.textInputype,
      @required this.textEditingController,
      this.validator,
      this.putInitalValue = false,
      this.initalText})
      : super(key: key);

  @override
  _CustomTextFiledState createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  bool internalDefaultConfig;
  bool internalEnable;
  bool internalPutInitalValue;
  Color textfiledcolor = HexColor("#edf1f7");
  Color texticoncolor = HexColor("#64657b");
  @override
  void initState() {
    internalDefaultConfig = widget.defaultConfig;
    internalPutInitalValue = widget.putInitalValue;
    internalEnable = widget.enable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return internalPutInitalValue
        ? Container(
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
                      autofocus: false,
                      validator: widget.validator,
                      onChanged: widget.onChange,
                      style: GoogleFonts.poppins(
                          textStyle:
                          TextStyle(fontSize: 16, color: HexColor('#491d7f'))),
                      minLines: 1,
                      enabled: internalEnable,
                      initialValue: widget.initalText,
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
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            height: internalDefaultConfig ? 60.0 : widget.height,
            margin: EdgeInsets.only(top: 10, right: 10, left: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: textfiledcolor,
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
                      style: TextStyle(fontSize: 16),
                      minLines: 1,
                      enabled: internalEnable,
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
