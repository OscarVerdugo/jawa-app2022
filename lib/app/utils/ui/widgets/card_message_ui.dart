import 'package:flutter/material.dart';

import '../ui.dart';

class UICardMessage extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? subMessage;
  final Color color;
  late UIText textStyles;
  UICardMessage(
      {Key? key,
      required this.message,
      required this.icon,
      this.subMessage,
      required this.color})
      : super(key: key);

  factory UICardMessage.error(
      {required String message, String? subMessage, required IconData icon}) {
    return UICardMessage(
        message: message,
        icon: icon,
        color: UIColors.red,
        subMessage: subMessage);
  }

  factory UICardMessage.warning(
      {required String message, String? subMessage, required IconData icon}) {
    return UICardMessage(
        message: message,
        icon: icon,
        color: UIColors.orange,
        subMessage: subMessage);
  }

  factory UICardMessage.info(
      {required String message, String? subMessage, required IconData icon}) {
    return UICardMessage(
        message: message,
        icon: icon,
        color: UIColors.blue,
        subMessage: subMessage);
  }

  factory UICardMessage.success(
      {required String message, String? subMessage, required IconData icon}) {
    return UICardMessage(
        message: message,
        icon: icon,
        color: UIColors.green,
        subMessage: subMessage);
  }

  factory UICardMessage.neutral(
      {required String message, String? subMessage, required IconData icon}) {
    return UICardMessage(
        message: message,
        icon: icon,
        color: UIColors.darkColor,
        subMessage: subMessage);
  }

  @override
  Widget build(BuildContext context) {
    textStyles = UIText(context);
    return UICardWrapper(
        color: color.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(icon, color: color.withOpacity(0.7), size: 45),
              SizedBox(height: 16),
              Text(message,
                  textAlign: TextAlign.center,
                  style: textStyles.itemTitle
                      .copyWith(color: color.withOpacity(0.7))),
              Text(subMessage ?? "",
                  textAlign: TextAlign.center,
                  style: textStyles.itemInfo
                      .copyWith(color: color.withOpacity(0.7)))
            ],
          ),
        ));
  }
}
