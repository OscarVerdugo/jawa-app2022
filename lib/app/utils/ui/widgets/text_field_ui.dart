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
  final Color? backgroundColor;
  final bool autofocus;
  final bool withError;
  final void Function(String)? onChanged;

  UITextField(
      {this.controller,
      this.validator,
      this.readonly = false,
      this.password = false,
      this.autofocus = false,
      this.withError = true,
      required this.label,
      this.inputType,
      this.backgroundColor,
      this.onChanged,
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
            onChanged: widget.onChanged,
            autofocus: widget.autofocus,
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
                hintText: widget.placeholder,
                hintStyle:
                    textStyle.inputText.copyWith(color: UIColors.darkColor60),
                suffixIcon: suffixIcon,
                errorStyle:
                    TextStyle(color: UIColors.red, fontWeight: FontWeight.w600),
                helperText: widget.withError ? ' ' : null,
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
    return widget.backgroundColor ?? UIColors.white;
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
