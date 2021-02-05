import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:greetings_world_shopper/data/network/apis/merchants/merchants_api.dart';
import 'package:greetings_world_shopper/data/network/apis/products/products_api.dart';
import 'package:greetings_world_shopper/data/network/apis/user/user_api.dart';
import 'package:greetings_world_shopper/data/sharedpref/shared_preference_helper.dart';
import 'package:greetings_world_shopper/models/cart/cart_item_model.dart';
import 'package:greetings_world_shopper/models/cart/update_cart_model.dart';
import 'package:greetings_world_shopper/models/merchants/merchant_model.dart';
import 'package:greetings_world_shopper/models/products/product_model.dart';
import 'package:greetings_world_shopper/models/user/login_model.dart';
import 'package:greetings_world_shopper/models/user/user_model.dart';
import 'package:inject/inject.dart';

import 'network/apis/cart/cart_api.dart';

@provide
class Repository {
  // api objects
  final MerchantsApi _merchantsApi;
  final ProductsApi _productsApi;
  final UserApi _userApi;
  final CartApi _cartApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._merchantsApi, this._productsApi, this._userApi,
      this._cartApi, this._sharedPrefsHelper);

  // sign up
  Future<UserModel> signUp(
      {String fullName,
      String email,
      String password,
      String image,
      String phone}) async {
    return await _userApi
        .signUp(
            image: image,
            email: email,
            fullName: fullName,
            password: password,
            phone: phone)
        .then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  // login
  Future<LoginModel> login({String email, String password}) async {
    return await _userApi
        .login(
      email: email,
      password: password,
    )
        .then((user) {
      return user;
    }).catchError((error) => throw error);
  }


  // get user detail
  Future<UserModel> userDetail(
      {
        String uid}) async {
    return await _userApi
        .userDetail(
      uid: uid
        )
        .then((user) {
      return user;
    }).catchError((error) => throw error);
  }


  // get list of merchants
  Future<List<MerchantModel>> getMerchants({String search, String tab, int limit, int offset}) async {
    return await _merchantsApi
        .getMerchants(search: search, tab: tab,limit: limit,offset: offset)
        .then((merchantsList) {
      return merchantsList;
    }).catchError((error) => throw error);
  }

  // follow merchant
  Future<String> followMerchant({String uid, String merchantId}) async {
    return await _merchantsApi
        .followMerchant(uid: uid, merchantId: merchantId)
        .then((data) {
      return data;
    }).catchError((error) => throw error);
  }

  // follow merchant
  Future<String> unFollowMerchant({String uid, String merchantId}) async {
    return await _merchantsApi
        .unFollowMerchant(uid: uid, merchantId: merchantId)
        .then((data) {
      return data;
    }).catchError((error) => throw error);
  }

  // get list of products
  Future<List<ProductModel>> getProducts({String id}) async {
    return await _productsApi.getProducts(id: id).then((productsList) {
      return productsList;
    }).catchError((error) => throw error);
  }

  // add wish
  Future<String> addWish({String uid, String productId}) async {
    return await _productsApi
        .addWish(uid: uid, productId: productId)
        .then((response) {
      return response;
    }).catchError((error) => throw error);
  }

  // remove wish
  Future<String> removeWish({String uid, String productId}) async {
    return await _productsApi
        .removeWish(uid: uid, productId: productId)
        .then((response) {
      return response;
    }).catchError((error) => throw error);
  }

  // add item to cart
  Future<UpdateCartModel> addCart({String id, String productId}) async {
    return await _cartApi.addCart(productId: productId, uid: id).then((model) {
      return model;
    }).catchError((error) => throw error);
  }

  // add item to cart
  Future<UpdateCartModel> removeCart(
      {String id, String productId, String quantity}) async {
    return await _cartApi
        .removeCart(productId: productId, uid: id, quantity: quantity)
        .then((model) {
      return model;
    }).catchError((error) => throw error);
  }

  // return cart items
  Future<List<CartItemModel>> getCart({String id}) async {
    return await _cartApi.getCart(uid: id).then((model) {
      return model;
    }).catchError((error) => throw error);
  }

  //save login info in local
  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  Future<void> saveUserId(int value) => _sharedPrefsHelper.saveUserId(value);

  Future<String> get getUid => _sharedPrefsHelper.getUid;

  Future<void> saveName(String value) => _sharedPrefsHelper.saveName(value);

  Future<String> get getName => _sharedPrefsHelper.getName;


  Future<void> saveImage(String value) => _sharedPrefsHelper.saveImage(value);

  Future<String> get getImage => _sharedPrefsHelper.getImage;



  Future<void> saveAddress(String value) => _sharedPrefsHelper.saveAddress(value);

  Future<String> get getAddress => _sharedPrefsHelper.getAddress;


  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  Future<String> get currentLanguage => _sharedPrefsHelper.currentLanguage;

  Future<void> saveSearch(String value) => _sharedPrefsHelper.saveSearch(value);

  Future<List<String>> get getSearches => _sharedPrefsHelper.getSearches();
}
