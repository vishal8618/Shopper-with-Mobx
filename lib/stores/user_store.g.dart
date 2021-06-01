// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_UserStore.loading'))
      .value;

  final _$fetchSignupFutureAtom = Atom(name: '_UserStore.fetchSignupFuture');

  @override
  ObservableFuture<UserModel> get fetchSignupFuture {
    _$fetchSignupFutureAtom.reportRead();
    return super.fetchSignupFuture;
  }

  @override
  set fetchSignupFuture(ObservableFuture<UserModel> value) {
    _$fetchSignupFutureAtom.reportWrite(value, super.fetchSignupFuture, () {
      super.fetchSignupFuture = value;
    });
  }

  final _$fetchLoginFutureAtom = Atom(name: '_UserStore.fetchLoginFuture');

  @override
  ObservableFuture<LoginModel> get fetchLoginFuture {
    _$fetchLoginFutureAtom.reportRead();
    return super.fetchLoginFuture;
  }

  @override
  set fetchLoginFuture(ObservableFuture<LoginModel> value) {
    _$fetchLoginFutureAtom.reportWrite(value, super.fetchLoginFuture, () {
      super.fetchLoginFuture = value;
    });
  }

  final _$fetchProfileDetailsFutureAtom =
      Atom(name: '_UserStore.fetchProfileDetailsFuture');

  @override
  ObservableFuture<UserModel> get fetchProfileDetailsFuture {
    _$fetchProfileDetailsFutureAtom.reportRead();
    return super.fetchProfileDetailsFuture;
  }

  @override
  set fetchProfileDetailsFuture(ObservableFuture<UserModel> value) {
    _$fetchProfileDetailsFutureAtom
        .reportWrite(value, super.fetchProfileDetailsFuture, () {
      super.fetchProfileDetailsFuture = value;
    });
  }

  final _$fetchAddressDetailsFutureAtom =
      Atom(name: '_UserStore.fetchAddressDetailsFuture');

  @override
  ObservableFuture<UserModel> get fetchAddressDetailsFuture {
    _$fetchAddressDetailsFutureAtom.reportRead();
    return super.fetchAddressDetailsFuture;
  }

  @override
  set fetchAddressDetailsFuture(ObservableFuture<UserModel> value) {
    _$fetchAddressDetailsFutureAtom
        .reportWrite(value, super.fetchAddressDetailsFuture, () {
      super.fetchAddressDetailsFuture = value;
    });
  }

  final _$fetchConfirmationRegisterFutureAtom =
      Atom(name: '_UserStore.fetchConfirmationRegisterFuture');

  @override
  ObservableFuture<RegisterConfirmationModel>
      get fetchConfirmationRegisterFuture {
    _$fetchConfirmationRegisterFutureAtom.reportRead();
    return super.fetchConfirmationRegisterFuture;
  }

  @override
  set fetchConfirmationRegisterFuture(
      ObservableFuture<RegisterConfirmationModel> value) {
    _$fetchConfirmationRegisterFutureAtom
        .reportWrite(value, super.fetchConfirmationRegisterFuture, () {
      super.fetchConfirmationRegisterFuture = value;
    });
  }

  final _$fetchGenerateOtpCodeFutureAtom =
      Atom(name: '_UserStore.fetchGenerateOtpCodeFuture');

  @override
  ObservableFuture<GenerateOtpModel> get fetchGenerateOtpCodeFuture {
    _$fetchGenerateOtpCodeFutureAtom.reportRead();
    return super.fetchGenerateOtpCodeFuture;
  }

  @override
  set fetchGenerateOtpCodeFuture(ObservableFuture<GenerateOtpModel> value) {
    _$fetchGenerateOtpCodeFutureAtom
        .reportWrite(value, super.fetchGenerateOtpCodeFuture, () {
      super.fetchGenerateOtpCodeFuture = value;
    });
  }

  final _$isEditingAtom = Atom(name: '_UserStore.isEditing');

  @override
  bool get isEditing {
    _$isEditingAtom.reportRead();
    return super.isEditing;
  }

  @override
  set isEditing(bool value) {
    _$isEditingAtom.reportWrite(value, super.isEditing, () {
      super.isEditing = value;
    });
  }

  final _$successAtom = Atom(name: '_UserStore.success');

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

  final _$errorAtom = Atom(name: '_UserStore.error');

  @override
  bool get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(bool value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$imageAtom = Atom(name: '_UserStore.image');

  @override
  Io.File get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(Io.File value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$userAtom = Atom(name: '_UserStore.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$signUpAsyncAction = AsyncAction('_UserStore.signUp');

  @override
  Future<dynamic> signUp(
      {String fullName,
      String email,
      String password,
      String phone,
      String deviceType}) {
    return _$signUpAsyncAction.run(() => super.signUp(
        fullName: fullName,
        email: email,
        password: password,
        phone: phone,
        deviceType: deviceType));
  }

  final _$loginAsyncAction = AsyncAction('_UserStore.login');

  @override
  Future<dynamic> login({String email, String password}) {
    return _$loginAsyncAction
        .run(() => super.login(email: email, password: password));
  }

  final _$userDetailsAsyncAction = AsyncAction('_UserStore.userDetails');

  @override
  Future<dynamic> userDetails({String uid}) {
    return _$userDetailsAsyncAction.run(() => super.userDetails(uid: uid));
  }

  final _$updateUserAddressAsyncAction =
      AsyncAction('_UserStore.updateUserAddress');

  @override
  Future<dynamic> updateUserAddress(String uid,
      {String city,
      String street1,
      String street2,
      String countryName,
      String stateName,
      String zip,
      String lat,
      String lng}) {
    return _$updateUserAddressAsyncAction.run(() => super.updateUserAddress(uid,
        city: city,
        street1: street1,
        street2: street2,
        countryName: countryName,
        stateName: stateName,
        zip: zip,
        lat: lat,
        lng: lng));
  }

  final _$userConfirmationAsyncAction =
      AsyncAction('_UserStore.userConfirmation');

  @override
  Future<dynamic> userConfirmation({String token}) {
    return _$userConfirmationAsyncAction
        .run(() => super.userConfirmation(token: token));
  }

  final _$getOtpCodeAsyncAction = AsyncAction('_UserStore.getOtpCode');

  @override
  Future<dynamic> getOtpCode({String uid, String phoneNumber}) {
    return _$getOtpCodeAsyncAction
        .run(() => super.getOtpCode(uid: uid, phoneNumber: phoneNumber));
  }

  final _$phoneVerifyAsyncAction = AsyncAction('_UserStore.phoneVerify');

  @override
  Future<dynamic> phoneVerify({String phoneNumber, String otp, String uid}) {
    return _$phoneVerifyAsyncAction.run(
        () => super.phoneVerify(phoneNumber: phoneNumber, otp: otp, uid: uid));
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  dynamic updateIsEditing() {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.updateIsEditing');
    try {
      return super.updateIsEditing();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateImage(Io.File image) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.updateImage');
    try {
      return super.updateImage(image);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchSignupFuture: ${fetchSignupFuture},
fetchLoginFuture: ${fetchLoginFuture},
fetchProfileDetailsFuture: ${fetchProfileDetailsFuture},
fetchAddressDetailsFuture: ${fetchAddressDetailsFuture},
fetchConfirmationRegisterFuture: ${fetchConfirmationRegisterFuture},
fetchGenerateOtpCodeFuture: ${fetchGenerateOtpCodeFuture},
isEditing: ${isEditing},
success: ${success},
error: ${error},
image: ${image},
user: ${user},
loading: ${loading}
    ''';
  }
}
