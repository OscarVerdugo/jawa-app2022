import 'package:flutter/material.dart';
import 'package:jawa_app/app/utils/ui/color_ui.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';

class UIAlert extends StatelessWidget {
  final String title;
  final String message;
  final UISamllButton accept;
  final UISamllButton? back;
  const UIAlert(
      {Key? key,
      required this.title,
      required this.message,
      required this.accept,
      this.back})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyles = UIText(context);
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: UIColors.white,
        clipBehavior: Clip.hardEdge,
        child: Container(
          padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 16),
          width: size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textStyles.h5),
              SizedBox(height: 4),
              Text(message, style: textStyles.inputText),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [if (back != null) back!, SizedBox(width: 8), accept],
              )
            ],
          ),
        ),
      ),
    );
  }
}
