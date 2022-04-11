
import 'package:flame/components.dart';

import '../base/fly.dart';

class HungryFly extends Fly {
  @override
  double descentSpeed = 240; // 下降速度
  @override
  double flightSpeed = 140; // 飞行速度
  @override
  double gravity = 10; // 重力
  @override
  double animationSpeed = 0.03; // 动画播放速度
  @override
  String name = 'hungry-fly'; // 苍蝇名字

  HungryFly() : super(Vector2.all(56));


}