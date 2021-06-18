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
  Computed<bool> _$createOrderLoadingComputed;

  @override
  bool get createOrderLoading => (_$createOrderLoadingComputed ??=
          Computed<bool>(() => super.createOrderLoading,
              name: '_CartStore.createOrderLoading'))
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

  final _$fetchCreateOrderFutureAtom =
      Atom(name: '_CartStore.fetchCreateOrderFuture');

  @override
  ObservableFuture<OrdersModel> get fetchCreateOrderFuture {
    _$fetchCreateOrderFutureAtom.reportRead();
    return super.fetchCreateOrderFuture;
  }

  @override
  set fetchCreateOrderFuture(ObservableFuture<OrdersModel> value) {
    _$fetchCreateOrderFutureAtom
        .reportWrite(value, super.fetchCreateOrderFuture, () {
      super.fetchCreateOrderFuture = value;
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

  final _$taxChargesAtom = Atom(name: '_CartStore.taxCharges');

  @override
  double get taxCharges {
    _$taxChargesAtom.reportRead();
    return super.taxCharges;
  }

  @override
  set taxCharges(double value) {
    _$taxChargesAtom.reportWrite(value, super.taxCharges, () {
      super.taxCharges = value;
    });
  }

  final _$shippingAmountAtom = Atom(name: '_CartStore.shippingAmount');

  @override
  double get shippingAmount {
    _$shippingAmountAtom.reportRead();
    return super.shippingAmount;
  }

  @override
  set shippingAmount(double value) {
    _$shippingAmountAtom.reportWrite(value, super.shippingAmount, () {
      super.shippingAmount = value;
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

  final _$cartSubTotalAtom = Atom(name: '_CartStore.cartSubTotal');

  @override
  double get cartSubTotal {
    _$cartSubTotalAtom.reportRead();
    return super.cartSubTotal;
  }

  @override
  set cartSubTotal(double value) {
    _$cartSubTotalAtom.reportWrite(value, super.cartSubTotal, () {
      super.cartSubTotal = value;
    });
  }

  final _$deliveryEstimatedAtom = Atom(name: '_CartStore.deliveryEstimated');

  @override
  String get deliveryEstimated {
    _$deliveryEstimatedAtom.reportRead();
    return super.deliveryEstimated;
  }

  @override
  set deliveryEstimated(String value) {
    _$deliveryEstimatedAtom.reportWrite(value, super.deliveryEstimated, () {
      super.deliveryEstimated = value;
    });
  }

  final _$convenienceFeeAtom = Atom(name: '_CartStore.convenienceFee');

  @override
  double get convenienceFee {
    _$convenienceFeeAtom.reportRead();
    return super.convenienceFee;
  }

  @override
  set convenienceFee(double value) {
    _$convenienceFeeAtom.reportWrite(value, super.convenienceFee, () {
      super.convenienceFee = value;
    });
  }

  final _$isEditingAtom = Atom(name: '_CartStore.isEditing');

  @override
  bool get isEditing {
    _$isEditingAtom.reportRead();
    return super.isEditing;
  }

  @override
  set isEditing(bool value) {
    _$isEditingAtom.reportWrite(value, super.isEditing, () {
      super.isEditing = value;
    });
  }

  final _$addCartAsyncAction = AsyncAction('_CartStore.addCart');

  @override
  Future<dynamic> addCart({String uid, String productId, String deliveryType}) {
    return _$addCartAsyncAction.run(() => super
        .addCart(uid: uid, productId: productId, deliveryType: deliveryType));
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

  final _$updateDeliveryTypeAsyncAction =
      AsyncAction('_CartStore.updateDeliveryType');

  @override
  Future<dynamic> updateDeliveryType(
      {@required String buyerId,
      @required String id,
      @required String deliveryType}) {
    return _$updateDeliveryTypeAsyncAction.run(() => super.updateDeliveryType(
        buyerId: buyerId, id: id, deliveryType: deliveryType));
  }

  final _$processPaymentAsyncAction = AsyncAction('_CartStore.processPayment');

  @override
  Future<dynamic> processPayment(
      {String uid,
      String totalAmount,
      String subTotal,
      String shippingAmount,
      String taxCharges,
      String serviceCharges,
      String stripeToken}) {
    return _$processPaymentAsyncAction.run(() => super.processPayment(
        uid: uid,
        totalAmount: totalAmount,
        subTotal: subTotal,
        shippingAmount: shippingAmount,
        taxCharges: taxCharges,
        serviceCharges: serviceCharges,
        stripeToken: stripeToken));
  }

  final _$_CartStoreActionController = ActionController(name: '_CartStore');

  @override
  dynamic updateIsEditing() {
    final _$actionInfo = _$_CartStoreActionController.startAction(
        name: '_CartStore.updateIsEditing');
    try {
      return super.updateIsEditing();
    } finally {
      _$_CartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchUpdateCartFuture: ${fetchUpdateCartFuture},
fetchCartFuture: ${fetchCartFuture},
fetchCreateOrderFuture: ${fetchCreateOrderFuture},
success: ${success},
hasCart: ${hasCart},
cartTotal: ${cartTotal},
taxCharges: ${taxCharges},
shippingAmount: ${shippingAmount},
cartItems: ${cartItems},
cartList: ${cartList},
cartSubTotal: ${cartSubTotal},
deliveryEstimated: ${deliveryEstimated},
convenienceFee: ${convenienceFee},
isEditing: ${isEditing},
loading: ${loading},
createOrderLoading: ${createOrderLoading}
    ''';
  }
}
