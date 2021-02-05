// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$selectedTabAtom = Atom(name: '_HomeStore.selectedTab');

  @override
  int get selectedTab {
    _$selectedTabAtom.reportRead();
    return super.selectedTab;
  }

  @override
  set selectedTab(int value) {
    _$selectedTabAtom.reportWrite(value, super.selectedTab, () {
      super.selectedTab = value;
    });
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void selectTab(int selected) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.selectTab');
    try {
      return super.selectTab(selected);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedTab: ${selectedTab}
    ''';
  }
}
