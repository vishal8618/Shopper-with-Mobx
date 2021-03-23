import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/models/products/product_model.dart';
import 'package:greetings_world_shopper/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

import 'error_store.dart';

part 'merchant_detail_store.g.dart';

class MerchantDetailStore = _MerchantDetailStore with _$MerchantDetailStore;

abstract class _MerchantDetailStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _MerchantDetailStore(Repository repository) : this._repository = repository;

  @observable
  int tab = 0;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<ProductModel>> emptyProductsResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<List<ProductModel>> fetchProductsFuture =
      ObservableFuture<List<ProductModel>>(emptyProductsResponse);

  @observable
  List<ProductModel> productsList;

  @computed
  bool get loading => fetchProductsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getProducts({String id, String uid}) async {
    final future = _repository.getProducts(id: id,uid: uid);
    fetchProductsFuture = ObservableFuture(future);

    future.then((merchantsList) {
      this.productsList = merchantsList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }



  @action
  void updateTab(int tab) {
    this.tab = tab;
  }
}
