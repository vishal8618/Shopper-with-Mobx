import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/models/like/like_model.dart';
import 'package:greetings_world_shopper/models/report/report_model.dart';
import 'package:greetings_world_shopper/stores/success_store.dart';
import 'package:greetings_world_shopper/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

import 'error_store.dart';

part 'product_store.g.dart';

class ProductStore = _ProductStore with _$ProductStore;

abstract class _ProductStore with Store {
  // repository instance
  Repository _repository;
  @observable
  bool success = false;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();
  final SuccessStore successStore = SuccessStore();

  // constructor:---------------------------------------------------------------
  _ProductStore(Repository repository) : this._repository = repository;

  static ObservableFuture<LikeModel> emptyWishResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<LikeModel> fetchWishFuture =
      ObservableFuture<LikeModel>(emptyWishResponse);


  static ObservableFuture<LikeModel> emptyFavouriteResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<LikeModel> fetchFavouriteFuture =
  ObservableFuture<LikeModel>(emptyFavouriteResponse);


  static ObservableFuture<ReportModel> emptyReportResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<ReportModel> fetchReportFuture =
      ObservableFuture<ReportModel>(emptyReportResponse);

  @action
  Future addWish({String uid, String productId}) async {
    final future = _repository.addWish(uid: uid, productId: productId);
    fetchWishFuture = ObservableFuture(future);
    print(fetchWishFuture.status.toString());
    future.then((model) {
      this.success = true;
      successStore.successMessage = model.message;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });

    /*   fetchWishFuture = ObservableFuture(future);
    future.then((merchantsList) {}).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });*/
  }

  @action
  Future removeWish({String uid, String productId}) async {
    final future = _repository.removeWish(uid: uid, productId: productId);
    fetchWishFuture = ObservableFuture(future);
    print(fetchWishFuture.status.toString());
    future.then((model) {
      this.success = true;
      successStore.successMessage = model.message;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

  @action
  Future addFavourite({String uid, String productId}) async {
    final future = _repository.addFavourite(uid: uid, productId: productId);
    fetchFavouriteFuture = ObservableFuture(future);
    print(fetchFavouriteFuture.status.toString());
    future.then((model) {
      this.success = true;
      successStore.successMessage = model.message;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

  @action
  Future removeFavourite({String uid, String productId}) async {
    final future = _repository.removeFavourite(uid: uid, productId: productId);
    fetchFavouriteFuture = ObservableFuture(future);
    print(fetchFavouriteFuture.status.toString());
    future.then((model) {
      this.success = true;
      successStore.successMessage = model.message;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }
////Report Section
  @action
  Future addProductReport({String uid, String productId, String reason}) async {
    final future = _repository.addProductReport(
        uid: uid, productId: productId, reason: reason);
    fetchReportFuture = ObservableFuture(future);
    future.then((merchantsList) {}).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future addMerchantReport(
      {String uid, String merchantId, String reason}) async {
    final future = _repository.addMerchantReport(
        uid: uid, merchantId: merchantId, reason: reason);
    fetchReportFuture = ObservableFuture(future);
    future.then((merchantsList) {}).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
