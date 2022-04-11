
import 'package:flame/components.dart';
import '../base/sprite-basics.dart';

class StartButton extends SpriteBasics with HasGameRef {

  @override
  Future<void> onLoad() async{
    sprite = await Sprite.load('ui/start-button.png');
    // 计算与屏幕宽度的比例
    double widthScale = (gameRef.size.x -150) / sprite!.srcSize.x;
    // 按屏幕宽度比例显示
    double imgWidth = sprite!.srcSize.x * widthScale;
    double imgHeight = sprite!.srcSize.y * widthScale;
    size = Vector2(imgWidth, imgHeight);
    x = (gameRef.size.x - imgWidth) / 2;
    y = gameRef.size.y * .75 -  imgHeight;
  }

}