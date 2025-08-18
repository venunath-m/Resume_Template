import 'package:flutter/material.dart';
import 'package:resume/sections/PDFViewerPage.dart';
import 'package:resume/sections/PdfThumbnailCard.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperienceCertificatesSection extends StatelessWidget {
  const ExperienceCertificatesSection({super.key});

  final List<Map<String, String>> certificates = const [
    {
      'title': 'Senior Developer - CALCUS TECHNOLOGIES',
      'pdf': 'assets/experience/exp3.pdf',
      'url': 'https://calcus.in/',
    },
    {
      'title': 'Jr. Software Engineer - Scasys Technologies',
      'pdf': 'assets/experience/exp2.pdf',
      'url': 'https://www.scasystech.com/',
    },
    {
      'title': 'Technical Supporting Executive - DukeSoft',
      'pdf': 'assets/experience/exp1.pdf',
      'url': 'https://www.dukesoft.net/',
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
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () async {
                  final url = cert['url']!;
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(
                      Uri.parse(url),
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not launch URL')),
                    );
                  }
                },
                icon: const Icon(Icons.language),
                label: const Text("Visit Company"),
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
          "Experience Certificates",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 500) {
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: certificates
                    .map((cert) => buildCard(context, cert))
                    .toList(),
              );
            }

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
