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






  Future<String> get getImage {
    return _sharedPreference.then((prefs) {
      return prefs.getString(Preferences.image) ?? null;
    });
  }

  Future<void> saveImage(String value) async {
    return _sharedPreference.then((preference) {
      preference.setString(Preferences.image, value);
    });
  }





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
}
