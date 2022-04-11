

import 'package:flame/components.dart';
import 'package:flame/input.dart';

class SoundButton extends SpriteComponent with HasGameRef {
  bool isEnabled = true;
  late final Sprite enabledSprite;
  late final Sprite disabledSprite;

  @override
  Future<void> onLoad() async{
    enabledSprite = await Sprite.load('ui/icon-sound-enabled.png');
    disabledSprite = await Sprite.load('ui/icon-sound-disabled.png');
    // 计算与屏幕宽度的比例
    double widthScale = (gameRef.size.x / 10) / enabledSprite.srcSize.x;
    // 按屏幕宽度比例显示
    double imgWidth = enabledSprite.srcSize.x * widthScale;
    double imgHeight = enabledSprite.srcSize.y * widthScale;
    size = Vector2(imgWidth, imgHeight);
    x = 15 + imgWidth;
    y = 10;
    toggleState();
  }

  void toggleState() {
    sprite = isEnabled ? enabledSprite : disabledSprite;
  }

  bool onTapDown() {
    isEnabled = !isEnabled;
    toggleState();
    return true;
  }

}