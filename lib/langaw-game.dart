
import 'dart:math';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:fly/views/ui/highscore-view.dart';
import 'package:fly/views/ui/score-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio/bgm.dart';
import 'enum/GameStatus.dart';
import 'views/bg/backyard.dart';
import 'views/flies/agile-fly.dart';
import 'views/flies/drooler-fly.dart';
import 'views/base/fly.dart';
import 'views/flies/house-fly.dart';
import 'views/flies/hungry-fly.dart';
import 'views/flies/macho-fly.dart';
import 'views/ui/credits-view.dart';
import 'views/ui/help-view.dart';
import 'views/ui/home-view.dart';
import 'views/ui/lost-view.dart';
import 'views/ui/credits-button.dart';
import 'views/ui/help-button.dart';
import 'views/ui/start-button.dart';
import 'views/ui/music-button.dart';
import 'views/ui/sound-button.dart';
import 'controllers/spawner.dart';

class LangawGame extends FlameGame with TapDetector, FPSCounter  {
  static final fpsTextPaint = TextPaint(
    style: TextStyle(color: Color(0xFF000000))
  );

  /// 静态属性，方便其他模块访问(尽量避免直接将实例传给其他模块直接调用)
  static final random = Random();
  static GameStatus status = GameStatus.home;

  late PositionComponent fliesLayer;
  late PositionComponent uiLayer;
  late HomeView homeView;
  late LostView lostView;
  late HelpView helpView;
  late CreditsView creditsView;
  late CreditsButton creditsButton;
  late HelpButton helpButton;
  late StartButton startButton;
  late ScoreView scoreView;
  late HighScoreView highScoreView;
  late MusicButton musicButton;
  late SoundButton soundButton;

  late FlySpawner spawner;

  late final SharedPreferences storage;


  @override
  bool debugMode = false;

  LangawGame(this.storage);

  @override
  Future<void> onLoad() async {
    Backyard bg = Backyard();
    add(bg);

    /// 通过层管理显示对象,可以很好的控制层级关系，和非常方便的操控子元素
    fliesLayer = PositionComponent();
    add(fliesLayer);

    uiLayer = PositionComponent();
    add(uiLayer);

    homeView = HomeView();
    lostView = LostView();
    helpView = HelpView();
    creditsView = CreditsView();
    creditsButton = CreditsButton();
    helpButton = HelpButton();
    startButton = StartButton();
    scoreView = ScoreView();
    uiLayer.addAll([homeView,lostView,helpView,creditsView,creditsButton,helpButton,startButton,scoreView]);

    musicButton = MusicButton();
    add(musicButton);
    soundButton = SoundButton();
    add(soundButton);

    highScoreView = HighScoreView();
    add(highScoreView);
    highScoreView.score = (storage.getInt('highScore') ?? 0);

    /// 控制器可直接接收实例控制并操作，其他模块应避免这种传递方式，否则项目大的话流程会变的非常混乱。
    /// 不同模块消息传递应走事件派发，原版教程里面直接主实例传给各个子模块直接调用，鄙人实在接收不了这种方式。
    spawner = FlySpawner(this);

    BGM.play(0, .1);
  }

  /// 添加苍蝇
  void addFlies() async{
    late Fly fly;
    switch (random.nextInt(5)) {
      case 0:
        fly = HouseFly();
        break;
      case 1:
        fly = DroolerFly();
        break;
      case 2:
        fly = AgileFly();
        break;
      case 3:
        fly = MachoFly();
        break;
      case 4:
        fly = HungryFly();
        break;
    }
    fly.x = random.nextDouble() * (size.x - fly.width);
    fly.y = random.nextDouble() * (size.y - fly.height);
    fliesLayer.add(fly);
  }

  /// 按下检测
  @override
  bool onTapDown(TapDownInfo event) {
    bool isHandled = false;

    // 对话框
    if (!isHandled) {
      if (status == GameStatus.help || status == GameStatus.credits) {
        status = GameStatus.home;
        isHandled = true;
      }
    }

    // 帮助按钮
    if (!isHandled && helpButton.containsPoint(event.eventPosition.game)) {
      if (status == GameStatus.home || status == GameStatus.lost) {
        status = GameStatus.help;
        isHandled = true;
      }
    }

    // 音效 button
    if (!isHandled && musicButton.containsPoint(event.eventPosition.game)) {
      musicButton.onTapDown();
      isHandled = true;
    }

    // 背景音乐 button
    if (!isHandled && soundButton.containsPoint(event.eventPosition.game)) {
      soundButton.onTapDown();
      isHandled = true;
    }

    // credits 按钮
    if (!isHandled && creditsButton.containsPoint(event.eventPosition.game)) {
      if (status == GameStatus.home || status == GameStatus.lost) {
        status = GameStatus.credits;
        isHandled = true;
      }
    }

    // 开始按钮
    if (!isHandled && startButton.containsPoint(event.eventPosition.game)) {
      if (status == GameStatus.home || status == GameStatus.lost) {
        startGame();
        isHandled = true;
      }
    }

    // 苍蝇
    if (!isHandled) {
      bool didHitAFly = false;
      for(int i = 0; i < fliesLayer.children.length; i++) {
        Fly fly = fliesLayer.children.elementAt(i) as Fly;
        if(!fly.isDead && fly.containsPoint(event.eventPosition.game)){
          if (soundButton.isEnabled) FlameAudio.play('sfx/ouch' + (LangawGame.random.nextInt(11) + 1).toString() + '.ogg');
          fly.hit();
          calcScore(fly.score);
          isHandled = true;
          didHitAFly = true;
        }
      }
      // 开始游戏状态，未击中苍蝇游戏失败
      if (status == GameStatus.playing && !didHitAFly) {
        status = GameStatus.lost;
      }
    }

    return true;
  }

  /// 开始游戏
  void startGame() {
    status = GameStatus.playing;
    scoreView.score = 0;
    spawner.start();
    BGM.play(1, .1);
  }

  /// 游戏结束
  void gameOver() {
    print('游戏结束');
    if(soundButton.isEnabled) FlameAudio.play('sfx/haha' + (random.nextInt(5) + 1).toString() + '.ogg');
    BGM.stop();
  }

  /// 计算分数
  void calcScore(int score) {
    // 游戏进行中才计算分数
    if (status == GameStatus.playing) {
      scoreView.score += score;
      if (scoreView.score > (storage.getInt('highScore') ?? 0)) {
        storage.setInt('highScore', scoreView.score);
        highScoreView.score = scoreView.score;
      }
    }
  }

  /// 根据游戏状态更新ui显示
  var lastStatus;
  void updateView() {
    if(lastStatus == status)return;
    lastStatus = status;
    uiLayer.children.forEach((dynamic element) => element.visible = false);

    if(status == GameStatus.home || status == GameStatus.lost){
      startButton.visible = helpButton.visible = creditsButton.visible = true;
      if(status == GameStatus.home) {
        homeView.visible = true;
      } else {
        lostView.visible = true;
        gameOver();
      }
    } else if (status == GameStatus.help) {
      helpView.visible = true;
    } else if (status == GameStatus.credits) {
      creditsView.visible = true;
    } else if(status == GameStatus.playing) {
      scoreView.visible = true;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    spawner.update(dt);
    updateView();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (debugMode) {
      fpsTextPaint.render(canvas, 'FPS：'+fps(120).toString(), Vector2(10, 10));
    }
  }

}