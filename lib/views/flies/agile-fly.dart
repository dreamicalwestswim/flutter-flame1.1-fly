
import 'package:flame/components.dart';

import '../base/fly.dart';

class AgileFly extends Fly {

  @override
  int score = 2; // 死亡奖励分数
  @override
  double time = 4; // 飞行时间超过这个数游戏就失败了
  @override
  double descentSpeed = 300; // 下降速度
  @override
  double flightSpeed = 250; // 飞行速度
  @override
  double gravity = 16; // 重力
  @override
  double animationSpeed = 0.01; // 动画播放速度

  @override
  String name = 'agile-fly'; // 苍蝇名字

  AgileFly() : super(Vector2.all(50));

}