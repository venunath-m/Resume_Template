import 'package:flutter/material.dart';

class LayoutWrapper extends StatelessWidget {
  final Widget sidebar;
  final Widget content;

  const LayoutWrapper({
    super.key,
    required this.sidebar,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // For small screens, use Column (sidebar on top)
    if (width < 700) {
      return Column(
        children: [
          SizedBox(height: 70, child: sidebar),
          Expanded(child: content),
        ],
      );
    }

    // For larger screens, use Row (sidebar left, content right)
    return Row(
      children: [
        Container(
          width: 250, // fixed width sidebar
          color: Theme.of(context).colorScheme.primaryContainer,
          child: sidebar,
        ),
        Expanded(child: content),
      ],
    );
  }
}
