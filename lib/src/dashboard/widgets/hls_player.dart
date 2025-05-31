// ignore_for_file: use_super_parameters

import 'package:report_sarang/src/dashboard/widgets/small_chewie_controls.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class HlsPlayerWidget extends StatefulWidget {
  final String url;

  const HlsPlayerWidget({Key? key, required this.url}) : super(key: key);

  @override
  State<HlsPlayerWidget> createState() => _HlsPlayerWidgetState();
}

class _HlsPlayerWidgetState extends State<HlsPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.url));

    await _videoPlayerController.initialize();
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: true,
        aspectRatio: 16 / 9, // Set aspek rasio default
        showControlsOnInitialize: false, // Menyembunyikan kontrol saat pertama muncul
        customControls: SmallChewieControls(),
      );
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9, // Mencegah video terlalu besar
      child: _chewieController != null
          ? Chewie(controller: _chewieController!)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
