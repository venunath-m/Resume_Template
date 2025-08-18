import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AboutVideo extends StatefulWidget {
  const AboutVideo({super.key});

  @override
  State<AboutVideo> createState() => _AboutVideoState();
}

class _AboutVideoState extends State<AboutVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: 'fTBcG2gsZEQ',
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //  Control max width for large screens (e.g., desktops)
        double maxWidth = constraints.maxWidth > 600
            ? 600
            : constraints.maxWidth;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  Responsive AspectRatio instead of fixed height
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: YoutubePlayerScaffold(
                    controller: _controller,
                    aspectRatio: 16 / 9,
                    builder: (context, player) => player,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Intro',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
