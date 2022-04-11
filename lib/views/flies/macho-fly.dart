
import 'package:flame/components.dart';

import '../base/fly.dart';

class MachoFly extends Fly {
  @override
  double descentSpeed = 200; // 下降速度
  @override
  double flightSpeed = 150; // 飞行速度
  @override
  double gravity = 20; // 重力
  @override
  double animationSpeed = 0.05; // 动画播放速度
  @override
  String name = 'macho-fly'; // 苍蝇名字

  MachoFly() : super(Vector2.all(76));

}