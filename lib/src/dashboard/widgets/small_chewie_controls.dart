import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class SmallChewieControls extends StatelessWidget {
  const SmallChewieControls({super.key});

  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController.of(context);
    final videoPlayerController = chewieController.videoPlayerController;

    return ValueListenableBuilder(
      valueListenable: videoPlayerController,
      builder: (context, VideoPlayerValue value, child) {
        final videoDuration = value.duration.inMilliseconds.toDouble();

        // **Menghitung progress buffer terakhir**
        double bufferProgress = 0;
        if (value.buffered.isNotEmpty) {
          bufferProgress = value.buffered.last.end.inMilliseconds / videoDuration;
        }

        // **Menghitung progress play**
        final playProgress = value.position.inMilliseconds / videoDuration;

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Progress Bar (Buffer + Play Progress)
            Positioned(
              bottom: 5,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          // **Indikator Buffer (Background)**
                          LinearProgressIndicator(
                            value: bufferProgress.clamp(0.0, 1.0), // Pastikan tidak lebih dari 1.0
                            backgroundColor: Colors.grey[600],
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white70),
                          ),
                          // **Indikator Play Progress (Foreground)**
                          LinearProgressIndicator(
                            value: playProgress.clamp(0.0, 1.0), // Pastikan tidak lebih dari 1.0
                            backgroundColor: Colors.transparent,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),

            // **Kontrol Video (Play, Pause, Forward, Rewind)**
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.replay_10, size: 20),
                    color: Colors.white,
                    onPressed: () {
                      videoPlayerController.seekTo(
                        videoPlayerController.value.position - const Duration(seconds: 10),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      value.isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 25,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      value.isPlaying
                          ? videoPlayerController.pause()
                          : videoPlayerController.play();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.forward_10, size: 20),
                    color: Colors.white,
                    onPressed: () {
                      videoPlayerController.seekTo(
                        videoPlayerController.value.position + const Duration(seconds: 10),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}