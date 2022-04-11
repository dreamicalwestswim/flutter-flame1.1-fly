
import 'package:flame/components.dart';
import '../base/sprite-basics.dart';

class CreditsButton extends SpriteBasics with HasGameRef {

  @override
  Future<void> onLoad() async{
    sprite = await Sprite.load('ui/icon-credits.png');
    // 计算与屏幕宽度的比例
    double widthScale = (gameRef.size.x / 9) / sprite!.srcSize.x;
    // 按屏幕宽度比例显示
    double imgWidth = sprite!.srcSize.x * widthScale;
    double imgHeight = sprite!.srcSize.y * widthScale;
    size = Vector2(imgWidth, imgHeight);
    x = gameRef.size.x - imgWidth - 10;
    y = gameRef.size.y - imgHeight - 10;
  }

}