

import '../langaw-game.dart';
import '../views/base/fly.dart';

class FlySpawner {
  final LangawGame game; // 控制的游戏实例
  final int maxSpawnInterval = 3000; // 最大创建苍蝇间隔
  final int minSpawnInterval = 250; // 最小创建苍蝇间隔
  final int intervalChange = 3; // 间隔微调数
  final int maxFliesOnScreen = 7; // 屏幕内最多出现苍蝇数量
  late int currentInterval; // 当前间隔
  late int nextSpawn; // 下一次创建苍蝇时间

  FlySpawner(this.game) {
    start();
    game.addFlies();
  }

  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    for(int i = 0; i < game.fliesLayer.children.length; i++) {
      Fly fly = game.fliesLayer.children.elementAt(i) as Fly;
      fly.hit();
    }
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    // 获得活苍蝇数量
    int livingFlies = 0;
    for(int i = 0; i < game.fliesLayer.children.length; i++) {
      Fly fly = game.fliesLayer.children.elementAt(i) as Fly;
      if (!fly.isDead) livingFlies += 1;
    }

    // 时间戳达到创建下一个苍蝇的时间，并且苍蝇数量小于最大苍蝇数量就添加苍蝇
    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      game.addFlies();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}