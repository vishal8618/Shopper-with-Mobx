import 'package:dio/dio.dart';
import 'package:greetings_world_shopper/data/network/apis/cart/cart_api.dart';
import 'package:greetings_world_shopper/data/network/apis/merchants/merchants_api.dart';
import 'package:greetings_world_shopper/data/network/apis/products/products_api.dart';
import 'package:greetings_world_shopper/data/network/apis/user/user_api.dart';
import 'package:greetings_world_shopper/data/network/constants/constants.dart';
 import 'package:greetings_world_shopper/data/network/constants/endpoints.dart';
import 'package:greetings_world_shopper/data/network/dio_client.dart';
 import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/data/sharedpref/constants/preferences.dart';
import 'package:greetings_world_shopper/data/sharedpref/shared_preference_helper.dart';
import 'package:greetings_world_shopper/di/modules/preference_module.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
class NetworkModule extends PreferenceModule {
  // ignore: non_constant_identifier_names
  final String TAG = "NetworkModule";



  // DI Providers:--------------------------------------------------------------
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Constants.connectionTimeout
      ..options.receiveTimeout = Constants.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (Options options) async {
            // getting shared pref instance
            // var prefs = await SharedPreferences.getInstance();
            //
            // // getting token
            // var token = prefs.getString(Preferences.auth_token);
            //
            // if (token != null) {
            //   options.headers.putIfAbsent('Authorization', () => token);
            // } else {
            //   print('Auth token is null');
            // }
          },
        ),
      );

    return dio;
  }

  /// A singleton dio_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  DioClient provideDioClient(Dio dio) => DioClient(dio);

  /// A singleton dio_client provider.
  ///


  // Api Providers:-------------------------------------------------------------
  // Define all your api providers here
  /// A singleton post_api provider.
  ///
  /// Calling it multiple times will return the same instance.


  @provide
  @singleton
  UserApi provideUserApi(DioClient dioClient, ) =>
      UserApi(dioClient,  );


  @provide
  @singleton
  MerchantsApi provideMerchantsApi(DioClient dioClient ) =>
      MerchantsApi(dioClient,  );

  @provide
  @singleton
  ProductsApi provideProductsApi(DioClient dioClient ) =>
      ProductsApi(dioClient,  );

  @provide
  @singleton
  CartApi provideCartApi(DioClient dioClient ) =>
      CartApi(dioClient );


// Api Providers End:---------------------------------------------------------

  @provide
  @singleton
  Repository provideRepository(
      MerchantsApi merchantsApi,
      ProductsApi productsApi,
      UserApi userApi,CartApi cartApi,
      SharedPreferenceHelper preferenceHelper,
      
      ) =>
      Repository(merchantsApi,productsApi,userApi,cartApi, preferenceHelper);
  
}
