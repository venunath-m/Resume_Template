import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  Widget _skillCategory(
    BuildContext context,
    String title,
    List<String> skills,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: skills
                .map(
                  (skill) => Chip(
                    label: Text(skill),
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _skillCategory(context, "Programming Languages", [
          "C#",
          "Dart",
          "JavaScript",
          "TypeScript",
          "SQL",
          "Python",
        ]),
        _skillCategory(context, "Frontend Frameworks/Libraries", [
          "Angular",
          "Angular.js",
          "React.js",
          "Flutter",
          "CSS3",
          "HTML5",
        ]),
        _skillCategory(context, "Backend Frameworks/Technologies", [
          ".NET Core",
          ".NET Framework",
          "ASP.NET Core",
        ]),
        _skillCategory(context, "Databases", [
          "Microsoft SQL Server",
          "Firebase",
        ]),
        _skillCategory(context, "Testing", ["XUnit", "Unit Testing"]),
        _skillCategory(context, "Version Control", ["Git"]),
        _skillCategory(context, "Tools & Methodologies", [
          "Agile",
          "Scrum",
          "RESTful APIs",
          "SDLC",
          "Debugging",
          "Performance Optimization",
        ]),
      ],
    );
  }
}
