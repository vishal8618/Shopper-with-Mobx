import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final Future<SharedPreferences> _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String> get authToken async {
    return _sharedPreference.then((preference) {
      return preference.getString(Preferences.auth_token);
    });
  }

  Future<void> saveAuthToken(String authToken) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.auth_token, authToken);
    });
  }

  Future<void> removeAuthToken() async {
    return _sharedPreference.then((preference) {
      preference.remove(Preferences.auth_token);
    });
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.then((preference) {
      return preference.getBool(Preferences.is_logged_in) ?? false;
    });
  }

  Future<void> saveIsLoggedIn(bool value) async {
    return _sharedPreference.then((preference) {
      preference.setBool(Preferences.is_logged_in, value);
    });
  }

  Future<String> get getUid {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.uid) ?? null;
    });
  }

  Future<void> saveUserId(int value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.uid, value.toString());
    });
  }

  Future<String> get getName {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.name) ?? null;
    });
  }

  Future<void> saveName(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.name, value);
    });
  }

  Future<String> get getEmail {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.email) ?? null;
    });
  }

  Future<void> saveEmail(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.email, value);
    });
  }
  // Login:---------------------------------------------------------------------
  Future<bool> get getConfirmUser async {
    return _sharedPreference.then((preference) {
      return preference.getBool(Preferences.confirmed_user) ?? false;
    });
  }

  Future<void> saveConfirmUser(bool value) async {
    return _sharedPreference.then((preference) {
      preference.setBool(Preferences.confirmed_user, value);
    });
  }


  Future<String> get getPhoneNumber {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.phone_number) ?? null;
    });
  }

  Future<void> savePhoneNumber(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.phone_number, value);
    });
  }

  get getImage {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.image) ?? null;
    });
  }

  Future<void> saveImage(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.image, value);
    });
  }
//address
  Future<String> get getAddress {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.address) ?? null;
    });
  }

  Future<void> saveAddress(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.address, value);
    });
  }

//address1
  Future<String> get getAddress1 {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.address1) ?? null;
    });
  }

  Future<void> saveAddress1(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.address1, value);
    });
  }

  //address 2

  Future<String> get getAddress2 {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.address2) ?? null;
    });
  }

  Future<void> saveAddress2(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.address2, value);
    });
  }
//city
  Future<String> get getCity {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.city) ?? null;
    });
  }

  Future<void> saveCity(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.city, value);
    });
  }
  //state

  Future<String> get getState {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.state) ?? null;
    });
  }

  Future<void> saveState(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.state, value);
    });
  }

  //zip

  Future<String> get getZip {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.zip) ?? null;
    });
  }

  Future<void> saveZip(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.zip, value);
    });
  }

  //country name

  Future<String> get getCountry {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.country) ?? null;
    });
  }

  Future<void> saveCountry(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.country, value);
    });
  }
//deep_link_url
  Future<String> get getDeepLinkUrl {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.deep_link_url) ?? null;
    });
  }

  Future<void> saveDeepLinkUrl(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.deep_link_url, value);
    });
  }
  // Theme:------------------------------------------------------
  Future<bool> get isDarkMode {
    return _sharedPreference.then((prefs) {
      return prefs.getBool(Preferences.is_dark_mode) ?? false;
    });
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.then((prefs) {
      return prefs.setBool(Preferences.is_dark_mode, value);
    });
  }

  // SEARCH HISTORY:-------------------------------------------------
  Future<List<String>> getSearches() {
    return _sharedPreference.then((prefs) {
      var searches = prefs.getString(Preferences.search_history);
      if (searches == null || searches == "")
        return List();
      else {
        var list = searches.split(",");
        if (list.last == '') list.removeLast();
        return list;
      }
    });
  }

  Future<void> saveSearch(String search) async {
    var searches = await getSearches();

    try {
      var index = searches.lastIndexWhere(
              (element) => search.toLowerCase() == element.toLowerCase());
      if (index > 0) searches.removeWhere((element) => element == search);
      //all filtered now
    } catch (e) {}

    searches.add(search);

    var data = searches.join(",");

    return _sharedPreference.then((prefs) {
      return prefs.setString(Preferences.search_history, data);
    });
  }

  // Language:---------------------------------------------------
  Future<String> get currentLanguage {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.current_language);
    });
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(Preferences.current_language, language);
    });
  }


  // DeepLink Merchant ID
  Future<int> get getMerchantID {
    return _sharedPreference.then((prefs) {
      return prefs.getInt(Preferences.merchant_id) ?? null;
    });
  }

  Future<void> saveMerchantID(int value) async {
    return _sharedPreference.then((preference) {
      preference.setInt(Preferences.merchant_id, value);
    });
  }

// DeepLink Merchant/Product ID
  Future<int> get getProductID {
    return _sharedPreference.then((prefs) {
      return prefs.getInt(Preferences.product_id) ?? null;
    });
  }

  Future<void> saveProductID(int value) async {
    return _sharedPreference.then((preference) {
      preference.setInt(Preferences.product_id, value);
    });
  }

// DeepLink is Coming from deepLink
  Future<bool> get isDeepLink async {
    return _sharedPreference.then((preference) {
      return preference.getBool(Preferences.is_deepLink) ?? false;
    });
  }

  Future<void> saveDeepLink(bool value) async {
    return _sharedPreference.then((preference) {
      preference.setBool(Preferences.is_deepLink, value);
    });
  }



  // DeepLink Merchant ID
  Future<int> get getOrderID {
    return _sharedPreference.then((prefs) {
      return prefs.getInt(Preferences.order_id) ?? null;
    });
  }

  Future<void> saveOrderID(int value) async {
    return _sharedPreference.then((preference) {
      preference.setInt(Preferences.order_id, value);
    });
  }

  // DeepLink Merchant Tab
  Future<int> get getMerchantTab {
    return _sharedPreference.then((prefs) {
      return prefs.getInt(Preferences.merchant_tab) ?? null;
    });
  }

  Future<void> saveMerchantTab(int value) async {
    return _sharedPreference.then((preference) {
      preference.setInt(Preferences.merchant_tab, value);
    });
  }

}
