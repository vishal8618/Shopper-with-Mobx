// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductStore on _ProductStore, Store {
  final _$fetchWishFutureAtom = Atom(name: '_ProductStore.fetchWishFuture');

  @override
  ObservableFuture<String> get fetchWishFuture {
    _$fetchWishFutureAtom.reportRead();
    return super.fetchWishFuture;
  }

  @override
  set fetchWishFuture(ObservableFuture<String> value) {
    _$fetchWishFutureAtom.reportWrite(value, super.fetchWishFuture, () {
      super.fetchWishFuture = value;
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

  @override
  String toString() {
    return '''
fetchWishFuture: ${fetchWishFuture}
    ''';
  }
}
