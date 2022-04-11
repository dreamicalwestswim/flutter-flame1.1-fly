
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:fly/views/base/text-basics.dart';

/// 分数
class ScoreView extends TextBasics with HasGameRef{
  late int _score;

  @override
  Future<void> onLoad() async {
    textRenderer = TextPaint(style: TextStyle(
        fontSize: 90,
        color: BasicPalette.white.color,
        shadows: const <Shadow>[
          Shadow(
            blurRadius: 7,
            color: Color(0xff000000),
            offset: Offset(3, 3),
          ),
        ]
    ));
    score = 0;
  }

  int get score {
    return _score;
  }

  set score(int s) {
    _score = s;
    text = _score.toString();
    x = (gameRef.size.x / 2) - (width / 2);
    y = (gameRef.size.y * .25) - (height / 2);
  }
}