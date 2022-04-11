
import 'package:flame/components.dart';

class Backyard extends SpriteComponent with HasGameRef {

  @override
  Future<void> onLoad() async{
    sprite = await Sprite.load('bg/backyard.png');
    // 计算背景宽度与屏幕宽度的比例
    double widthScale = gameRef.size.x / sprite!.srcSize.x;
    // 按屏幕宽度比例显示
    double imgWidth = sprite!.srcSize.x * widthScale;
    double imgHeight = sprite!.srcSize.y * widthScale;
    // 控制位置与大小，将底部垃圾显示出来
    size = Vector2(imgWidth, imgHeight);
    y = gameRef.size.y - imgHeight;
  }
}