import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

/// 最高分数
class  HighScoreView extends TextComponent with HasGameRef{
  late int _score;

  @override
  Future<void> onLoad() async {
    Shadow shadow = const Shadow(
      blurRadius: 3,
      color: Color(0xff000000),
      offset: Offset.zero,
    );

    textRenderer = TextPaint(style: TextStyle(
      color: const Color(0xffffffff),
      fontSize: 30,
      shadows: [shadow, shadow, shadow, shadow],
    ));
    score = 0;
  }

  int get score {
    return _score;
  }

  set score(int s) {
    _score = s;
    text = '最高分数: ' + _score.toString();
    x = gameRef.size.x - width - 10;
    y = 10;
  }
}