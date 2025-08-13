import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final bool isMobile = screenWidth < 800; // Adjust threshold for mobile

    // Sidebar content
    final sidebarContent = ListView(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      children: [
        sidebarButton('About', () => scrollToSection(_aboutKey), context),
        sidebarButton('Intro', () => scrollToSection(_aboutVideo), context),
        sidebarButton(
          'Experience',
          () => scrollToSection(_experienceKey),
          context,
        ),
        sidebarButton(
          'Education',
          () => scrollToSection(_educationKey),
          context,
        ),
        sidebarButton('Skills', () => scrollToSection(_skillsKey), context),
        sidebarButton('Projects', () => scrollToSection(_projectsKey), context),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        title: Text(
          'Resume',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Theme.of(context).colorScheme.primary,
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
          ? Drawer(child: sidebarContent, backgroundColor: Colors.teal.shade50)
          : null,
      body: isMobile
          ? SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: _buildContentColumn(),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Container(
                    color: Colors.teal.shade50,
                    child: sidebarContent,
                  ),
                ),
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

  // Build main content
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
            children: const [SizedBox(height: 20), AboutVideo()],
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

// Section container with card style
class SectionContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionContainer({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade800,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(padding: const EdgeInsets.all(24), child: child),
          ),
        ],
      ),
    );
  }
}

// Sidebar button with hover and ripple effect
Widget sidebarButton(String text, VoidCallback onTap, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      hoverColor: Colors.teal.shade100.withOpacity(0.3),
      splashColor: Colors.teal.shade200,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    ),
  );
}
