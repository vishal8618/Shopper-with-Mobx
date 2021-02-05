import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/models/merchants/merchant_model.dart';
import 'package:greetings_world_shopper/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'error_store.dart';

// Include generated file
part 'merchants_store.g.dart';

class MerchantStore = _MerchantStore with _$MerchantStore;

abstract class _MerchantStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _MerchantStore(Repository repository) : this._repository = repository;

  @observable
  String searchText = "";

  @observable
  int tab = 0;

  int offset = 0;
  int limit = 5;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<MerchantModel>> emptyMerchantsResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<List<MerchantModel>> fetchMerchantsFuture =
      ObservableFuture<List<MerchantModel>>(emptyMerchantsResponse);

  @observable
  List<MerchantModel> merchantsList;

  @computed
  bool get loading => fetchMerchantsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getMerchants({String search, String tab, bool paginated}) async {
    // if (paginated) offset += 5;

    // final future = _repository.getMerchants(
    //     search: search, tab: tab, offset: offset, limit: limit);

    final future = _repository.getMerchants(
        search: search, tab: tab);

    // if (!paginated)
      fetchMerchantsFuture = ObservableFuture(future);

    future.then((merchantsList) {
      // if (paginated)
      //   this.merchantsList.addAll(merchantsList);
      // else
        this.merchantsList = merchantsList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future<List<String>> getSearches(String query) async {
    var searches = await _repository.getSearches;
    var data = searches
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return data;
  }

  @action
  followMerchant({String uid, String merchantId}) async {
    final future = _repository.followMerchant(merchantId: merchantId, uid: uid);

    future.then((merchantsList) {}).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  unFollowMerchant({String uid, String merchantId}) async {
    final future =
        _repository.unFollowMerchant(merchantId: merchantId, uid: uid);

    future.then((merchantsList) {}).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future addSearch(String query) async {
    return await _repository.saveSearch(query);
  }

  @action
  void updateTab(int tab) {
    merchantsList = List();

    offset = 0;
    this.tab = tab;
    getMerchants(
        tab: tab == 0 ? "Online" : "Brick and Mortar",
        search: searchText,
        paginated: false);
  }

  //update text back
  @action
  void updateSearch(String text) {
    offset = 0;
    merchantsList = List();
    searchText = text;
    getMerchants(
        search: text,
        tab: tab == 0 ? "Online" : "Brick and Mortar",
        paginated: false);
  }
}
