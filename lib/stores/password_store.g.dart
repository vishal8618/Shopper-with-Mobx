// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PasswordStore on _PasswordStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_PasswordStore.loading'))
      .value;

  final _$fetchForgotPasswordFutureAtom =
      Atom(name: '_UserStore.fetchForgotPasswordFuture');

  @override
  ObservableFuture<GeneralResponse> get fetchForgotPasswordFuture {
    _$fetchForgotPasswordFutureAtom.reportRead();
    return super.fetchForgotPasswordFuture;
  }

  @override
  set fetchForgotPasswordFuture(ObservableFuture<GeneralResponse> value) {
    _$fetchForgotPasswordFutureAtom
        .reportWrite(value, super.fetchForgotPasswordFuture, () {
      super.fetchForgotPasswordFuture = value;
    });
  }

  final _$resetPasswordFutureAtom =
      Atom(name: '_UserStore.resetPasswordFuture');

  @override
  ObservableFuture<GeneralResponse> get resetPasswordFuture {
    _$resetPasswordFutureAtom.reportRead();
    return super.resetPasswordFuture;
  }

  @override
  set resetPasswordFuture(ObservableFuture<GeneralResponse> value) {
    _$resetPasswordFutureAtom
        .reportWrite(value, super.resetPasswordFuture, () {
      super.resetPasswordFuture = value;
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

  final _$resetPasswordAsyncAction = AsyncAction('_UserStore.resetPassword');

  @override
  Future<dynamic> resetPassword({String email, String password, String confirmPassword}) {
    return _$resetPasswordAsyncAction
        .run(() => super.resetPassword(email: email, password: password, confirmPassword: confirmPassword));
  }

  final _$forgotPasswordAsyncAction = AsyncAction('_UserStore.forgotPassword');

  @override
  Future<dynamic> forgotPassword({String email}) {
    return _$forgotPasswordAsyncAction
        .run(() => super.forgotPassword(email: email));
  }

  @override
  String toString() {
    return '''
fetchForgotPasswordFuture: ${fetchForgotPasswordFuture},
resetPasswordFuture: ${resetPasswordFuture},
isEditing: ${isEditing},
success: ${success},
error: ${error},
loading: ${loading}
    ''';
  }
}
