import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/models/user/login_model.dart';
import 'package:greetings_world_shopper/models/user/user_model.dart';
import 'package:greetings_world_shopper/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'error_store.dart';

// Include generated file
part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _UserStore(Repository repository) : this._repository = repository {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    repository.isLoggedIn.then((value) {
      this.isLoggedIn = value ?? false;
    });

    repository.getUid.then((value) {
      this.uid = value ?? "";
    });

    repository.getName.then((value) {
      this.name = value ?? "";
    });

    repository.getImage.then((value) {
      this.userImage = value ?? "";
    });

    repository.getAddress.then((value) {
      if (value != null) this.address = Address.fromJson(jsonDecode(value));
    });
  }

  // store variables:-----------------------------------------------------------
  static ObservableFuture<UserModel> emptySignupResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<UserModel> fetchSignupFuture =
      ObservableFuture<UserModel>(emptySignupResponse);

  static ObservableFuture<LoginModel> emptyLoginResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<LoginModel> fetchLoginFuture =
      ObservableFuture<LoginModel>(emptyLoginResponse);

  @observable
  bool success = false;

  bool isLoggedIn = false;

  String uid = "";
  String name = "";
  String userImage = "";
  Address address;

  @observable
  File image;

  @observable
  UserModel user;

  @computed
  bool get loading =>
      fetchSignupFuture.status == FutureStatus.pending ||
      fetchLoginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  updateImage(File image) {
    this.image = image;
  }

  @action
  Future signUp(
      {String fullName, String email, String password, String phone}) async {
    final future = _repository.signUp(
        email: email,
        fullName: fullName,
        password: password,
        phone: phone,
        image: image == null
            ? ""
            : base64Encode(Io.File(image.path).readAsBytesSync()));
    fetchSignupFuture = ObservableFuture(future);
    future.then((user) {
      _repository.saveIsLoggedIn(true);
      _repository.saveUserId(user.id);
      _repository.saveImage(user.buyerPhoto);
      _repository
          .saveName("${user.firstName.toString()} ${user.lastName.toString()}");

      this.user = user;
      this.success = true;
      isLoggedIn = true;
      uid = user.id.toString();
      userImage = user.buyerPhoto;
      name = "${user.firstName.toString()} ${user.lastName.toString()}";
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

  @action
  Future login({String email, String password}) async {
    final future = _repository.login(
      email: email,
      password: password,
    );
    fetchLoginFuture = ObservableFuture(future);
    future.then((user) {
      _repository.saveIsLoggedIn(true);
      _repository.saveUserId(user.buyer.id);
      _repository.saveImage(user.buyer.buyerPhoto);
      _repository.saveName(
          "${user.buyer.firstName.toString()} ${user.buyer.lastName.toString()}");
      _repository.saveAddress(jsonEncode(user.buyer.address.toJson()));

      this.user = user.buyer;
      this.success = true;
      isLoggedIn = true;
      userImage = user.buyer.buyerPhoto;
      uid = user.buyer.id.toString();
      name =
          "${user.buyer.firstName.toString()} ${user.buyer.lastName.toString()}";
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

  @action
  Future userDetails({String uid}) async {
    final future = _repository.userDetail(uid: uid);
    fetchSignupFuture = ObservableFuture(future);
    future.then((user) {
      _repository.saveIsLoggedIn(true);
      _repository.saveUserId(user.id);
      _repository.saveImage(user.buyerPhoto);
      _repository
          .saveName("${user.firstName.toString()} ${user.lastName.toString()}");
      _repository.saveAddress(jsonEncode(user.address.toJson()));

      this.user = user;
      this.success = true;
      isLoggedIn = true;
      uid = user.id.toString();
      userImage = user.buyerPhoto;
      name = "${user.firstName.toString()} ${user.lastName.toString()}";
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
