import 'package:event_bus/event_bus.dart';
//Bus 初始化
EventBus eventBus = EventBus();
class pointEvent {
  int point;
  pointEvent(int point){
    this.point = point;
  }
}