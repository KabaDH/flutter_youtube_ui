import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconWithDesc extends StatelessWidget {
  final IconData iconData;
  final String msg;

  const IconWithDesc({Key? key, required this.iconData, required this.msg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: Colors.white,
          size: 20,
        ),
        SizedBox(height: 5,),
        Text(
          msg,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white),
        )
      ],
    );
  }
}
