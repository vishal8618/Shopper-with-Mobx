import 'package:flutter/material.dart';
import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/models/cart/cart_item_model.dart';
import 'package:greetings_world_shopper/models/cart/update_cart_model.dart';
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

  @computed
  bool get loading =>
      fetchUpdateCartFuture.status == FutureStatus.pending ||
      fetchCartFuture.status == FutureStatus.pending;

  @observable
  bool success = false;

  @observable
  bool hasCart = false;

  @observable
  int cartTotal = 0;

  @observable
  int cartItems = 0;

  @observable
  List<CartItemModel> cartList;

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

        cartList
            .lastWhere((element) =>
                element.cartItem.product.id.toString() == productId)
            .cartItem
            .totalAmount = (cartList
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
          cartList
              .lastWhere((element) =>
                  element.cartItem.product.id.toString() == productId)
              .cartItem
              .totalAmount = (cartList
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
          cartTotal += element.cartItem.totalAmount;
        });
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
  processPayment() async {
    // StripePayment.setOptions(
    //   StripeOptions(
    //     publishableKey: "pk_test_PqRugISQX9tprKeM08RG4WeQ00jq1t3ELU",
    //     androidPayMode: 'test',
    //   ),
    // );
    // await StripePayment.createTokenWithCard(CreditCard());

    //  await StripePayment.paymentRequestWithCardForm(
    //   CardFormPaymentRequest(),
    // ).catchError(setError);
  }

  void setError(dynamic error) {
//Handle your errors
  }
}
