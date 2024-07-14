import 'package:flutter/material.dart';
class Roundbutton extends StatelessWidget {
  final bool loading;
  final String title;
  final VoidCallback ontap;
  const Roundbutton({
    super.key,
    required this.title,
    required this.ontap,
    this.loading = false,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.teal,

        ),
        child: Center(child: loading? CircularProgressIndicator(color: Colors.white,): Text(title, style: TextStyle(color: Colors.white),)),
      ),
    );
  }
}
