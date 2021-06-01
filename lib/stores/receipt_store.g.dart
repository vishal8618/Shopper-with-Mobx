// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReceiptStore on _ReceiptStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ReceiptStore.loading'))
      .value;
  Computed<bool> _$receiptDetailLoadingComputed;

  @override
  bool get receiptDetailLoading => (_$receiptDetailLoadingComputed ??=
          Computed<bool>(() => super.receiptDetailLoading,
              name: '_ReceiptStore.receiptDetailLoading'))
      .value;
  Computed<bool> _$cancelOrderLoadingComputed;

  @override
  bool get cancelOrderLoading => (_$cancelOrderLoadingComputed ??=
          Computed<bool>(() => super.cancelOrderLoading,
              name: '_ReceiptStore.cancelOrderLoading'))
      .value;

  final _$successAtom = Atom(name: '_ReceiptStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$fetchReceiptFutureAtom =
      Atom(name: '_ReceiptStore.fetchReceiptFuture');

  @override
  ObservableFuture<List<ReceiptModel>> get fetchReceiptFuture {
    _$fetchReceiptFutureAtom.reportRead();
    return super.fetchReceiptFuture;
  }

  @override
  set fetchReceiptFuture(ObservableFuture<List<ReceiptModel>> value) {
    _$fetchReceiptFutureAtom.reportWrite(value, super.fetchReceiptFuture, () {
      super.fetchReceiptFuture = value;
    });
  }

  final _$receiptListAtom = Atom(name: '_ReceiptStore.receiptList');

  @override
  List<ReceiptModel> get receiptList {
    _$receiptListAtom.reportRead();
    return super.receiptList;
  }

  @override
  set receiptList(List<ReceiptModel> value) {
    _$receiptListAtom.reportWrite(value, super.receiptList, () {
      super.receiptList = value;
    });
  }

  final _$fetchReceiptDetailFutureAtom =
      Atom(name: '_ReceiptStore.fetchReceiptDetailFuture');

  @override
  ObservableFuture<ReceiptDetailModel> get fetchReceiptDetailFuture {
    _$fetchReceiptDetailFutureAtom.reportRead();
    return super.fetchReceiptDetailFuture;
  }

  @override
  set fetchReceiptDetailFuture(ObservableFuture<ReceiptDetailModel> value) {
    _$fetchReceiptDetailFutureAtom
        .reportWrite(value, super.fetchReceiptDetailFuture, () {
      super.fetchReceiptDetailFuture = value;
    });
  }

  final _$fetchCancelOrderFutureAtom =
      Atom(name: '_ReceiptStore.fetchCancelOrderFuture');

  @override
  ObservableFuture<LikeModel> get fetchCancelOrderFuture {
    _$fetchCancelOrderFutureAtom.reportRead();
    return super.fetchCancelOrderFuture;
  }

  @override
  set fetchCancelOrderFuture(ObservableFuture<LikeModel> value) {
    _$fetchCancelOrderFutureAtom
        .reportWrite(value, super.fetchCancelOrderFuture, () {
      super.fetchCancelOrderFuture = value;
    });
  }

  final _$getReceiptAsyncAction = AsyncAction('_ReceiptStore.getReceipt');

  @override
  Future<dynamic> getReceipt({String uid, bool paginated}) {
    return _$getReceiptAsyncAction
        .run(() => super.getReceipt(uid: uid, paginated: paginated));
  }

  final _$getReceiptDetailAsyncAction =
      AsyncAction('_ReceiptStore.getReceiptDetail');

  @override
  Future<dynamic> getReceiptDetail({String id, String uid}) {
    return _$getReceiptDetailAsyncAction
        .run(() => super.getReceiptDetail(id: id, uid: uid));
  }

  final _$cancelOrderAsyncAction = AsyncAction('_ReceiptStore.cancelOrder');

  @override
  Future<dynamic> cancelOrder(String orderId, {String uid}) {
    return _$cancelOrderAsyncAction
        .run(() => super.cancelOrder(orderId, uid: uid));
  }

  @override
  String toString() {
    return '''
success: ${success},
fetchReceiptFuture: ${fetchReceiptFuture},
receiptList: ${receiptList},
fetchReceiptDetailFuture: ${fetchReceiptDetailFuture},
fetchCancelOrderFuture: ${fetchCancelOrderFuture},
loading: ${loading},
receiptDetailLoading: ${receiptDetailLoading},
cancelOrderLoading: ${cancelOrderLoading}
    ''';
  }
}
