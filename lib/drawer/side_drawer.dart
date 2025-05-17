import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  final Widget? footer;

  const SideDrawer({
    super.key,
    this.header,
    this.body,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null) header!,
          if (body != null) Expanded(child: body!),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
