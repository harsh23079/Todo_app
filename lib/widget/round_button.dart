import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  const RoundButton(this.title, this.onTap, {super.key});

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.circular(18)),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
