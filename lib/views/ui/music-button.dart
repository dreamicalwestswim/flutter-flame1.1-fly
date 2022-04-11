

import 'package:flame/components.dart';
import 'package:flame/input.dart';

import '../../audio/bgm.dart';

class MusicButton extends SpriteComponent with HasGameRef {
  bool isEnabled = true;
  late final Sprite enabledSprite;
  late final Sprite disabledSprite;

  @override
  Future<void> onLoad() async{
    enabledSprite = await Sprite.load('ui/icon-music-enabled.png');
    disabledSprite = await Sprite.load('ui/icon-music-disabled.png');
    // 计算与屏幕宽度的比例
    double widthScale = (gameRef.size.x / 10) / enabledSprite.srcSize.x;
    // 按屏幕宽度比例显示
    double imgWidth = enabledSprite.srcSize.x * widthScale;
    double imgHeight = enabledSprite.srcSize.y * widthScale;
    size = Vector2(imgWidth, imgHeight);
    x = 10;
    y = 10;
    toggleState();
  }

  void toggleState() {
    if(isEnabled){
      sprite = enabledSprite;
      BGM.resume();
    } else {
      sprite = disabledSprite;
      BGM.pause();
    }
  }

  bool onTapDown() {
    isEnabled = !isEnabled;
    toggleState();
    return true;
  }

}
