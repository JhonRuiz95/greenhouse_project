import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String tittle;
  final String subTitle;
  final Color textColor;

  const PageTitle({
    Key? key,
    required this.tittle,
    required this.subTitle,
    this.textColor = Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tittle,
              style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 10),
            Text(subTitle,
                style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
