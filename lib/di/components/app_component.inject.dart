import 'app_component.dart' as _i1;
import '../modules/netwok_module.dart' as _i2;
import '../modules/preference_module.dart' as _i3;
import '../../data/sharedpref/shared_preference_helper.dart' as _i4;
import 'package:dio/src/dio.dart' as _i5;
import '../../data/network/dio_client.dart' as _i6;
import '../../data/network/apis/merchants/merchants_api.dart' as _i7;
import '../../data/network/apis/products/products_api.dart' as _i8;
import '../../data/network/apis/user/user_api.dart' as _i9;
import '../../data/network/apis/cart/cart_api.dart' as _i10;
import '../../data/network/apis/receipt/receipt_api.dart' as _i11;
import '../../data/repository.dart' as _i12;
import 'dart:async' as _i13;
import '../../main.dart' as _i14;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._(this._networkModule, this._preferenceModule);

  final _i2.NetworkModule _networkModule;

  final _i3.PreferenceModule _preferenceModule;

  _i4.SharedPreferenceHelper _singletonSharedPreferenceHelper;

  _i5.Dio _singletonDio;

  _i6.DioClient _singletonDioClient;

  _i7.MerchantsApi _singletonMerchantsApi;

  _i8.ProductsApi _singletonProductsApi;

  _i9.UserApi _singletonUserApi;

  _i10.CartApi _singletonCartApi;

  _i11.ReceiptApi _singletonReceiptApi;

  _i12.Repository _singletonRepository;

  static _i13.Future<_i1.AppComponent> create(_i2.NetworkModule networkModule,
      _i3.PreferenceModule preferenceModule) async {
    final injector = AppComponent$Injector._(networkModule, preferenceModule);

    return injector;
  }

  _i14.MyApp _createMyApp() => _i14.MyApp();
  _i12.Repository _createRepository() =>
      _singletonRepository ??= _networkModule.provideRepository(
          _createMerchantsApi(),
          _createProductsApi(),
          _createUserApi(),
          _createCartApi(),
          _createReceiptApi(),
          _createSharedPreferenceHelper());
  _i7.MerchantsApi _createMerchantsApi() => _singletonMerchantsApi ??=
      _networkModule.provideMerchantsApi(_createDioClient());
  _i6.DioClient _createDioClient() =>
      _singletonDioClient ??= _networkModule.provideDioClient(_createDio());
  _i5.Dio _createDio() => _singletonDio ??=
      _networkModule.provideDio(_createSharedPreferenceHelper());
  _i4.SharedPreferenceHelper _createSharedPreferenceHelper() =>
      _singletonSharedPreferenceHelper ??=
          _preferenceModule.provideSharedPreferenceHelper();
  _i8.ProductsApi _createProductsApi() => _singletonProductsApi ??=
      _networkModule.provideProductsApi(_createDioClient());
  _i9.UserApi _createUserApi() =>
      _singletonUserApi ??= _networkModule.provideUserApi(_createDioClient());
  _i10.CartApi _createCartApi() =>
      _singletonCartApi ??= _networkModule.provideCartApi(_createDioClient());
  _i11.ReceiptApi _createReceiptApi() => _singletonReceiptApi ??=
      _networkModule.provideReceiptApi(_createDioClient());
  @override
  _i14.MyApp get app => _createMyApp();
  @override
  _i12.Repository getRepository() => _createRepository();
}
