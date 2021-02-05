import 'package:mobx/mobx.dart';
// Include generated file
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  int selectedTab = 0;

  @action
  void selectTab(int selected) {
     selectedTab=selected;
  }
}