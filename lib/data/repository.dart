import 'dart:async';

import 'package:greetings_world_shopper/data/network/apis/merchants/merchants_api.dart';
import 'package:greetings_world_shopper/data/network/apis/products/products_api.dart';
import 'package:greetings_world_shopper/data/network/apis/user/user_api.dart';
import 'package:greetings_world_shopper/data/sharedpref/shared_preference_helper.dart';
import 'package:greetings_world_shopper/models/cart/cart_item_model.dart';
import 'package:greetings_world_shopper/models/cart/update_cart_model.dart';
import 'package:greetings_world_shopper/models/common/general_response.dart';
import 'package:greetings_world_shopper/models/confirmation/register_confirmation_model.dart';
import 'package:greetings_world_shopper/models/generate_otp/otp_model.dart';
import 'package:greetings_world_shopper/models/like/like_model.dart';
import 'package:greetings_world_shopper/models/merchants/merchant_model.dart';
import 'package:greetings_world_shopper/models/merchnat_follow_model/merchant_follow_order.dart';
import 'package:greetings_world_shopper/models/orders/create_order_model.dart';
import 'package:greetings_world_shopper/models/products/product_model.dart';
import 'package:greetings_world_shopper/models/receipt/receipt_model.dart';
import 'package:greetings_world_shopper/models/receipt_detail/receipt_detail_model.dart';
import 'package:greetings_world_shopper/models/report/report_model.dart';
import 'package:greetings_world_shopper/models/user/login_model.dart';
import 'package:greetings_world_shopper/models/user/user_model.dart';
import 'package:inject/inject.dart';

import 'network/apis/cart/cart_api.dart';
import 'network/apis/receipt/receipt_api.dart';

@provide
class Repository {
  // api objects
  final MerchantsApi _merchantsApi;
  final ProductsApi _productsApi;
  final UserApi _userApi;
  final CartApi _cartApi;
  final ReceiptApi _receiptApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._merchantsApi, this._productsApi, this._userApi,
      this._cartApi, this._receiptApi, this._sharedPrefsHelper);

  // sign up
  Future<UserModel> signUp(
      {String fullName,
      String email,
      String password,
      String deviceType,
      String image,
      String phone}) async {
    return await _userApi
        .signUp(
            image: image,
            email: email,
            fullName: fullName,
            password: password,
            phone: phone,
            deviceType: deviceType)
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

  // Forgot Password
  Future<GeneralResponse> forgotPassword({String email}) async {
    return await _userApi
        .forgotPassword(
      email: email,
    )
        .then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  // Reset Password
  Future<GeneralResponse> resetPassword({String email, String password, String confirmPassword}) async {
    return await _userApi
        .resetPassword(
      email: email,
      password: password,
      confirmPassword: confirmPassword
    )
        .then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  // get user detail
  Future<UserModel> userDetail({String uid}) async {
    return await _userApi.userDetail(uid: uid).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  // get list of merchants
  Future<List<MerchantModel>> getMerchants(
      {String search, String tab, int limit, int offset}) async {
    return await _merchantsApi
        .getMerchants(search: search, tab: tab, limit: limit, offset: offset)
        .then((merchantsList) {
      return merchantsList;
    }).catchError((error) => throw error);
  }

  //get list of receipt

  // get list of merchants
  Future<List<ReceiptModel>> getReceipt(
      {String uid, int limit, int offset}) async {
    return await _receiptApi
        .getReceipt(uid: uid, limit: limit, offset: offset)
        .then((receiptList) {
      return receiptList;
    }).catchError((error) => throw error);
  }

  // follow merchant
  Future<FollowModel> followMerchant({String uid, String merchantId}) async {
    return await _merchantsApi
        .followMerchant(uid: uid, merchantId: merchantId)
        .then((model) {
      return model;
    }).catchError((error) => throw error);
  }

  // follow merchant
  Future<FollowModel> unFollowMerchant({String uid, String merchantId}) async {
    return await _merchantsApi
        .unFollowMerchant(uid: uid, merchantId: merchantId)
        .then((model) {
      return model;
    }).catchError((error) => throw error);
  }

  // get list of products
  Future<List<ProductModel>> getProducts({String id, String uid}) async {
    return await _productsApi
        .getProducts(id: id, uid: uid)
        .then((productsList) {
      return productsList;
    }).catchError((error) => throw error);
  }

  // get Merchant Detail
  Future<MerchantModel> getMerchantDetail({String merchantID}) async {
    return await _productsApi
        .getMerchantDetail(merchantID: merchantID)
        .then((data) {
      return data;
    }).catchError((error) => throw error);
  }

  // add wish
  Future<LikeModel> addWish({String uid, String productId}) async {
    return await _productsApi
        .addWish(uid: uid, productId: productId)
        .then((model) {
      return model;
    }).catchError((error) => throw error);
  }

  // add favourite
  Future<LikeModel> addFavourite({String uid, String productId}) async {
    return await _productsApi
        .addFavourite(uid: uid, productId: productId)
        .then((model) {
      return model;
    }).catchError((error) => throw error);
  }

//product report
  Future<ReportModel> addProductReport(
      {String uid, String productId, String reason}) async {
    return await _merchantsApi
        .addProductReport(uid: uid, productId: productId, reason: reason)
        .then((response) {
      return response;
    }).catchError((error) => throw error);
  }

// merchant report

  Future<ReportModel> addMerchantReport(
      {String uid, String merchantId, String reason}) async {
    return await _merchantsApi
        .addMerchantReport(uid: uid, merchantId: merchantId, reason: reason)
        .then((response) {
      return response;
    }).catchError((error) => throw error);
  }

  // remove wish
  Future<LikeModel> removeWish({String uid, String productId}) async {
    return await _productsApi
        .removeWish(uid: uid, productId: productId)
        .then((model) {
      return model;
    }).catchError((error) => throw error);
  }

  // remove favourite
  Future<LikeModel> removeFavourite({String uid, String productId}) async {
    return await _productsApi
        .removeFavourite(uid: uid, productId: productId)
        .then((model) {
      return model;
    }).catchError((error) => throw error);
  }

  // add item to cart
  Future<UpdateCartModel> addCart({String id, String productId, String deliveryType}) async {
    return await _cartApi.addCart(productId: productId, uid: id, deliveryType: deliveryType).then((model) {
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

  // change item delivery type
  Future<UpdateCartModel> updateDeliveryType(
      {String buyerId, String id, String deliveryType}) async {
    return await _cartApi
        .updateDeliveryType(buyerId: buyerId, id: id, deliveryType: deliveryType)
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

// place order
  Future<OrdersModel> createOrder(
      {String uid,
      String totalAmount,
      String subTotal,
      String shippingAmount,
      String taxCharges,
      String serviceCharges,
      String stripeToken}) async {
    return await _cartApi
        .createOrder(
            uid: uid,
            totalAmount: totalAmount,
            subTotal: subTotal,
            shippingAmount: shippingAmount,
            taxCharges: taxCharges,
            serviceCharges: serviceCharges,
            stripeToken: stripeToken)
        .then((model) {
      return model;
    }).catchError((error) => throw error);
  }

  //update shopper detail
  Future<UserModel> updateProfile(String uid,
      {String fullName, String image, String phone}) async {
    return await _userApi
        .updateProfileDetails(uid,
            image: image, fullName: fullName, phone: phone)
        .then((user) {
      return user;
    }).catchError((error) => throw error);
  }

//update Address detail
  Future<UserModel> updateAddress(String uid,
      {String city,
      String street1,
      String street2,
      String countryName,
      String stateName,
      String zip,
      String lat,
      String lng}) async {
    return await _userApi
        .updateAddress(uid,
            city: city,
            street1: street1,
            street2: street2,
            countryName: countryName,
            stateName: stateName,
            zip: zip,
            lat: lat,
            lng: lng)
        .then((user) {
      return user;
    }).catchError((error) => throw error);
  }

// receipt detail

  // get list of products
  Future<ReceiptDetailModel> getReceiptDetail({String id, String uid}) async {
    return await _receiptApi.getReceiptDetail(id: id, uid: uid).then((model) {
      // print("pp ===> $model");
      return model;
    }).catchError((error) => throw error);
  }

  // waitingForService
  void waitingForService({String orderId}) async {
     _receiptApi.waitingForService(orderId: orderId);
  }

  // get list of products
  //update shopper detail
  Future<LikeModel> cancelOrder(String orderId, {String uid}) async {
    return await _receiptApi.cancelOrder(orderId, uid: uid).then((model) {
      return model;
    }).catchError((error) => throw error);
  }

  // verify Email
  Future<RegisterConfirmationModel> confirmRegistration({String token}) async {
    return await _userApi.confirmRegistration(token: token).then((model) {
      return model;
    }).catchError((error) => throw error);
  }

  // get otp
  Future<GenerateOtpModel> getOtpCode({String uid, String phoneNumber}) async {
    return await _userApi
        .getGenerateOtp(uid: uid, phoneNumber: phoneNumber)
        .then((model) {
      return model;
    }).catchError((error) => throw error);
  }

  // get otp
  Future<GenerateOtpModel> phoneVerify(
      {String phoneNumber, String otp, String uid}) async {
    return await _userApi
        .phoneNumberVerify(phoneNumber: phoneNumber, otp: otp, uid: uid)
        .then((model) {
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

  Future<void> saveEmail(String value) => _sharedPrefsHelper.saveEmail(value);

  Future<String> get getEmail => _sharedPrefsHelper.getEmail;

  Future<void> savePhoneNumber(String value) =>
      _sharedPrefsHelper.savePhoneNumber(value);

  Future<String> get getPhoneNumber => _sharedPrefsHelper.getPhoneNumber;

//address

  Future<void> saveAddress(String value) =>
      _sharedPrefsHelper.saveAddress(value);

  Future<String> get getAddress => _sharedPrefsHelper.getAddress;

//address 1
  Future<void> saveAddress1(String value) =>
      _sharedPrefsHelper.saveAddress1(value);

  Future<String> get getAddress1 => _sharedPrefsHelper.getAddress1;

//address 2

  Future<void> saveAddress2(String value) =>
      _sharedPrefsHelper.saveAddress2(value);

  Future<String> get getAddress2 => _sharedPrefsHelper.getAddress2;

  //city

  Future<void> saveCity(String value) => _sharedPrefsHelper.saveCity(value);

  Future<String> get getCity => _sharedPrefsHelper.getCity;

  //state
  Future<void> saveState(String value) => _sharedPrefsHelper.saveState(value);

  Future<String> get getState => _sharedPrefsHelper.getState;

  //zip

  Future<void> saveZip(String value) => _sharedPrefsHelper.saveZip(value);

  Future<String> get getZip => _sharedPrefsHelper.getZip;

  //country
  Future<void> saveCountry(String value) =>
      _sharedPrefsHelper.saveCountry(value);

  Future<String> get getCountry => _sharedPrefsHelper.getCountry;

  Future<void> saveConfirmUser(bool value) =>
      _sharedPrefsHelper.saveConfirmUser(value);

  Future<bool> get getConfirmUser => _sharedPrefsHelper.getConfirmUser;

  Future<void> saveDeepLinkUrl(String value) {
    print('savelink===>  $_sharedPrefsHelper');
    _sharedPrefsHelper.saveDeepLinkUrl(value);
  }

  Future<String> get getDeepLinkUrl => _sharedPrefsHelper.getDeepLinkUrl;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  Future<String> get currentLanguage => _sharedPrefsHelper.currentLanguage;

  Future<void> saveSearch(String value) => _sharedPrefsHelper.saveSearch(value);

  Future<List<String>> get getSearches => _sharedPrefsHelper.getSearches();
}
