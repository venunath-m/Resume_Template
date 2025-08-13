import 'package:flutter/material.dart';

Widget experienceItem({
  required String title,
  required String company,
  required String date,
  required List<String> responsibilities,
  required TextStyle? textStyle,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: textStyle?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      Text(company, style: textStyle?.copyWith(fontStyle: FontStyle.italic)),
      Text(date, style: textStyle?.copyWith(color: Colors.grey[600])),
      const SizedBox(height: 8),
      ...responsibilities.map(
        (r) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('•  ', style: TextStyle(fontSize: 20)),
              Expanded(child: Text(r, style: textStyle)),
            ],
          ),
        ),
      ),
    ],
  );
}
