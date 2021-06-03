import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/models/common/general_response.dart';
import 'package:greetings_world_shopper/stores/success_store.dart';
import 'package:greetings_world_shopper/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

import 'error_store.dart';

// Include generated file
part 'password_store.g.dart';

class PasswordStore = _PasswordStore with _$PasswordStore;

abstract class _PasswordStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  // for forgot password
  final ErrorStore errorStore = ErrorStore();
  final SuccessStore successStore = SuccessStore();

  // for reset password
  final ErrorStore resetErrorStore = ErrorStore();
  final SuccessStore resetSuccessStore = SuccessStore();

  // constructor:---------------------------------------------------------------
  _PasswordStore(Repository repository) : this._repository = repository {
    // setting up disposers
    _setupDisposers();
  }

  void resetData() {
    this.success = false;
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<GeneralResponse> emptyFetchForgotPasswordResponse =
      ObservableFuture.value(null);

  Repository getRepository() => _repository;

  @observable
  ObservableFuture<GeneralResponse> fetchForgotPasswordFuture =
      ObservableFuture<GeneralResponse>(emptyFetchForgotPasswordResponse);

  static ObservableFuture<GeneralResponse> emptyResetPasswordResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<GeneralResponse> resetPasswordFuture =
      ObservableFuture<GeneralResponse>(emptyResetPasswordResponse);

  @observable
  bool isEditing = false;

  @action
  updateIsEditing() {
    isEditing = !isEditing;
  }

  @observable
  bool success = false;

  @observable
  bool error = false;

  // Address address;

  @computed
  bool get loading => fetchForgotPasswordFuture.status == FutureStatus.pending || resetPasswordFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------

  @action
  Future forgotPassword({String email}) async {
    final future = _repository.forgotPassword(
      email: email,
    );
    fetchForgotPasswordFuture = ObservableFuture(future);
    future.then((value) {
      successStore.successMessage = value.message;
      this.success = value.status;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
      this.error = true;
    });
  }


  @action
  Future resetPassword({String email, String password, String confirmPassword}) async {
    final future = _repository.resetPassword(
      email: email,
      password: password,
      confirmPassword: confirmPassword
    );
    resetPasswordFuture = ObservableFuture(future);
    future.then((value) {
      resetSuccessStore.successMessage = value.message;
      this.success = value.status;
    }).catchError((error) {
      resetErrorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
      this.error = true;
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
