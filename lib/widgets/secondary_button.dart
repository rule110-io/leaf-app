

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget{
  SecondaryButton({required this.onPressed, required this.text});
  final GestureTapCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context){
    return TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              )
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.5);
              } else if (states.contains(MaterialState.disabled)) {
                return Colors.transparent;
              }
              return const Color(0xffe5f1fd); // Use the component's default.
            },
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text, style: TextStyle(
                  color: Color(0xff2a2a2a)))
            ],
          ),
        ),
        onPressed: onPressed
    );
  }
}