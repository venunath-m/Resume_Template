import 'package:flutter/material.dart';
import 'package:resume/sections/PDFViewerPage.dart';
import 'package:resume/sections/PdfThumbnailCard.dart';

class EducationCertificatesSection extends StatelessWidget {
  const EducationCertificatesSection({super.key});

  final List<Map<String, String>> certificates = const [
    {
      'title': 'Advanced Diploma In Computer Applications',
      'pdf': 'assets/education/crt1.pdf',
    },
    {
      'title': 'Advanced Diploma In Computer Applications Sem 1',
      'pdf': 'assets/education/crt2.pdf',
    },
    {
      'title': 'Advanced Diploma In Computer Applications Sem 2',
      'pdf': 'assets/education/crt3.pdf',
    },
  ];

  Widget buildCard(BuildContext context, Map<String, String> cert) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                cert['title']!,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              AspectRatio(
                aspectRatio: 4 / 3,
                child: PdfThumbnailCard(assetPath: cert['pdf']!),
              ),

              const SizedBox(height: 12),

              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PDFViewerPage(
                        assetPath: cert['pdf']!,
                        title: cert['title']!,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text("View Full PDF"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Education Certificates",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        LayoutBuilder(
          builder: (context, constraints) {
            // Switch to list on narrow screens
            if (constraints.maxWidth < 500) {
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: certificates
                    .map((cert) => buildCard(context, cert))
                    .toList(),
              );
            }

            // Grid for medium & large screens
            int crossAxisCount = 1;
            if (constraints.maxWidth > 1200)
              crossAxisCount = 3;
            else if (constraints.maxWidth > 700)
              crossAxisCount = 2;

            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: certificates
                  .map((cert) => buildCard(context, cert))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
