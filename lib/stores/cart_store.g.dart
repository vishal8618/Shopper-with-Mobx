// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartStore on _CartStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_CartStore.loading'))
      .value;

  final _$fetchUpdateCartFutureAtom =
      Atom(name: '_CartStore.fetchUpdateCartFuture');

  @override
  ObservableFuture<UpdateCartModel> get fetchUpdateCartFuture {
    _$fetchUpdateCartFutureAtom.reportRead();
    return super.fetchUpdateCartFuture;
  }

  @override
  set fetchUpdateCartFuture(ObservableFuture<UpdateCartModel> value) {
    _$fetchUpdateCartFutureAtom.reportWrite(value, super.fetchUpdateCartFuture,
        () {
      super.fetchUpdateCartFuture = value;
    });
  }

  final _$fetchCartFutureAtom = Atom(name: '_CartStore.fetchCartFuture');

  @override
  ObservableFuture<List<CartItemModel>> get fetchCartFuture {
    _$fetchCartFutureAtom.reportRead();
    return super.fetchCartFuture;
  }

  @override
  set fetchCartFuture(ObservableFuture<List<CartItemModel>> value) {
    _$fetchCartFutureAtom.reportWrite(value, super.fetchCartFuture, () {
      super.fetchCartFuture = value;
    });
  }

  final _$successAtom = Atom(name: '_CartStore.success');

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

  final _$hasCartAtom = Atom(name: '_CartStore.hasCart');

  @override
  bool get hasCart {
    _$hasCartAtom.reportRead();
    return super.hasCart;
  }

  @override
  set hasCart(bool value) {
    _$hasCartAtom.reportWrite(value, super.hasCart, () {
      super.hasCart = value;
    });
  }

  final _$cartTotalAtom = Atom(name: '_CartStore.cartTotal');

  @override
  int get cartTotal {
    _$cartTotalAtom.reportRead();
    return super.cartTotal;
  }

  @override
  set cartTotal(int value) {
    _$cartTotalAtom.reportWrite(value, super.cartTotal, () {
      super.cartTotal = value;
    });
  }

  final _$cartItemsAtom = Atom(name: '_CartStore.cartItems');

  @override
  int get cartItems {
    _$cartItemsAtom.reportRead();
    return super.cartItems;
  }

  @override
  set cartItems(int value) {
    _$cartItemsAtom.reportWrite(value, super.cartItems, () {
      super.cartItems = value;
    });
  }

  final _$cartListAtom = Atom(name: '_CartStore.cartList');

  @override
  List<CartItemModel> get cartList {
    _$cartListAtom.reportRead();
    return super.cartList;
  }

  @override
  set cartList(List<CartItemModel> value) {
    _$cartListAtom.reportWrite(value, super.cartList, () {
      super.cartList = value;
    });
  }

  final _$addCartAsyncAction = AsyncAction('_CartStore.addCart');

  @override
  Future<dynamic> addCart({String uid, String productId}) {
    return _$addCartAsyncAction
        .run(() => super.addCart(uid: uid, productId: productId));
  }

  final _$removeCartAsyncAction = AsyncAction('_CartStore.removeCart');

  @override
  Future<dynamic> removeCart({String uid, String productId, String quantity}) {
    return _$removeCartAsyncAction.run(() =>
        super.removeCart(uid: uid, productId: productId, quantity: quantity));
  }

  final _$getCartAsyncAction = AsyncAction('_CartStore.getCart');

  @override
  Future<dynamic> getCart({String uid}) {
    return _$getCartAsyncAction.run(() => super.getCart(uid: uid));
  }

  final _$processPaymentAsyncAction = AsyncAction('_CartStore.processPayment');

  @override
  Future processPayment() {
    return _$processPaymentAsyncAction.run(() => super.processPayment());
  }

  final _$_CartStoreActionController = ActionController(name: '_CartStore');

  @override
  dynamic updateDeliveryType({@required String type, @required String id}) {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.updateDeliveryType');
    try {
      return super.updateDeliveryType(type: type, id: id);
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchUpdateCartFuture: ${fetchUpdateCartFuture},
fetchCartFuture: ${fetchCartFuture},
success: ${success},
hasCart: ${hasCart},
cartTotal: ${cartTotal},
cartItems: ${cartItems},
cartList: ${cartList},
loading: ${loading}
    ''';
  }
}
