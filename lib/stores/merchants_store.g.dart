// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchants_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MerchantStore on _MerchantStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_MerchantStore.loading'))
      .value;

  final _$searchTextAtom = Atom(name: '_MerchantStore.searchText');

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  final _$successAtom = Atom(name: '_MerchantStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$tabAtom = Atom(name: '_MerchantStore.tab');

  @override
  int get tab {
    _$tabAtom.reportRead();
    return super.tab;
  }

  @override
  set tab(int value) {
    _$tabAtom.reportWrite(value, super.tab, () {
      super.tab = value;
    });
  }

  final _$fetchMerchantsFutureAtom =
      Atom(name: '_MerchantStore.fetchMerchantsFuture');

  @override
  ObservableFuture<List<MerchantModel>> get fetchMerchantsFuture {
    _$fetchMerchantsFutureAtom.reportRead();
    return super.fetchMerchantsFuture;
  }

  @override
  set fetchMerchantsFuture(ObservableFuture<List<MerchantModel>> value) {
    _$fetchMerchantsFutureAtom.reportWrite(value, super.fetchMerchantsFuture,
        () {
      super.fetchMerchantsFuture = value;
    });
  }

  final _$fetchMerchantsFollowFutureAtom =
      Atom(name: '_MerchantStore.fetchMerchantsFollowFuture');

  @override
  ObservableFuture<FollowModel> get fetchMerchantsFollowFuture {
    _$fetchMerchantsFollowFutureAtom.reportRead();
    return super.fetchMerchantsFollowFuture;
  }

  @override
  set fetchMerchantsFollowFuture(ObservableFuture<FollowModel> value) {
    _$fetchMerchantsFollowFutureAtom
        .reportWrite(value, super.fetchMerchantsFollowFuture, () {
      super.fetchMerchantsFollowFuture = value;
    });
  }

  final _$fetchMerchantsUnFollowFutureAtom =
      Atom(name: '_MerchantStore.fetchMerchantsUnFollowFuture');

  @override
  ObservableFuture<FollowModel> get fetchMerchantsUnFollowFuture {
    _$fetchMerchantsUnFollowFutureAtom.reportRead();
    return super.fetchMerchantsUnFollowFuture;
  }

  @override
  set fetchMerchantsUnFollowFuture(ObservableFuture<FollowModel> value) {
    _$fetchMerchantsUnFollowFutureAtom
        .reportWrite(value, super.fetchMerchantsUnFollowFuture, () {
      super.fetchMerchantsUnFollowFuture = value;
    });
  }

  final _$merchantsListAtom = Atom(name: '_MerchantStore.merchantsList');

  @override
  List<MerchantModel> get merchantsList {
    _$merchantsListAtom.reportRead();
    return super.merchantsList;
  }

  @override
  set merchantsList(List<MerchantModel> value) {
    _$merchantsListAtom.reportWrite(value, super.merchantsList, () {
      super.merchantsList = value;
    });
  }

  final _$getMerchantsAsyncAction = AsyncAction('_MerchantStore.getMerchants');

  @override
  Future<dynamic> getMerchants({String search, String tab, bool paginated}) {
    return _$getMerchantsAsyncAction.run(() =>
        super.getMerchants(search: search, tab: tab, paginated: paginated));
  }

  final _$getSearchesAsyncAction = AsyncAction('_MerchantStore.getSearches');

  @override
  Future<List<String>> getSearches(String query) {
    return _$getSearchesAsyncAction.run(() => super.getSearches(query));
  }

  final _$followMerchantAsyncAction =
      AsyncAction('_MerchantStore.followMerchant');

  @override
  Future followMerchant({String uid, String merchantId}) {
    return _$followMerchantAsyncAction
        .run(() => super.followMerchant(uid: uid, merchantId: merchantId));
  }

  final _$unFollowMerchantAsyncAction =
      AsyncAction('_MerchantStore.unFollowMerchant');

  @override
  Future unFollowMerchant({String uid, String merchantId}) {
    return _$unFollowMerchantAsyncAction
        .run(() => super.unFollowMerchant(uid: uid, merchantId: merchantId));
  }

  final _$reportMerchantAsyncAction =
      AsyncAction('_MerchantStore.reportMerchant');

  @override
  Future<dynamic> reportMerchant(
      {String uid, String merchantId, String reason}) {
    return _$reportMerchantAsyncAction.run(() =>
        super.reportMerchant(uid: uid, merchantId: merchantId, reason: reason));
  }

  final _$addSearchAsyncAction = AsyncAction('_MerchantStore.addSearch');

  @override
  Future<dynamic> addSearch(String query) {
    return _$addSearchAsyncAction.run(() => super.addSearch(query));
  }

  final _$_MerchantStoreActionController =
      ActionController(name: '_MerchantStore');

  @override
  void updateTab(int tab) {
    final _$actionInfo = _$_MerchantStoreActionController.startAction(
        name: '_MerchantStore.updateTab');
    try {
      return super.updateTab(tab);
    } finally {
      _$_MerchantStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSearch(String text) {
    final _$actionInfo = _$_MerchantStoreActionController.startAction(
        name: '_MerchantStore.updateSearch');
    try {
      return super.updateSearch(text);
    } finally {
      _$_MerchantStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchText: ${searchText},
success: ${success},
tab: ${tab},
fetchMerchantsFuture: ${fetchMerchantsFuture},
fetchMerchantsFollowFuture: ${fetchMerchantsFollowFuture},
fetchMerchantsUnFollowFuture: ${fetchMerchantsUnFollowFuture},
merchantsList: ${merchantsList},
loading: ${loading}
    ''';
  }
}
