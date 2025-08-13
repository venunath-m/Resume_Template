import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resume/constants/themes.dart';
import 'package:resume/pages/home_page.dart';
import 'package:resume/utils/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const HomePage(),
    );
  }
}
