import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Venunath M',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Software Developer\nPerigandur P.O, Thrissur, 680581\nEmail: venunathm30@gmail.com\nPhone: 8590216646, 9446224036',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Highly skilled and motivated Angular and ASP.NET Core developer with 3 years of experience in designing, developing, and deploying robust web applications. Proficient in Flutter and Firebase, with a proven track record of creating efficient, scalable, and maintainable solutions while adhering to best coding practices and software development methodologies. Adept at collaborating with cross-functional teams to deliver high-quality software products on schedule.',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
