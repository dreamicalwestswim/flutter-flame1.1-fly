
import 'package:flame/components.dart';

import '../base/fly.dart';

class DroolerFly extends Fly {
  @override
  double descentSpeed = 250; // 下降速度
  @override
  double flightSpeed = 150; // 飞行速度
  @override
  double gravity = 18; // 重力
  @override
  double animationSpeed = 0.02; // 动画播放速度
  @override
  String name = 'drooler-fly'; // 苍蝇名字

  DroolerFly() : super( Vector2.all(70));


}