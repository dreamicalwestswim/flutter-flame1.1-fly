import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

class CalloutView extends SpriteComponent{
  late TextComponent textView;

  CalloutView(){
    textView = TextComponent(textRenderer: TextPaint(style: TextStyle(
      fontSize: 14,
      color: BasicPalette.black.color,
    )));
  }

  @override
  Future<void> onLoad() async{
    sprite = await Sprite.load('ui/callout.png');
    double widthScale = 20 / sprite!.srcSize.x;
    double imgWidth = sprite!.srcSize.x * widthScale;
    double imgHeight = sprite!.srcSize.y * widthScale;
    size = Vector2(imgWidth, imgHeight);

    add(textView);
  }

  set value(double v) {
    textView.text = v.toInt().toString();
    textView.x = (width - textView.width) / 2;
  }

}