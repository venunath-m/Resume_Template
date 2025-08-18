import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PDFViewerPage extends StatelessWidget {
  final String assetPath;
  final String title;

  const PDFViewerPage({
    super.key,
    required this.assetPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Check if running on web
    final isWeb = kIsWeb;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: isWeb
          ? PdfViewWeb(assetPath: assetPath)
          : PdfViewMobile(assetPath: assetPath),
    );
  }
}

// ------------------------
// Mobile/Desktop PDF Viewer
// ------------------------
class PdfViewMobile extends StatefulWidget {
  final String assetPath;

  const PdfViewMobile({super.key, required this.assetPath});

  @override
  State<PdfViewMobile> createState() => _PdfViewMobileState();
}

class _PdfViewMobileState extends State<PdfViewMobile> {
  late PdfControllerPinch _controller;

  @override
  void initState() {
    super.initState();
    _controller = PdfControllerPinch(
      document: PdfDocument.openAsset(widget.assetPath),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PdfViewPinch(controller: _controller);
  }
}

// ------------------------
// Web PDF Viewer
// ------------------------
class PdfViewWeb extends StatelessWidget {
  final String assetPath;

  const PdfViewWeb({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return PdfView(
      controller: PdfController(document: PdfDocument.openAsset(assetPath)),
    );
  }
}
