import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/routes.dart';
import 'package:greetings_world_shopper/stores/cart_store.dart';
import 'package:greetings_world_shopper/stores/home_store.dart';
import 'package:greetings_world_shopper/stores/language_store.dart';
import 'package:greetings_world_shopper/stores/merchant_detail_store.dart';
import 'package:greetings_world_shopper/stores/merchants_store.dart';
import 'package:greetings_world_shopper/stores/password_store.dart';
import 'package:greetings_world_shopper/stores/product_store.dart';
import 'package:greetings_world_shopper/stores/receipt_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/ui/deep_link/bloc.dart';
import 'package:greetings_world_shopper/utils/locale/app_localization.dart';
import 'package:inject/inject.dart';
import 'package:provider/provider.dart';

import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'di/components/app_component.dart';
import 'di/modules/netwok_module.dart';
import 'di/modules/preference_module.dart';

// global instance for app component
AppComponent appComponent;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    appComponent = await AppComponent.create(
      NetworkModule(),
      PreferenceModule(),
    );
    print("==========>main");
    runApp(appComponent.app);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
    ));
  });
}

@provide
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final LanguageStore _languageStore =
      LanguageStore(appComponent.getRepository());

  final HomeStore _homeStore = HomeStore();
  final MerchantStore _merchantStore =
      MerchantStore(appComponent.getRepository());

  final MerchantDetailStore _merchantDetailStore =
      MerchantDetailStore(appComponent.getRepository());

  final UserStore _userStore = UserStore(appComponent.getRepository());
  final CartStore _cartStore = CartStore(appComponent.getRepository());
  final PasswordStore _passwordStore = PasswordStore(appComponent.getRepository());

  final ProductStore _productStore = ProductStore(appComponent.getRepository());
  final ReceiptStore _receiptStore = ReceiptStore(appComponent.getRepository());
  final _bloc = DeepLinkBloc();


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<HomeStore>(create: (_) => _homeStore),
        Provider<MerchantStore>(create: (_) => _merchantStore),
        Provider<UserStore>(create: (_) => _userStore),
        Provider<PasswordStore>(create: (_) => _passwordStore),
        Provider<MerchantDetailStore>(create: (_) => _merchantDetailStore),
        Provider<CartStore>(create: (_) => _cartStore),
        Provider<ProductStore>(create: (_) => _productStore),
        Provider<ReceiptStore>(create: (_) => _receiptStore),
        Provider<DeepLinkBloc>.value(value: _bloc),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: themeData,
            initialRoute: Routes.splash,
            onGenerateRoute: Routes.generateRoute,
            locale: Locale(_languageStore.locale),
            supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale, language.code))
                .toList(),
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],


            // home: _userStore.isLoggedIn ? HomeScreen() : LoginScreen(),
          );
        },
      ),
    );
  }
}
