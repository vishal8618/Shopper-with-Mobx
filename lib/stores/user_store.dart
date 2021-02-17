import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:greetings_world_shopper/constants/strings.dart';
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
    repository.getEmail.then((value) {
      this.email = value ?? "";
    });
    repository.getPhoneNumber.then((value) {
      this.phoneNumber = value ?? "";
    });
    repository.getAddress.then((value) {
      this.address1 = value ?? "";
    });
    repository.getAddress2.then((value) {
      this.address2 = value ?? "";
    });
    repository.getState.then((value) {
      this.state = value ?? "";
    });

    repository.getCity.then((value) {
      this.city = value ?? "";
    });

    repository.getZip.then((value) {
      this.zip = value ?? "";
    });

    // repository.getAddress.then((value) {
    //   if (value != null) this.address = Address.fromJson(jsonDecode(value));
    // });
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

  // store variables:-----------------------------------------------------------
  static ObservableFuture<UserModel> emptyProfileDetailsResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<UserModel> fetchProfileDetailsFuture =
      ObservableFuture<UserModel>(emptyProfileDetailsResponse);

  // store variables:-----------------------------------------------------------
  static ObservableFuture<UserModel> emptyAddressDetailsResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<UserModel> fetchAddressDetailsFuture =
      ObservableFuture<UserModel>(emptyAddressDetailsResponse);

  @observable
  bool isEditing = false;

  @action
  updateIsEditing() {
    isEditing = !isEditing;
  }

  @observable
  bool success = false;

  bool isLoggedIn = false;

  String uid = "";
  String name = "";
  String userImage = "";
  String email = "";
  String phoneNumber = "";
  String address1 = "";
  String address2 = "";
  String city = "";
  String state = "";
  String zip = "";

  // Address address;

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
      _repository.saveEmail(user.email);
      _repository.savePhoneNumber(user.phoneNumber);

      this.user = user;
      this.success = true;
      isLoggedIn = true;
      uid = user.id.toString();
      userImage = user.buyerPhoto;
      name = "${user.firstName.toString()} ${user.lastName.toString()}";
      email = user.email.toString();
      phoneNumber = user.phoneNumber.toString();
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
      _repository.saveEmail(user.buyer.email);
      _repository.savePhoneNumber(user.buyer.phoneNumber);
      _repository.saveAddress(jsonEncode(user.buyerAddress.toJson()));

      _repository.saveAddress(user.buyerAddress.street1);
      _repository.saveAddress2(user.buyerAddress.street2);
      _repository.saveCity(user.buyerAddress.city);
      _repository.saveState(user.buyerAddress.stateName);
      _repository.saveZip(user.buyerAddress.zip);
      // _repository.saveAddress(jsonEncode(user.buyer.address.toJson()));

      this.success = true;
      isLoggedIn = true;
      userImage = user.buyer.buyerPhoto;
      uid = user.buyer.id.toString();
      name =
          "${user.buyer.firstName.toString()} ${user.buyer.lastName.toString()}";
      email = user.buyer.email.toString();
      phoneNumber = user.buyer.phoneNumber.toString();
      address1 = user.buyerAddress.street1.toString();
      address2 = user.buyerAddress.street2.toString();
      city = user.buyerAddress.city.toString();
      state = user.buyerAddress.stateName.toString();
      zip = user.buyerAddress.zip.toString();
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
      _repository.saveEmail(user.email.toString());
      _repository.savePhoneNumber(user.phoneNumber);
      _repository.saveAddress(jsonEncode(user.address.toJson()));

      _repository.saveAddress(user.address.street1);
      _repository.saveAddress2(user.address.street2);
      _repository.saveCity(user.address.city);
      _repository.saveState(user.address.stateName);
      _repository.saveZip(user.address.zip);

      this.user = user;
      this.success = true;
      isLoggedIn = true;
      uid = user.id.toString();
      userImage = user.buyerPhoto;
      name = "${user.firstName.toString()} ${user.lastName.toString()}";
      email = user.email.toString();
      phoneNumber = user.phoneNumber;
      address1 = user.address.street1;
      address2 = user.address.street2;
      city = user.address.city;
      state = user.address.stateName;
      zip = user.address.zip;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

  @action
  Future updateUserDetails(String uid, {String fullName, String phone}) async {
    final future = _repository.updateProfile(uid,
        fullName: fullName,
        phone: phone,
        image: image == null
            ? "" : base64Encode(Io.File(image.path).readAsBytesSync()));
    fetchProfileDetailsFuture = ObservableFuture(future);
    future.then((user) {
      _repository.saveIsLoggedIn(true);
      _repository.saveUserId(user.id);
      _repository.saveImage(user.buyerPhoto);
      _repository
          .saveName("${user.firstName.toString()} ${user.lastName.toString()}");
      _repository.saveEmail(user.email.toString());
      _repository.savePhoneNumber(user.phoneNumber);
      _repository.saveAddress(jsonEncode(user.address.toJson()));

      this.user = user;
      this.success = true;
      isLoggedIn = true;
      uid = user.id.toString();
      userImage = user.buyerPhoto;
      name = "${user.firstName.toString()} ${user.lastName.toString()}";
      phoneNumber = user.phoneNumber.toString();
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

  //update address

  @action
  Future updateUserAddress(String uid,
      {String city,
      String street1,
      String street2,
      String countryName,
      String stateName,
      String zip,
      String lat,
      String lng}) async {
    final future = _repository.updateAddress(uid,
        city: city,
        street1: street1,
        street2: street2,
        countryName: countryName,
        stateName: stateName,
        zip: zip,
        lat: lat,
        lng: lng);
    fetchAddressDetailsFuture = ObservableFuture(future);

    future.then((user) {
      _repository.saveIsLoggedIn(true);
      _repository.saveUserId(user.id);
      _repository.saveAddress(jsonEncode(user.address.toJson()));
      _repository.saveAddress(user.address.street1);
      _repository.saveAddress2(user.address.street2);
      _repository.saveCity(user.address.city);
      _repository.saveState(user.address.stateName);
      _repository.saveZip(user.address.zip);

      this.user = user;
      this.success = true;
      isLoggedIn = true;
      uid = user.id.toString();
      address1 = user.address.street1;
      address2 = user.address.street2;
      city = user.address.city;
      state = user.address.stateName;
      zip = user.address.zip;
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
