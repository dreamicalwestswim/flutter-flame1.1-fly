
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:fly/enum/GameStatus.dart';
import 'package:fly/langaw-game.dart';
import 'package:fly/views/ui/callout-view.dart';

/// 苍蝇抽象类，实现苍蝇公共属性及行为。
abstract class Fly extends PositionComponent with HasGameRef {
  int score = 1; // 死亡奖励分数
  double time = 8; // 飞行时间超过这个数游戏就失败了
  bool isDead = false; // 是否死亡
  late double descentSpeed; // 下降速度
  late double flightSpeed; // 飞行速度
  late double gravity; // 重力
  late double animationSpeed; // 动画播放速度
  late String name; // 苍蝇名字
  late Offset targetLocation; // 目标位置
  late CalloutView calloutView; // 计时框


  late final SpriteAnimation flyAnimation;
  late final SpriteAnimation deadAnimation;
  late final SpriteAnimationComponent spriteAnimationView;

  Fly(Vector2 size):super(size: size);

  @override
  Future<void> onLoad() async{
    flyAnimation = SpriteAnimation.spriteList(
      await Future.wait([1, 2].map((i) => Sprite.load('flies/$name-$i.png'))),
      stepTime: animationSpeed,
    );

    deadAnimation = SpriteAnimation.spriteList(
      await Future.wait([Sprite.load('flies/$name-dead.png')]),
      stepTime: animationSpeed,
      loop: false,
    );

    spriteAnimationView = SpriteAnimationComponent(
        animation: flyAnimation,
        anchor: Anchor.topCenter,
        size: size
    );
    spriteAnimationView.x = width / 2;
    add(spriteAnimationView);

    calloutView = CalloutView();
    add(calloutView);

    setTargetLocation();
  }

  // 设置飞行的目标位置
  void setTargetLocation() {
    double x = LangawGame.random.nextDouble() * (gameRef.size.x - width);
    double y = LangawGame.random.nextDouble() * (gameRef.size.y - height);
    targetLocation = Offset(x, y);
  }

  // 被点击
  void hit() {
    isDead = true;
    spriteAnimationView.animation = deadAnimation;
  }

  // 更新内部状态
  @override
  void update(double dt) {
    super.update(dt);

    if(isDead){
      y += descentSpeed * dt;
      descentSpeed += gravity;
      // 超出舞台移除自身
      if(y > gameRef.size.y){
        removeFromParent();
      }
    } else {

      if(LangawGame.status == GameStatus.playing){
        // 飞行时间
        if (time > 0) {
          time = time - 1 * dt;
        } else {
          LangawGame.status = GameStatus.lost;
        }
      }
      calloutView.value = time;

      // 下一步位置
      double stepDistance = flightSpeed * dt;
      // 目标位置距离
      Offset toTarget = targetLocation - Offset(x, y);
      // 根据距离转变苍蝇方向
      if(toTarget.dx > 0){
        spriteAnimationView.scale = Vector2(-1, 1);
      } else {
        spriteAnimationView.scale = Vector2(1, 1);
      }
      // 下一步未达到目标距离
      if (stepDistance < toTarget.distance) {
        // 往目标进行移动
        Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
        x += stepToTarget.dx;
        y += stepToTarget.dy;
      } else {
        // 达到目标距离重新设置下一个位置
        x += toTarget.dx;
        y += toTarget.dy;
        setTargetLocation();
      }
    }
  }

}