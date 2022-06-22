import 'package:flutter/material.dart';
import 'package:jawa_app/app/utils/ui/ui.dart';

class UICardLoading extends StatelessWidget {
  const UICardLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UICardWrapper(
        color: UIColors.darkColor05,
        child: Center(
          child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                  color: UIColors.blue, strokeWidth: 3)),
        ));
  }
}
