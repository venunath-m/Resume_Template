import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resume/layout/layout_Wrapper.dart';
import 'package:resume/sections/about_Section.dart';
import 'package:resume/sections/about_Video.dart';
import 'package:resume/sections/education_Section.dart';
import 'package:resume/sections/experience_Section.dart';
import 'package:resume/sections/projects_Section.dart';
import 'package:resume/sections/skills_Section.dart';
import 'package:resume/utils/theme_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // GlobalKeys for each section
  final _aboutKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _aboutVideo = GlobalKey();
  // Helper to scroll to widget by key
  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth < 600; // adjust threshold as needed

    final sidebarContent = ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextButton(
          onPressed: () => scrollToSection(_aboutKey),
          child: Text(
            'About',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Makes text bold
              fontSize: 16, // Slightly bigger font size
              color: Theme.of(context)
                  .colorScheme
                  .primary, // Use theme primary color or any color you want
            ),
          ),
        ),
        TextButton(
          onPressed: () => scrollToSection(_aboutVideo),
          child: Text(
            'Intro',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Makes text bold
              fontSize: 16, // Slightly bigger font size
              color: Theme.of(context)
                  .colorScheme
                  .primary, // Use theme primary color or any color you want
            ),
          ),
        ),
        TextButton(
          onPressed: () => scrollToSection(_experienceKey),
          child: Text(
            'Experience',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Makes text bold
              fontSize: 16, // Slightly bigger font size
              color: Theme.of(context)
                  .colorScheme
                  .primary, // Use theme primary color or any color you want
            ),
          ),
        ),
        TextButton(
          onPressed: () => scrollToSection(_educationKey),
          child: Text(
            'Education',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Makes text bold
              fontSize: 16, // Slightly bigger font size
              color: Theme.of(context)
                  .colorScheme
                  .primary, // Use theme primary color or any color you want
            ),
          ),
        ),
        TextButton(
          onPressed: () => scrollToSection(_skillsKey),
          child: Text(
            'Skills',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Makes text bold
              fontSize: 16, // Slightly bigger font size
              color: Theme.of(context)
                  .colorScheme
                  .primary, // Use theme primary color or any color you want
            ),
          ),
        ),
        TextButton(
          onPressed: () => scrollToSection(_projectsKey),
          child: Text(
            'Projects',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Makes text bold
              fontSize: 16, // Slightly bigger font size
              color: Theme.of(context)
                  .colorScheme
                  .primary, // Use theme primary color or any color you want
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: Text(
          'Resume',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Makes text bold
            fontSize: 24, // Slightly bigger font size
            color: Theme.of(context)
                .colorScheme
                .primary, // Use theme primary color or any color you want
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () => ref.read(themeNotifierProvider.notifier).toggle(),
          ),
        ],
        // Show menu icon on mobile to open drawer
        leading: isMobile
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
      ),
      drawer: isMobile
          ? Drawer(child: sidebarContent, backgroundColor: Colors.teal.shade700)
          : null,
      body: isMobile
          ? // Mobile: show content full width
            SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              child: _buildContentColumn(),
            )
          : // Desktop/tablet: show sidebar + content side by side
            Row(
              children: [
                SizedBox(width: 250, child: sidebarContent),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(20),
                    child: _buildContentColumn(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildContentColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionContainer(
          key: _aboutKey,
          title: 'About',
          child: const AboutSection(),
        ),
        SectionContainer(
          key: _aboutVideo,
          title: 'Intro',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [SizedBox(height: 40, width: 40), AboutVideo()],
          ),
        ),
        SectionContainer(
          key: _experienceKey,
          title: 'Experience',
          child: const ExperienceSection(),
        ),
        SectionContainer(
          key: _educationKey,
          title: 'Education',
          child: const EducationSection(),
        ),
        SectionContainer(
          key: _skillsKey,
          title: 'Skills',
          child: const SkillsSection(),
        ),
        SectionContainer(
          key: _projectsKey,
          title: 'Projects',
          child: const ProjectsSection(),
        ),
      ],
    );
  }
}

class SectionContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionContainer({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
