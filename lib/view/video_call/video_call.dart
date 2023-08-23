// ignore_for_file: unused_field, avoid_print, unused_element, unnecessary_null_comparison

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import 'package:agora_uikit/agora_uikit.dart';
import "package:vc/helper/caching_data.dart";

class VideoCallScreen extends StatefulWidget {
  final String channelName;
  final String userName;
  final String token;
  final RtcEngine rtcEngine;
  const VideoCallScreen(
      {super.key,
      required this.channelName,
      required this.token,
      required this.userName,
      required this.rtcEngine});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
// Initialize the Agora Engine
  late final int _remoteUid = 0;
  // late RtcEngine _engine;
  final bool _localUserJoined = false;
// Instantiate the client
  late AgoraClient client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "67fe9c8bc05147859014018c7243c854",
        channelName: widget.channelName,
        username: loginData!.userData.name,
        uid: loginData!.userData.id,
        tempToken: widget.token,
      ),
      enabledPermission: [
        Permission.camera,
        Permission.microphone,
      ],
      agoraEventHandlers: AgoraRtcEventHandlers(
        onError: (err, msg) {
          print('Error => ${err.toString()} \n Error => ${msg.toString()}');
          return;
        },
        onStreamMessageError:
            (connection, remoteUid, streamId, code, missed, cached) {
          print(
              'remoteUid => ${remoteUid.toString()} \n connection => ${connection.toString()} \n missed => ${missed.toString()}');
        },
      ));

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(client: client),
            AgoraVideoButtons(client: client),
          ],
        ),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: widget.rtcEngine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      );
    } else {
      return Text(
        'Please wait for remote user to join'.tr,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16.sp),
      );
    }
  }
}
