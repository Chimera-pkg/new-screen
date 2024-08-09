import 'package:flutter/material.dart';
import 'package:skribex_app/utils/constant/themes.dart';

class DateTime extends StatelessWidget {
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final String label;

  const DateTime(
      {Key? key,
      required this.valueText,
      required this.valueStyle,
      required this.onPressed,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontFamily: 'MonaSans',
              fontSize: 13,
              fontWeight: bold,
              color: colorNavy),
        ),
        const SizedBox(height: 8.0),
        InkWell(
          onTap: onPressed,
          child: Container(
            height: 53,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: colorBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  valueText,
                  style: valueStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
