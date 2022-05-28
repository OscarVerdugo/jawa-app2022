import 'package:flutter/material.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';

class UITextField extends StatefulWidget {
  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final bool readonly;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final bool password;

  UITextField(
      {this.controller,
      this.validator,
      this.readonly = false,
      this.password = false,
      required this.label,
      this.inputType,
      this.placeholder});

  @override
  State<UITextField> createState() => _UITextFieldState();
}

class _UITextFieldState extends State<UITextField> {
  late UIText textStyle;
  bool? visible;
  @override
  Widget build(BuildContext context) {
    visible ??= !widget.password;
    textStyle = UIText(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5, bottom: 2),
          child: Text(
            " ${widget.label}",
            style: textStyle.inputTextLabel,
          ),
        ),
        TextFormField(
            readOnly: widget.readonly,
            enabled: !widget.readonly,
            keyboardType: widget.inputType,
            autocorrect: false,
            enableSuggestions: false,
            controller: widget.controller,
            obscureText: !(visible ?? false),
            cursorColor: cursorColor,
            validator: widget.validator,
            style: textStyle.inputText,
            decoration: InputDecoration(
                suffixIcon: suffixIcon,
                errorStyle:
                    TextStyle(color: UIColors.red, fontWeight: FontWeight.w600),
                helperText: ' ',
                isDense: true,
                filled: true,
                fillColor: fillColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none)))
      ],
    );
  }

  Color get fillColor {
    if (widget.validator != null && widget.controller != null) {
      if (widget.controller!.text.isNotEmpty &&
          widget.validator!(widget.controller!.text) != null) {
        return UIColors.red.withOpacity(0.2);
      }
    }
    return UIColors.white;
  }

  Color? get cursorColor {
    if (widget.validator != null && widget.controller != null) {
      if (widget.controller!.text.isNotEmpty &&
          widget.validator!(widget.controller!.text) != null) {
        return UIColors.red;
      }
    }
    return UIColors.darkBlue;
  }

  IconButton? get suffixIcon {
    if (widget.password) {
      return IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            setState(() {
              visible = !(visible ?? false);
            });
          },
          icon: Icon(
              !(visible ?? false)
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              color: UIColors.darkBlue));
    }
    return null;
  }
}
