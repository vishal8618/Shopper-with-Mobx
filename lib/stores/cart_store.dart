import 'package:flutter/material.dart';
import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/models/cart/cart_item_model.dart';
import 'package:greetings_world_shopper/models/cart/update_cart_model.dart';
import 'package:greetings_world_shopper/models/orders/create_order_model.dart';
import 'package:greetings_world_shopper/stores/success_store.dart';
import 'package:greetings_world_shopper/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:stripe_payment/stripe_payment.dart';

import 'error_store.dart';

part 'cart_store.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
// repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // store for handling errors
  final SuccessStore successStore = SuccessStore();

  // constructor:---------------------------------------------------------------
  _CartStore(Repository repository) : this._repository = repository;


// store variables:-----------------------------------------------------------
  static ObservableFuture<UpdateCartModel> emptyUpdateCartResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<UpdateCartModel> fetchUpdateCartFuture =
      ObservableFuture<UpdateCartModel>(emptyUpdateCartResponse);

  static ObservableFuture<List<CartItemModel>> emptyCartResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<List<CartItemModel>> fetchCartFuture =
      ObservableFuture<List<CartItemModel>>(emptyCartResponse);

  static ObservableFuture<OrdersModel> emptyCreateOrderResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<OrdersModel> fetchCreateOrderFuture =
      ObservableFuture<OrdersModel>(emptyCreateOrderResponse);

  @computed
  bool get loading =>
      fetchUpdateCartFuture.status == FutureStatus.pending ||
      fetchCartFuture.status == FutureStatus.pending;


  @computed
  bool get createOrderLoading =>
      fetchCreateOrderFuture.status == FutureStatus.pending;


  @observable
  bool success = false;

  @observable
  bool hasCart = false;

  @observable
  int cartTotal = 0;

  @observable
  double taxCharges = 0.0;

  @observable
  double shippingAmount = 0.0;

  @observable
  int cartItems = 0;

  @observable
  List<CartItemModel> cartList;

  @observable
  double cartSubTotal = 0.0;

  @observable
  String deliveryEstimated = " ";

  @observable
  double convenienceFee = 0.0;

  @observable
  bool isEditing = false;

  @action
  updateIsEditing() {
    isEditing = !isEditing;
  }



  @action
  Future addCart({String uid, String productId}) async {
    final future = _repository.addCart(productId: productId, id: uid);
    fetchUpdateCartFuture = ObservableFuture(future);
    print(fetchUpdateCartFuture.status.toString());
    future.then((model) {
      this.success = true;
      successStore.successMessage = model.message;
      hasCart = true;
      cartItems = model.itemCount;
      if (cartList.isNotEmpty) {
        ++cartList
            .lastWhere((element) =>
                element.cartItem.product.id.toString() == productId)
            .cartItem
            .itemQuantity;
/*
        cartList
            .lastWhere((element) =>
                element.cartItem.product.id.toString() == productId)
            .cartItem
            .product
            .price = (cartList
                .lastWhere((element) =>
                    element.cartItem.product.id.toString() == productId)
                .cartItem
                .itemQuantity *
            cartList
                .lastWhere((element) =>
                    element.cartItem.product.id.toString() == productId)
                .cartItem
                .product
                .price);
        cartList
            .lastWhere((element) =>
                element.cartItem.product.id.toString() == productId)
            .cartItem
            .product
            .price
            .toInt();*/

        cartList
            .lastWhere((element) =>
                element.cartItem.product.id.toString() == productId)
            .cartItem
            .taxCharges
            .toString();

        cartList
            .lastWhere((element) =>
                element.cartItem.product.id.toString() == productId)
            .cartItem
            .shippingAmount
            .toString();

        cartList
            .lastWhere((element) =>
                element.cartItem.product.id.toString() == productId)
            .cartItem
            .deliveryEstimatedDays
            .toString();
      }
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

  @action
  Future removeCart({String uid, String productId, String quantity}) async {
    //check if remaining cart quantity is 1, if yes, then delete the cart item
    if (cartList
            .lastWhere((element) =>
                element.cartItem.product.id.toString() == productId)
            .cartItem
            .itemQuantity <=
        1) quantity = "1";

    final future = _repository.removeCart(
        productId: productId, id: uid, quantity: quantity);
    fetchUpdateCartFuture = ObservableFuture(future);
    future.then((model) {
      this.success = true;
      successStore.successMessage = model.message;
      hasCart = cartList.length > 0;
      cartItems = model.itemCount;

      if (cartList.isNotEmpty) {
        //check if item is deleted, if yes, then delete from cart list as well otherwise just decrease the quantity
        if (quantity != null)
          cartList.removeWhere(
              (element) => element.cartItem.product.id.toString() == productId);
        else {
          --cartList
              .lastWhere((element) =>
                  element.cartItem.product.id.toString() == productId)
              .cartItem
              .itemQuantity;
         /* cartList
              .lastWhere((element) =>
                  element.cartItem.product.id.toString() == productId)
              .cartItem
              .product
              .price = (cartList
                  .lastWhere((element) =>
                      element.cartItem.product.id.toString() == productId)
                  .cartItem
                  .itemQuantity *
              cartList
                  .lastWhere((element) =>
                      element.cartItem.product.id.toString() == productId)
                  .cartItem
                  .product
                  .price);*/
        }
      }
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

  @action
  Future getCart({String uid}) async {
    cartTotal = 0;
    final future = _repository.getCart(id: uid);
    fetchCartFuture = ObservableFuture(future);
    future.then((model) {
      this.success = true;
      this.cartList = model;
      hasCart = cartList.length > 0;
      cartItems = cartList.length;

      if (hasCart) {
        cartList.forEach((element) {
          cartTotal +=
              element.cartItem.product.price * element.cartItem.itemQuantity;
          print("$cartTotal");
        });
      }
      if (hasCart) {
        cartList.forEach((element) {
          var taxAmount = (element.cartItem.subTotal / 100) * 9.25;
          taxCharges = taxAmount;
          print("$taxAmount");
        });

        /*double sum = cartList
            .map((expense) => expense.cartItem.taxCharges)
            .fold(0, (prev, amount) => prev + amount);*/

      }

      if (hasCart) {
        double sum = cartList
            .map((expense) => expense.cartItem.shippingAmount)
            .fold(0, (prev, amount) => prev + amount);

        shippingAmount = sum;
      }

      if (hasCart) {
        cartList.forEach((element) {
          deliveryEstimated = element.cartItem.deliveryEstimatedDays;
        });
      }

      if (hasCart) {
        cartList.forEach((element) {
          var convenienceAmount = (element.cartItem.subTotal / 100) * 2;
          convenienceFee = convenienceAmount;
        });
      }

      if (hasCart) {
        var cartList = [cartTotal, taxCharges, shippingAmount, convenienceFee];
        cartSubTotal =
            cartList.fold(0, (previous, current) => previous + current);
        print(cartSubTotal.round()); // 6

        print("$cartSubTotal");
      }
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

  @action
  updateDeliveryType({@required String type, @required String id}) {
    cartList
        .lastWhere((element) => element.cartItem.id.toString() == id)
        .cartItem
        .deliveryType = type;
  }

  @action
  Future processPayment({String uid, String totalAmount, String subTotal, String shippingAmount, String taxCharges, String serviceCharges, String stripeToken}) async {
    final future = _repository.createOrder(
        uid: uid,
        totalAmount: totalAmount,
        subTotal: subTotal,
        shippingAmount: shippingAmount,
        taxCharges: taxCharges,
        serviceCharges: serviceCharges,
        stripeToken: stripeToken);
    print("here");
    fetchCreateOrderFuture = ObservableFuture(future);
    print(fetchCreateOrderFuture.status.toString());
    future.then((model) {
      this.success = true;
      successStore.successMessage = model.message;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

  void setError(dynamic error) {
//Handle your errors
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // general methods:-----------------------------------------------------------

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
