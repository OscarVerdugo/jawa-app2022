import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui.dart';

class UIQuantityBottomSheet extends StatelessWidget {
  final TextEditingController controller;
  UIQuantityBottomSheet({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 4),
      child: UIMenuWrapper(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: UITextField(
                controller: controller,
                withError: false,
                autofocus: true,
                inputType: TextInputType.number,
                label: "Cantidad",
                backgroundColor: UIColors.darkColor10,
              )),
              Padding(
                padding: EdgeInsets.only(left: 8, bottom: 5),
                child: _sendButton(),
              )
            ],
          ),
        )
      ]),
    );
  }

  Material _sendButton() => Material(
        color: UIColors.blue,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.send_rounded, color: UIColors.white),
          ),
        ),
      );
}
