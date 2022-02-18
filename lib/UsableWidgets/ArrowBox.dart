import 'package:flutter/material.dart';

class ArrowBox extends StatelessWidget {
  ArrowBox({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);
  final Function() onPressed;
  IconData icon = Icons.chevron_right;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).appBarTheme.backgroundColor,
        ),
        height: size.height * 0.05,
        width: size.width * 0.11,
        child: Icon(icon, size: 30, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
