import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/models/common/general_response.dart';
import 'package:greetings_world_shopper/models/confirmation/register_confirmation_model.dart';
import 'package:greetings_world_shopper/models/generate_otp/otp_model.dart';
import 'package:greetings_world_shopper/models/user/login_model.dart';
import 'package:greetings_world_shopper/models/user/user_model.dart';
import 'package:greetings_world_shopper/stores/success_store.dart';
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
  final SuccessStore successStore = SuccessStore();
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
      this.userEmail = value ?? "";
    });
    repository.getPhoneNumber.then((value) {
      this.phoneNumber = value ?? "";
    });
    repository.getAddress1.then((value) {
      this.address1 = value ?? "";
    });
    repository.getAddress2.then((value) {
      this.address2 = value ?? "";
    });
    repository.getState.then((value) {
      this.state = value ?? "";
    });

    repository.getCity.then((value) {
      this.userCity = value ?? "";
    });

    repository.getZip.then((value) {
      this.userZip = value ?? "";
    });

    /*repository.getFullAddress.then((value) {
       if (value != null) this. = Address.fromJson(jsonDecode(value));
     });*/
  }

  void resetData() {
    this.user = null;
    this.success = false;
    isLoggedIn = false;
    uid = "";
    userImage = "";
    name = "";
    userEmail = "";
    phoneNumber = "";
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

  static ObservableFuture<GeneralResponse> emptyFetchForgotPasswordResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<GeneralResponse> fetchForgotPasswordFuture =
      ObservableFuture<GeneralResponse>(emptyFetchForgotPasswordResponse);

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


  static ObservableFuture<RegisterConfirmationModel> emptyConfirmationRegisterResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<RegisterConfirmationModel> fetchConfirmationRegisterFuture =
  ObservableFuture<RegisterConfirmationModel>(emptyConfirmationRegisterResponse);


  static ObservableFuture<GenerateOtpModel> emptyGenerateOtpCodeResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<GenerateOtpModel> fetchGenerateOtpCodeFuture =
  ObservableFuture<GenerateOtpModel>(emptyGenerateOtpCodeResponse);



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

  bool isLoggedIn = false;

  bool confirmUser = false;

  String uid = "";
  String name = "";
  String userImage = "";
  String userEmail = "";
  String phoneNumber = "";
  String address = "";
  String address1 = "";
  String address2 = "";
  String userCity = "";
  String state = "";
  String userZip = "";
  String country = "";

  // Address address;

  @observable
  File image;

  @observable
  UserModel user;

  @computed
  bool get loading =>
      fetchSignupFuture.status == FutureStatus.pending ||
      fetchLoginFuture.status == FutureStatus.pending ||
          fetchForgotPasswordFuture.status == FutureStatus.pending ||
      fetchProfileDetailsFuture.status == FutureStatus.pending ||
      fetchAddressDetailsFuture.status == FutureStatus.pending ||
      fetchGenerateOtpCodeFuture.status == FutureStatus.pending ||
      fetchConfirmationRegisterFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  updateImage(File image) {
    this.image = image;
  }

  @action
  Future signUp(
      {String fullName, String email, String password, String phone, String deviceType}) async {
    final future = _repository.signUp(
        email: email,
        fullName: fullName,
        password: password,
        phone: phone,
        deviceType: deviceType,
        image: image == null
            ? ""
            : "data:image/jpeg;base64," +
                base64Encode(Io.File(image.path).readAsBytesSync()));
    fetchSignupFuture = ObservableFuture(future);
    future.then((user) {
      //_repository.saveIsLoggedIn(true);
      _repository.saveUserId(user.id);
      if (user.buyerPhoto != null) {
        _repository.saveImage(user.buyerPhoto);
      }
      _repository
          .saveName("${user.firstName.toString()} ${user.lastName.toString()}");
      _repository.saveEmail(user.email.toString());
      _repository.savePhoneNumber(user.phoneNumber.toString());

      this.user = user;
      this.success = true;
      //isLoggedIn = true;
      uid = user.id.toString();
      userImage = user.buyerPhoto;
      name = "${user.firstName.toString()} ${user.lastName.toString()}";
      userEmail = user.email.toString();
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
      _repository.saveConfirmUser(user.confirmedUser);

      if(user.buyer != null){

      }
      _repository.saveUserId(user.buyer.id);
      if (user.buyer.buyerPhoto != null) {
        _repository.saveImage(user.buyer.buyerPhoto);
      }
      _repository.saveName(
          "${user.buyer.firstName.toString()} ${user.buyer.lastName.toString()}");
      _repository.saveEmail(user.buyer.email.toString());
      _repository.savePhoneNumber(user.buyer.phoneNumber);
      if (user.buyerAddress != null) {
        _repository.saveAddress(jsonEncode(user.buyerAddress.toJson()));
      }
      if (user.buyerAddress != null) {
        _repository.saveAddress1(user.buyerAddress.street1.toString());
        print('=====>${user.buyerAddress.street1}');
        _repository.saveAddress2(user.buyerAddress.street2.toString());
        _repository.saveCity(user.buyerAddress.city.toString());
        _repository.saveState(user.buyerAddress.stateName.toString());
        _repository.saveZip(user.buyerAddress.zip.toString());
        _repository.saveCountry(user.buyerAddress.countryName.toString());
        // _repository.saveAddress(jsonEncode(user.buyer.address.toJson()));
      }

      this.success = true;
      this.error = false;
      isLoggedIn = true;
      userImage = user.buyer.buyerPhoto;
      uid = user.buyer.id.toString();
      print('uid===========>$uid');
      name =
          "${user.buyer.firstName.toString()} ${user.buyer.lastName.toString()}";
      userEmail = user.user.email.toString();
      phoneNumber = user.buyer.phoneNumber.toString();

      address1 = user.buyerAddress.street1.toString();
      address2 = user.buyerAddress.street2.toString();
      userCity = user.buyerAddress.city.toString();
      state = user.buyerAddress.stateName.toString();
      userZip = user.buyerAddress.zip.toString();
      country = user.buyerAddress.countryName.toString();

    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
      this.error = true;
    });
  }

  @action
  Future userDetails({String uid}) async {
    final future = _repository.userDetail(uid: uid);
    fetchSignupFuture = ObservableFuture(future);
    future.then((user) {
      _repository.saveIsLoggedIn(true);
      _repository.saveUserId(user.id);
      if (user.buyerPhoto != null) {
        _repository.saveImage(user.buyerPhoto);
      }
      _repository
          .saveName("${user.firstName.toString()} ${user.lastName.toString()}");
      _repository.saveEmail(user.email.toString());
      _repository.savePhoneNumber(user.phoneNumber);
      _repository.saveAddress(jsonEncode(user.address.toJson()));

      if (user.address != null) {
        _repository.saveAddress1(user.address.street1.toString());
        _repository.saveAddress2(user.address.street2.toString());
        _repository.saveCity(user.address.city.toString());
        _repository.saveState(user.address.stateName.toString());
        _repository.saveZip(user.address.zip.toString());
        _repository.saveCountry(user.address.countryName.toString());
      }

      this.user = user;
      this.success = true;
      isLoggedIn = true;
      uid = user.id.toString();
      userImage = user.buyerPhoto;
      name = "${user.firstName.toString()} ${user.lastName.toString()}";
      userEmail = user.email.toString();
      phoneNumber = user.phoneNumber.toString();
      address1 = user.address.street1.toString();
      address2 = user.address.street2.toString();
      userCity = user.address.city.toString();
      state = user.address.stateName.toString();
      userZip = user.address.zip;
      country = user.address.countryName;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

  Future updateUserDetails(String uid, {String fullName, String phone}) async {
    final future = _repository.updateProfile(uid,
        fullName: fullName,
        phone: phone,
        image: image == null
            ? ""
            : "data:image/jpeg;base64," +
                base64Encode(Io.File(image.path).readAsBytesSync()));
    fetchProfileDetailsFuture = ObservableFuture(future);
    future.then((user) {
      _repository.saveIsLoggedIn(true);
      _repository.saveUserId(user.id);

      if (user.buyerPhoto != null) {
        _repository.saveImage(user.buyerPhoto);
      }
      _repository
          .saveName("${user.firstName.toString()} ${user.lastName.toString()}");
      _repository.saveEmail(user.email.toString());
      _repository.savePhoneNumber(user.phoneNumber);

      this.user = user;
      this.success = true;
      isLoggedIn = true;
      uid = user.id.toString();
      userImage = user.buyerPhoto;
      name = "${user.firstName.toString()} ${user.lastName.toString()}";
      phoneNumber = user.phoneNumber.toString();
      userEmail = user.email.toString();
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
    print("updateUserAddress");
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
      if (user.address != null) {
        _repository.saveAddress(jsonEncode(user.address.toJson()));
      }
      if (user.address != null) {
        _repository.saveAddress1(user.address.street1);
        _repository.saveAddress2(user.address.street2);
        _repository.saveCity(user.address.city);
        _repository.saveState(user.address.stateName);
        _repository.saveZip(user.address.zip);
        _repository.saveCountry(user.address.countryName);
      }

      this.user = user;
      this.success = true;
      isLoggedIn = true;
      uid = user.id.toString();
      address1 = user.address.street1.toString();
      address2 = user.address.street2.toString();
      userCity = user.address.city;
      state = user.address.stateName;
      userZip = user.address.zip;
      country = user.address.countryName;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
    });
  }

  @action
  Future userConfirmation({String token}) async {
    final future = _repository.confirmRegistration(token: token);
    fetchConfirmationRegisterFuture = ObservableFuture(future);
    future.then((user) {
      this.success = true;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
      this.error = true;
    });
  }

  @action
  Future getOtpCode({String uid ,String phoneNumber}) async {
    final future = _repository.getOtpCode(uid: uid, phoneNumber: phoneNumber);
    fetchGenerateOtpCodeFuture = ObservableFuture(future);
    future.then((user) {
      // this.success = true;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
      this.error = true;
    });
  }

  @action
  Future phoneVerify({String phoneNumber, String otp, String uid}) async {
    final future = _repository.phoneVerify(phoneNumber: phoneNumber, otp: otp, uid: uid);
    fetchGenerateOtpCodeFuture = ObservableFuture(future);
    future.then((user) {
       this.success = true;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
      this.success = false;
      this.error = true;
    });
  }

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
