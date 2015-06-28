part of battlecore;

class BattleTimerEvent
{

  static const String PROGRESS = "progress";
  static const String COMPLETE = "complete";

  String type;
  BattleTimer target;
  num percentage;
  Character character;

  BattleTimerEvent(this.type, this.target, {num percentage: null,
  Character character: null})
  {
    this.percentage = percentage;
    this.character = character;
  }
}