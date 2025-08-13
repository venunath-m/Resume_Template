import 'package:flutter/material.dart';
import 'package:resume/constants/experience_Item.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        experienceItem(
          title: 'Senior Developer',
          company: 'Calcus Technologies, Thrissur, Kerala',
          date: 'May 2023 - Present',
          responsibilities: [
            'Led the development of mobile and web applications using Flutter, Dart, and Firebase, ensuring high performance and responsiveness.',
            'Collaborated with product managers and designers to translate business requirements into technical specifications and user-friendly interfaces.',
            'Implemented robust backend solutions and integrated third-party APIs to enhance application functionality.',
            'Conducted code reviews, mentored junior developers, and contributed to architectural decisions to maintain code quality and system scalability.',
            'Debugged and resolved complex technical issues, optimizing application performance and user experience.',
          ],
          textStyle: textStyle,
        ),
        const SizedBox(height: 20),
        experienceItem(
          title: 'Jr. Software Engineer',
          company: 'Scasys Technologies, Bangalore, Karnataka',
          date: 'July 2022 – August 2023',
          responsibilities: [
            'Developed and maintained web applications using Angular.js, Angular, React, C#, ASP.NET, and Microsoft SQL Server.',
            'Designed and implemented RESTful APIs for seamless communication between frontend and backend systems.',
            'Wrote comprehensive unit tests using XUnit to ensure code reliability and maintainability.',
            'Contributed to the full software development lifecycle, from requirements gathering to deployment and support.',
            'Collaborated effectively within an 8-member agile development team, participating in daily stand-ups and sprint planning.',
            'Utilized CSS3 for styling and ensuring cross-browser compatibility and responsive design.',
          ],
          textStyle: textStyle,
        ),
        const SizedBox(height: 20),
        experienceItem(
          title: 'Technical Supporting Executive',
          company: 'DukeSoft, Thrissur, Kerala',
          date: 'June 2016 – May 2021',
          responsibilities: [
            'Provided technical support for various software products in the Finance, Pharmacy Retail, and Wholesale Market domains.',
            'Assisted clients with software installation, configuration, and troubleshooting.',
            'Documented technical issues and solutions, contributing to a comprehensive knowledge base.',
            'Collaborated with development teams to resolve complex bugs and improve product stability.',
          ],
          textStyle: textStyle,
        ),
      ],
    );
  }
}
