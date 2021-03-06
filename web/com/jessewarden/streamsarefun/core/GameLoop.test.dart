library gamelooptests;

import "package:test/test.dart";
import 'streamscore.dart';


void main() {
  group("GameLoop Tests", ()
  {
    test("basic test", ()
    {
      expect(true, true);
    });

    test("basic matcher works", ()
    {
      expect(true, isNotNull);
    });

    test("GameLoop starts and generats a tick using our mocked window", () async
    {
      bool called = false;
      GameLoop gameLoop = new GameLoop();
      gameLoop.start();
     await gameLoop.stream.listen((GameLoopEvent event)
      {
        called = true;
      });

      expect(called, isTrue);
    });
  });
}
