import 'package:greetings_world_shopper/data/repository.dart';
 import 'package:greetings_world_shopper/models/language/language_model.dart';
import 'package:mobx/mobx.dart';

import 'error_store.dart';
part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  static const String TAG = "LanguageStore";

  // repository instance
  final Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // supported languages
  List<LanguageModel> supportedLanguages = [
    LanguageModel(code: 'US', locale: 'en', language: 'English'),
  ];

  // constructor:---------------------------------------------------------------
  _LanguageStore(Repository repository)
      : this._repository = repository {
    init();
  }

  // store variables:-----------------------------------------------------------
  @observable
  String _locale = "en";

  @computed
  String get locale => _locale;

  // actions:-------------------------------------------------------------------
  @action
  void changeLanguage(String value) {
    _locale = value;
    _repository.changeLanguage(value).then((_) {
      // write additional logic here
    });
  }

  @action
  String getCode() {
    var code;

    if (_locale == 'en') {
      code = "US";
    } else if (_locale == 'da') {
      code = "DK";
    } else if (_locale == 'es') {
      code = "ES";
    }

    return code;
  }

  @action
  String getLanguage() {
    return supportedLanguages[supportedLanguages
        .indexWhere((language) => language.locale == _locale)]
        .language;
  }

  // general:-------------------------------------------------------------------
  void init() async {
    // getting current language from shared preference
    _repository?.currentLanguage?.then((locale) {
      if (locale != null) {
        _locale = locale;
      }
    });
  }

  // dispose:-------------------------------------------------------------------
  @override
  dispose() {}
}
