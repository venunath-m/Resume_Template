// ----------------------------
// Thumbnail Card Widget
// ----------------------------
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfThumbnailCard extends StatefulWidget {
  final String assetPath;
  const PdfThumbnailCard({super.key, required this.assetPath});

  @override
  State<PdfThumbnailCard> createState() => _PdfThumbnailCardState();
}

class _PdfThumbnailCardState extends State<PdfThumbnailCard> {
  PdfPageImage? firstPageImage;

  @override
  void initState() {
    super.initState();
    _loadFirstPage();
  }

  Future<void> _loadFirstPage() async {
    final doc = await PdfDocument.openAsset(widget.assetPath);
    final page = await doc.getPage(1);
    final pageImage = await page.render(
      width: 300,
      height: 400,
    ); // thumbnail size
    await page.close();
    if (mounted) {
      setState(() {
        firstPageImage = pageImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(8),
        child: firstPageImage == null
            ? const Center(child: CircularProgressIndicator())
            : Image.memory(firstPageImage!.bytes, fit: BoxFit.contain),
      ),
    );
  }
}
