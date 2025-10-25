import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late final YoutubePlayerController _requisitionController;
  late final YoutubePlayerController _integrationController;
  late final YoutubePlayerController _technicalSupportController;

  @override
  void initState() {
    super.initState();

    _requisitionController = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(
        'https://youtu.be/TckJ3rykjW0',
      )!,
      autoPlay: false,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    _integrationController = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(
        'https://youtu.be/IQ5pLbFMCkE',
      )!,
      autoPlay: false,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    _technicalSupportController = YoutubePlayerController.fromVideoId(
      videoId: YoutubePlayerController.convertUrlToId(
        'https://youtu.be/4O5cLfcG7pA',
      )!,
      autoPlay: false,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _requisitionController.close();
    _integrationController.close();
    _technicalSupportController.close();
    super.dispose();
  }

  Widget _projectItem({
    required String title,
    required String domain,
    required String skills,
    required String role,
    required List<String> details,
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
        ],
      ),
    );
  }

  Widget _recentProjectVideos() {
    final theme = Theme.of(context);

    Widget videoCard({
      required String title,
      required YoutubePlayerController controller,
      required String videoId,
    }) {
      return StatefulBuilder(
        builder: (context, setState) {
          bool isPlaying = false;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420, // cap card width (desktop safe)
              ),
              child: Card(
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      //  Flexible video area
                      child: isPlaying
                          ? YoutubePlayerScaffold(
                              controller: controller,
                              aspectRatio: 16 / 9,
                              builder: (context, player) => player,
                            )
                          : InkWell(
                              onTap: () => setState(() => isPlaying = true),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                    "https://img.youtube.com/vi/$videoId/hqdefault.jpg",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black45,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 48,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        title,
                        maxLines: 2, // 👈 prevent overflow
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Project Videos',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 1;
            double aspectRatio = 16 / 11; //  little taller for small screens

            if (constraints.maxWidth > 1200) {
              crossAxisCount = 3;
              aspectRatio = 16 / 9;
            } else if (constraints.maxWidth > 700) {
              crossAxisCount = 2;
              aspectRatio = 16 / 9.5;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: aspectRatio,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return videoCard(
                      title: "Chat Bot",
                      controller: _requisitionController,
                      videoId: "TckJ3rykjW0",
                    );
                  case 1:
                    return videoCard(
                      title: "CRM Project Demo",
                      controller: _integrationController,
                      videoId: "IQ5pLbFMCkE",
                    );
                  default:
                    return videoCard(
                      title: "POS Application Demo",
                      controller: _technicalSupportController,
                      videoId: "4O5cLfcG7pA",
                    );
                }
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
              "Worked With the team to Develop and enhanced modules for supplier chain management, including inventory tracking, sales order processing, and asset management.",
              "Implemented robust data models and database interactions using Microsoft SQL Server.",
              "Designed and developed user interfaces with Angular.js and later migrated/updated components using Angular and .NET Core.",
              "Ensured efficient and secure data handling for critical business operations.",
            ],
          ),
          _projectItem(
            title: "Integration (Developer: Scasys)",
            domain:
                "Supplier Chain (Integrating and syncing data with supplier and buyer)",
            skills: "C#, ASP.NET, Microsoft SQL Server, Angular.js",
            role: "Developer (Team Size: 8)",
            details: [
              "Worked With the team to Develop and maintained integration modules to facilitate seamless data exchange between suppliers and buyers.",
              "Implemented data synchronization logic to ensure consistency and accuracy across different systems.",
              "Utilized C# and ASP.NET for backend logic and Microsoft SQL Server for data storage.",
              "Collaborated with external teams to define integration points and ensure successful data flow.",
            ],
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
          ),

          const SizedBox(height: 40),

          _recentProjectVideos(),
        ],
      ),
    );
  }
}
