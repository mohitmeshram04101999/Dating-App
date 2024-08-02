 import 'package:dating_app/datas/user.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

int AppId = 889017402;
 String Appsign ="5f2b96c2b7b7feb5863ae2a8b7c493fae9bcd24e07b7b99f39cc28c3c0b62339";
 void onUserLogin(User user) {
  /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
  /// when app's user is logged in or re-logged in
  /// We recommend calling this method as soon as the user logs in to your app.
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: AppId /*input your AppID*/,
    appSign: Appsign /*input your AppSign*/,
    userID: user.userId,
    userName: user.userFullname,
    plugins: [ZegoUIKitSignalingPlugin()],
  );

}

  // final navigatorKey = GlobalKey<NavigatorState>();