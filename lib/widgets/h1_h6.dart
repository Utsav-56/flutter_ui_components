import 'package:flutter/material.dart';

Widget _buildHeading({
  required String text,
  required double fontSize,
  FontWeight fontWeight = FontWeight.bold,
  Color color = Colors.black,
  EdgeInsetsGeometry? padding,
}) {
  final heading = Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );

  return padding != null ? Padding(padding: padding, child: heading) : heading;
}

class H1 extends StatelessWidget {
  final String text;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const H1(this.text, {super.key, this.color = Colors.black, this.padding});

  @override
  Widget build(BuildContext context) =>
      _buildHeading(text: text, fontSize: 32, color: color, padding: padding);
}

class H2 extends StatelessWidget {
  final String text;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const H2(this.text, {super.key, this.color = Colors.black, this.padding});

  @override
  Widget build(BuildContext context) =>
      _buildHeading(text: text, fontSize: 28, color: color, padding: padding);
}

class H3 extends StatelessWidget {
  final String text;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const H3(this.text, {super.key, this.color = Colors.black, this.padding});

  @override
  Widget build(BuildContext context) =>
      _buildHeading(text: text, fontSize: 24, color: color, padding: padding);
}

class H4 extends StatelessWidget {
  final String text;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const H4(this.text, {super.key, this.color = Colors.black, this.padding});

  @override
  Widget build(BuildContext context) =>
      _buildHeading(text: text, fontSize: 20, color: color, padding: padding);
}

class H5 extends StatelessWidget {
  final String text;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const H5(this.text, {super.key, this.color = Colors.black, this.padding});

  @override
  Widget build(BuildContext context) =>
      _buildHeading(text: text, fontSize: 18, color: color, padding: padding);
}

class H6 extends StatelessWidget {
  final String text;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const H6(this.text, {super.key, this.color = Colors.black, this.padding});

  @override
  Widget build(BuildContext context) =>
      _buildHeading(text: text, fontSize: 16, color: color, padding: padding);
}
