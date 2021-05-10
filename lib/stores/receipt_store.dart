import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/models/like/like_model.dart';
import 'package:greetings_world_shopper/models/receipt/receipt_model.dart';
import 'package:greetings_world_shopper/models/receipt_detail/receipt_detail_model.dart';
import 'package:greetings_world_shopper/stores/success_store.dart';
import 'package:greetings_world_shopper/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

import 'error_store.dart';

part 'receipt_store.g.dart';

class ReceiptStore = _ReceiptStore with _$ReceiptStore;

abstract class _ReceiptStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // store for handling errors
  final SuccessStore successStore = SuccessStore();

  // constructor:---------------------------------------------------------------
  _ReceiptStore(Repository repository) : this._repository = repository;

  @observable
  bool success = false;

  int offset = 0;
  int limit = 5;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<List<ReceiptModel>> emptyReceiptResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<List<ReceiptModel>> fetchReceiptFuture =
      ObservableFuture<List<ReceiptModel>>(emptyReceiptResponse);

  @observable
  List<ReceiptModel> receiptList;

  @computed
  bool get loading => fetchReceiptFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getReceipt({String uid, bool paginated}) async {
    // if (paginated) offset += 5;

    // final future = _repository.getMerchants(
    //     search: search, tab: tab, offset: offset, limit: limit);

    final future = _repository.getReceipt(uid: uid);

    // if (!paginated)
    fetchReceiptFuture = ObservableFuture(future);

    future.then((receiptList) {
      // if (paginated)
      //   this.merchantsList.addAll(merchantsList);
      // else
      this.receiptList = receiptList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<ReceiptDetailModel> emptyReceiptDetailResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<ReceiptDetailModel> fetchReceiptDetailFuture =
      ObservableFuture<ReceiptDetailModel>(emptyReceiptDetailResponse);

  @computed
  bool get receiptDetailLoading =>
      fetchReceiptDetailFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getReceiptDetail({String id, String uid}) async {
    final future = _repository.getReceiptDetail(id: id, uid: uid);
    fetchReceiptDetailFuture = ObservableFuture(future);

    future.then((receipt) {}).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  //cancel order store

// store variables:-----------------------------------------------------------
  static ObservableFuture<LikeModel> emptyCancelOrderResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<LikeModel> fetchCancelOrderFuture =
      ObservableFuture<LikeModel>(emptyCancelOrderResponse);

  @computed
  bool get cancelOrderLoading =>
      fetchCancelOrderFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future cancelOrder(String orderId, {String uid}) async {
    final future = _repository.cancelOrder(orderId, uid: uid);
    fetchCancelOrderFuture = ObservableFuture(future);
    future.then((receipt) {
      this.success = true;
      successStore.successMessage = receipt.message;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

// disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // general methods:-----------------------------------------------------------

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
