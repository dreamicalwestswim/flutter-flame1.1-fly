
import 'package:flame/components.dart';

import '../base/fly.dart';

class HouseFly extends Fly {
  @override
  double descentSpeed = 280; // 下降速度
  @override
  double flightSpeed = 160; // 飞行速度
  @override
  double gravity = 17; // 重力
  @override
  double animationSpeed = 0.02; // 动画播放速度
  @override
  String name = 'house-fly'; // 苍蝇名字

  HouseFly() : super(Vector2.all(60));

}