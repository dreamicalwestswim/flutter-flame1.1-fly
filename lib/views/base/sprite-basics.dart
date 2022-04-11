
import 'dart:ui';

import 'package:flame/components.dart';

abstract class SpriteBasics extends SpriteComponent{
  bool visible = false;

  /// 控制渲染
  @override
  void render(Canvas canvas) {
    if(!visible)return;
    super.render(canvas);
  }
}