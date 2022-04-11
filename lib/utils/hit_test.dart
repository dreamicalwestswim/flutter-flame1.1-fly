import 'package:flame/components.dart';

/// flame自带碰撞检测，如有特殊需求可自己实现特殊的碰撞(暂时无用)
class HitTest {
  // 矩形碰撞
  static hitTestRect(PositionComponent r1, PositionComponent r2) {
    if(r1.y + r1.height < r2.y
    || r1.x > r2.x + r2.width
    || r1.y > r2.y + r2.height
    || r1.x + r1.width < r2.x){
      return false;
    }
    return true;
  }

  // 点碰撞
  static hitTestPoint(PositionComponent r1, Vector2 p) {
    if(r1.y + r1.height < p.y
        || r1.x > p.x
        || r1.y > p.y
        || r1.x + r1.width < p.x){
      return false;
    }
    return true;
  }
}