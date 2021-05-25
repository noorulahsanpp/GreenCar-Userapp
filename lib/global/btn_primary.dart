import 'package:user_app/theme/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BtnPrimary extends StatelessWidget {
  const BtnPrimary({
    Key key,
    this.color = Colors.blue,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
