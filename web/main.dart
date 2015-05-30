import 'dart:html';
import 'dart:core';
import 'dart:async';
import 'dart:math';
import 'package:stagexl/stagexl.dart';
import 'com/jessewarden/streamsarefun/core/streamscore.dart';
import 'com/jessewarden/streamsarefun/battle/battlecore.dart';
import 'com/jessewarden/streamsarefun/components/components.dart';

CanvasElement canvas;
Stage stage;
RenderLoop renderLoop;
//ResourceManager resourceManager;
//CursorFocusManager cursorManager;

void main()
{
	querySelector('#output').text = 'Your Dart app is running.';

	canvas = querySelector('#stage');
	canvas.context2D.imageSmoothingEnabled = true;

	stage = new Stage(canvas, webGL: false);
	renderLoop = new RenderLoop();
	renderLoop.addStage(stage);

//	resourceManager = new ResourceManager();
//	cursorManager = new CursorFocusManager(stage, resourceManager);

	//testGameLoop();
//  testBattleTimer();
	testTextDropper();
}


void testGameLoop()
{
	GameLoop gameLoop = new GameLoop();
	gameLoop.stream.listen((GameLoopEvent event)
	{
		print("event: " + event.type);
	});
	gameLoop.start();
	new Future.delayed(new Duration(milliseconds: 300), ()
	{
		gameLoop.pause();
	});
	new Future.delayed(const Duration(milliseconds: 500), ()
	{
	});
}

void testBattleTimer()
{
	GameLoop gameLoop = new GameLoop();
	BattleTimer timer = new BattleTimer(gameLoop.stream, BattleTimer.MODE_CHARACTER);
	gameLoop.start();
	timer.start();
	timer.stream
	.where((BattleTimerEvent event)
	{
		return event.type == BattleTimerEvent.PROGRESS;
	})
	.listen((BattleTimerEvent event)
	{
		print("percent: ${event.percentage}");
	});

	new Future.delayed(new Duration(milliseconds: 300), ()
	{
		gameLoop.pause();
	});
}

void testTextDropper()
{
	Shape spot1 = new Shape();
	spot1.graphics.rectRound(0, 0, 40, 40, 6, 6);
	spot1.graphics.fillColor(Color.Blue);
	spot1.graphics.strokeColor(Color.White, 4);
	spot1.alpha = 0.4;
	stage.addChild(spot1);
	spot1.x = 40;
	spot1.y = 40;

	Shape spot2 = new Shape();
	spot2.graphics.rectRound(0, 0, 40, 40, 6, 6);
	spot2.graphics.fillColor(Color.Blue);
	spot2.graphics.strokeColor(Color.White, 4);
	spot2.alpha = 0.4;
	stage.addChild(spot2);
	spot2.x = 200;
	spot2.y = 200;

	TextDropper textDropper = new TextDropper(stage, renderLoop);

	new Stream.periodic(new Duration(seconds: 1), (_)
	{
		print("boom");
		return new Random().nextInt(9999);
	})
	.listen((int value)
	{
		print("chaka");
		textDropper.addTextDrop(spot1, value);
	});
}