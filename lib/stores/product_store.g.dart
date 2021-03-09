// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductStore on _ProductStore, Store {
  final _$successAtom = Atom(name: '_ProductStore.success');

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

  final _$fetchWishFutureAtom = Atom(name: '_ProductStore.fetchWishFuture');

  @override
  ObservableFuture<LikeModel> get fetchWishFuture {
    _$fetchWishFutureAtom.reportRead();
    return super.fetchWishFuture;
  }

  @override
  set fetchWishFuture(ObservableFuture<LikeModel> value) {
    _$fetchWishFutureAtom.reportWrite(value, super.fetchWishFuture, () {
      super.fetchWishFuture = value;
    });
  }

  final _$fetchFavouriteFutureAtom =
      Atom(name: '_ProductStore.fetchFavouriteFuture');

  @override
  ObservableFuture<LikeModel> get fetchFavouriteFuture {
    _$fetchFavouriteFutureAtom.reportRead();
    return super.fetchFavouriteFuture;
  }

  @override
  set fetchFavouriteFuture(ObservableFuture<LikeModel> value) {
    _$fetchFavouriteFutureAtom.reportWrite(value, super.fetchFavouriteFuture,
        () {
      super.fetchFavouriteFuture = value;
    });
  }

  final _$fetchReportFutureAtom = Atom(name: '_ProductStore.fetchReportFuture');

  @override
  ObservableFuture<ReportModel> get fetchReportFuture {
    _$fetchReportFutureAtom.reportRead();
    return super.fetchReportFuture;
  }

  @override
  set fetchReportFuture(ObservableFuture<ReportModel> value) {
    _$fetchReportFutureAtom.reportWrite(value, super.fetchReportFuture, () {
      super.fetchReportFuture = value;
    });
  }

  final _$addWishAsyncAction = AsyncAction('_ProductStore.addWish');

  @override
  Future<dynamic> addWish({String uid, String productId}) {
    return _$addWishAsyncAction
        .run(() => super.addWish(uid: uid, productId: productId));
  }

  final _$removeWishAsyncAction = AsyncAction('_ProductStore.removeWish');

  @override
  Future<dynamic> removeWish({String uid, String productId}) {
    return _$removeWishAsyncAction
        .run(() => super.removeWish(uid: uid, productId: productId));
  }

  final _$addFavouriteAsyncAction = AsyncAction('_ProductStore.addFavourite');

  @override
  Future<dynamic> addFavourite({String uid, String productId}) {
    return _$addFavouriteAsyncAction
        .run(() => super.addFavourite(uid: uid, productId: productId));
  }

  final _$removeFavouriteAsyncAction =
      AsyncAction('_ProductStore.removeFavourite');

  @override
  Future<dynamic> removeFavourite({String uid, String productId}) {
    return _$removeFavouriteAsyncAction
        .run(() => super.removeFavourite(uid: uid, productId: productId));
  }

  final _$addProductReportAsyncAction =
      AsyncAction('_ProductStore.addProductReport');

  @override
  Future<dynamic> addProductReport(
      {String uid, String productId, String reason}) {
    return _$addProductReportAsyncAction.run(() =>
        super.addProductReport(uid: uid, productId: productId, reason: reason));
  }

  final _$addMerchantReportAsyncAction =
      AsyncAction('_ProductStore.addMerchantReport');

  @override
  Future<dynamic> addMerchantReport(
      {String uid, String merchantId, String reason}) {
    return _$addMerchantReportAsyncAction.run(() => super
        .addMerchantReport(uid: uid, merchantId: merchantId, reason: reason));
  }

  @override
  String toString() {
    return '''
success: ${success},
fetchWishFuture: ${fetchWishFuture},
fetchFavouriteFuture: ${fetchFavouriteFuture},
fetchReportFuture: ${fetchReportFuture}
    ''';
  }
}
