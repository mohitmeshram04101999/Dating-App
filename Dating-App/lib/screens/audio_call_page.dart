import 'package:dating_app/app_id.dart';
import 'package:dating_app/datas/user.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math' as math;

import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class AudioCallingScreen extends StatefulWidget {
  const AudioCallingScreen({super.key, required this.user});
  final User user;
  @override
  State<AudioCallingScreen> createState() => _AudioCallingScreenState();
}

final userId = math.Random().nextInt(1000).toString();

class _AudioCallingScreenState extends State<AudioCallingScreen> {
  void initialize() {
    ZegoExpressEngine.instance.loginRoom('roomID1212',
        ZegoUser(widget.user.userId.toString(), widget.user.userFullname));
    ZegoExpressEngine.instance.startPublishingStream('streamId');
    ZegoExpressEngine.instance
        .startPlayingStream("vle5Kdfu46SMoNcF0it0tVrjmxo1"); //target userid
    //for end call
    // ZegoExpressEngine.instance.stopPublishingStream();
    // ZegoExpressEngine.instance.stopPlayingStream(targetUserID);
    // ZegoExpressEngine.instance.logoutRoom(roomID);
  }

  final callIdContr = TextEditingController();
  final videocallcontr = TextEditingController();
  @override
  void initState() {
    // initialize();
    // TODO: implement initState
    onUserLogin(UserModel().user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Call'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Call Id', border: OutlineInputBorder()),
              controller: callIdContr,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AudioCallPage(
                            user: widget.user,
                            callingId: callIdContr.text.toString()),
                      ));
                },
                child: Text('Call')),
           ZegoSendCallInvitationButton(
   isVideoCall: false,
   resourceID: "zegouikit_call",    // For offline call notification
   invitees: [
      ZegoUIKitUser(
         id: widget.user.userId,
         name: widget.user.userFullname,
      ),
     // ...
      // ZegoUIKitUser(
      //    id: targetUserID,
      //    name: targetUserName,
      // )
   ],
),
//For video Calling
            TextFormField(
              decoration: InputDecoration(
                  hintText: ' Video Call Id', border: OutlineInputBorder()),
              controller: videocallcontr,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoCallPage(
                            callingId2: videocallcontr.text.toString()),
                      ));
                },
                child: Text(' video Call')),
          ],
        ),
      ),
    );
  }
}

class AudioCallPage extends StatelessWidget {
  final String callingId;
  final User user;
  const AudioCallPage({super.key, required this.callingId, required this.user});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: AppId,
        appSign: Appsign,
        callID: callingId,

        userID: user.userId,
        userName: user.userFullname, config: ZegoUIKitPrebuiltCallConfig(),
      ),
    );
  }
}

// class Example extends StatelessWidget {
//   final String callingId;
//  final User user;
//   Example({super.key, required this.callingId, required this.user});
//    void func(){
//     return;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ZagoUIKitPrebuild,
//     );
//   }
// }

//For video Calling
class VideoCallPage extends StatelessWidget {
  final String callingId2;
  const VideoCallPage({super.key, required this.callingId2});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 1,
        appSign: 'jdnjdn',
        callID: callingId2,
        config: ZegoUIKitPrebuiltCallConfig(),
        // config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        //   ..onOnlySelfInRoom = ((context) => Navigator.pop(context)),
        userID: userId,
        userName: 'username_' + userId.toString(),
      ),
    );
  }
}
