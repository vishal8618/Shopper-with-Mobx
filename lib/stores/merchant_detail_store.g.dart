// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MerchantDetailStore on _MerchantDetailStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_MerchantDetailStore.loading'))
      .value;

  final _$tabAtom = Atom(name: '_MerchantDetailStore.tab');

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

  final _$fetchProductsFutureAtom =
      Atom(name: '_MerchantDetailStore.fetchProductsFuture');

  @override
  ObservableFuture<List<ProductModel>> get fetchProductsFuture {
    _$fetchProductsFutureAtom.reportRead();
    return super.fetchProductsFuture;
  }

  @override
  set fetchProductsFuture(ObservableFuture<List<ProductModel>> value) {
    _$fetchProductsFutureAtom.reportWrite(value, super.fetchProductsFuture, () {
      super.fetchProductsFuture = value;
    });
  }

  final _$productsListAtom = Atom(name: '_MerchantDetailStore.productsList');

  @override
  List<ProductModel> get productsList {
    _$productsListAtom.reportRead();
    return super.productsList;
  }

  @override
  set productsList(List<ProductModel> value) {
    _$productsListAtom.reportWrite(value, super.productsList, () {
      super.productsList = value;
    });
  }

  final _$getProductsAsyncAction =
      AsyncAction('_MerchantDetailStore.getProducts');

  @override
  Future<List<ProductModel>> getProducts({String id, String uid}) {
    return _$getProductsAsyncAction
        .run(() => super.getProducts(id: id, uid: uid));
  }

  @override
  Future<MerchantModel> getMerchantDetail({String merchantID}) {
    return _$getProductsAsyncAction
        .run(() => super.getMerchantDetail(merchantID: merchantID));
  }

  final _$_MerchantDetailStoreActionController =
      ActionController(name: '_MerchantDetailStore');

  @override
  void updateTab(int tab) {
    final _$actionInfo = _$_MerchantDetailStoreActionController.startAction(
        name: '_MerchantDetailStore.updateTab');
    try {
      return super.updateTab(tab);
    } finally {
      _$_MerchantDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tab: ${tab},
fetchProductsFuture: ${fetchProductsFuture},
productsList: ${productsList},
loading: ${loading}
    ''';
  }
}
