import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  // YouTube controllers mapped by project
  late final YoutubePlayerController _requisitionController;
  late final YoutubePlayerController _integrationController;
  late final YoutubePlayerController _technicalSupportController;

  @override
  void initState() {
    super.initState();

    _requisitionController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        'https://youtu.be/QPoiqOonIro',
      )!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );

    _integrationController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        'https://youtu.be/ztXikUN8mcw',
      )!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );

    _technicalSupportController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        'https://youtu.be/DLHuyo5bVho',
      )!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _requisitionController.dispose();
    _integrationController.dispose();
    _technicalSupportController.dispose();
    super.dispose();
  }

  Widget _projectItem({
    required String title,
    required String domain,
    required String skills,
    required String role,
    required List<String> details,
    YoutubePlayerController? youtubeController,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Domain: $domain", style: theme.textTheme.bodyMedium),
          Text("Skills: $skills", style: theme.textTheme.bodyMedium),
          Text("Role: $role", style: theme.textTheme.bodyMedium),
          const SizedBox(height: 8),
          ...details.map(
            (detail) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("•  "),
                  Expanded(child: Text(detail)),
                ],
              ),
            ),
          ),
          if (youtubeController != null) ...[
            const SizedBox(height: 12),
            YoutubePlayer(
              controller: youtubeController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: theme.colorScheme.primary,
              onReady: () {
                // Optional callback when video is ready
              },
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _projectItem(
          title: "Requisition (Developer: Scasys) | Version 1 & 2",
          domain:
              "Supplier Chain (Company inventory, sales, and asset management)",
          skills:
              "C#, ASP.NET, Microsoft SQL Server, Angular.js, (.NET Core, Angular)",
          role: "Developer (Team Size: 8)",
          details: [
            "Developed and enhanced modules for supplier chain management, including inventory tracking, sales order processing, and asset management.",
            "Implemented robust data models and database interactions using Microsoft SQL Server.",
            "Designed and developed user interfaces with Angular.js and later migrated/updated components using Angular and .NET Core.",
            "Ensured efficient and secure data handling for critical business operations.",
          ],
          youtubeController: _requisitionController,
        ),
        _projectItem(
          title: "Integration (Developer: Scasys)",
          domain:
              "Supplier Chain (Integrating and syncing data with supplier and buyer)",
          skills: "C#, ASP.NET, Microsoft SQL Server, Angular.js",
          role: "Developer (Team Size: 8)",
          details: [
            "Developed and maintained integration modules to facilitate seamless data exchange between suppliers and buyers.",
            "Implemented data synchronization logic to ensure consistency and accuracy across different systems.",
            "Utilized C# and ASP.NET for backend logic and Microsoft SQL Server for data storage.",
            "Collaborated with external teams to define integration points and ensure successful data flow.",
          ],
          youtubeController: _integrationController,
        ),
        _projectItem(
          title: "Technical Support Projects (DukeSoft)",
          domain: "Finance, Pharmacy Retail, Wholesale Market",
          skills: "Various software products",
          role: "Technical Support Specialist",
          details: [
            "Ecmacs (Finance): Provided technical support and troubleshooting for a financial management software.",
            "Pharma (Pharmacy Retail and Wholesale Market): Offered technical assistance for pharmacy retail and wholesale management software.",
            "Smacs (Retail and Wholesale Market): Supported software solutions for general retail and wholesale operations.",
            "Nicsol (Finance): Delivered technical support for a finance-related application.",
          ],
          youtubeController: _technicalSupportController,
        ),
      ],
    );
  }
}
