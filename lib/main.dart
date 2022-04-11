import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio/bgm.dart';
import 'langaw-game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 初始化
  await Flame.device.fullScreen(); // 全屏顯示
  await Flame.device.setOrientation(DeviceOrientation.portraitUp); // 設置竪屏方向
  SharedPreferences storage = await SharedPreferences.getInstance(); // 本地存储
  BGM.attachWidgetBindingListener();
  await BGM.add('bgm/home.mp3');
  await BGM.add('bgm/playing.mp3');
  final LangawGame game = LangawGame(storage);
  runApp(
      GameWidget(
          game: game
      )
  );
}

