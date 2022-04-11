
import 'dart:ui';

import 'package:flame/components.dart';

abstract class TextBasics extends TextComponent{
  bool visible = false;

  /// 控制渲染
  @override
  void render(Canvas canvas) {
    if(!visible)return;
    super.render(canvas);
  }
}