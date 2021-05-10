import 'package:greetings_world_shopper/constants/strings.dart';

class Endpoints {
  Endpoints._();

// base url
  //static const String baseUrl = "http://192.168.1.155:3000/";
  static const String baseUrl = "https://htm-app.herokuapp.com/";

  static const String products = "/products.json";
  static const String getMerchants = baseUrl + "merchants.json";

  static const String followMerchant = baseUrl + "follow/follow_user.json";
  static const String unFollowMerchant = baseUrl + "follow/unfollow_user.json";

  static const String getProducts = baseUrl + "merchants/";
  static const String signUp = baseUrl + "buyers.json";
  static const String login = baseUrl + "users/login.json";
  static const String userDetail = baseUrl + "buyers/";

  static const String addCart = baseUrl + "cart/add_item.json";
  static const String removeCart = baseUrl + "cart/remove_item.json";
  static const String cartList = baseUrl + "carts.json";

  static const String addWish = baseUrl + "like/like_product.json";
  static const String removeWish = baseUrl + "like/unlike_product.json";

  static const String addFavourite = baseUrl + "favorites.json";
  static const String removeFavourite = baseUrl + "favorite/remove_favorite.json";

  static const String addReport = baseUrl + "product_flag_reports.json";
  static const String addMerchantReport = baseUrl + "merchant_flag_reports.json";

  static const String updateProfileDetail = baseUrl + "buyers/";
  static const String createOrder = baseUrl + "orders.json";

  static const String getReceipt = baseUrl + "orders";
  static const String getReceiptDetail= baseUrl + "orders/";

  static const String registrationConfirmation= baseUrl + "registration/confirm_user.json";

  static const String generate_otp_code="registration/generate_otp_code.json";
  static const String phone_number_verify="registration/verify_phone_number.json";

  static const String cancelOrder= "order/cancel_order/";
}
