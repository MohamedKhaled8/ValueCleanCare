import 'package:audioplayers/audioplayers.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:flutter/material.dart';

import '../../../theme/constant/const_colors.dart';

class AudioChatBubble extends StatefulWidget {
  final String audio;
  final bool sender;

  const AudioChatBubble({
    super.key,
    required this.audio,
    required this.sender,
  });

  @override
  State<AudioChatBubble> createState() => _AudioChatBubbleState();
}

class _AudioChatBubbleState extends State<AudioChatBubble> {
  final AudioPlayer player = AudioPlayer();
  Duration position = const Duration();
  Duration duration = const Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;
  double currentTime = 0.0;
  String timerText = '0:00';
  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    if (widget.audio.contains('http')) {
      await player.setSourceUrl(widget.audio);
    } else {
      await player.setSourceDeviceFile(widget.audio);
    }

    duration = (await player.getDuration())!;
    setState(() {
      timerText = formatDuration(duration);
    });
  }

  @override
  Widget build(BuildContext context) {
    double positionInSeconds = position.inSeconds.toDouble();
    double durationInSeconds = duration.inSeconds.toDouble();
    if (positionInSeconds < 0.0) positionInSeconds = 0.0;
    if (positionInSeconds > durationInSeconds) {
      positionInSeconds = durationInSeconds;
    }
    return GestureDetector(
      child: BubbleNormalAudio(
        color: widget.sender
            ? ColorApp.primary.withOpacity(0.9)
            : ColorApp.buttonBlue,
        position: positionInSeconds,
        duration: durationInSeconds,
        isPlaying: isPlaying,
        isLoading: isLoading,
        isPause: isPause,
        onSeekChanged: (value) async {
          currentTime = value;
          position = Duration(seconds: value.toInt());
          await player.seek(position);
          setState(() {
            timerText = formatDuration(position);
          });
        }, //_changeSeek
        onPlayPauseButtonClick: () async {
          if (!isPlaying) {
            isPlaying = true;
            isPause = false;
            if (player.state == PlayerState.playing) {
              // kSnackBarError(context: context);
            }
            await player.resume();
            player.onPositionChanged.listen((event) {
              position = event;
              currentTime = position.inSeconds.toDouble();
              setState(() {
                timerText = formatDuration(position);
              });
            });

            player.onPlayerComplete.listen((event) {
              position = const Duration(seconds: 0);
              isPlaying = false;
              isPause = false;
              setState(() {
                timerText = formatDuration(position);
              });
            });
          } else {
            isPause = true;
            isPlaying = false;
            await player.pause();
          }
          setState(() {});
        },
        isSender: widget.sender,
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
