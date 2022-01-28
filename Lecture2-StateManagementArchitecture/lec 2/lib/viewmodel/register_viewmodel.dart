import 'package:app/locator.dart';
import 'package:app/services/firebase_service.dart';
import 'package:app/services/local_storage_service.dart';
import 'package:app/utils/validators.dart';
import 'package:app/viewmodel/base_viewmodel.dart';

import 'package:flutter/material.dart';

class RegisterViewModel extends BaseViewModel {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  bool _isHidden = true;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  // Getters
  bool get isHidden => _isHidden;

  TextEditingController get nameController => _nameController;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  String? Function(String? name) get nameValidator => Validator.nameValidator;

  String? Function(String? email) get emailValidator =>
      Validator.emailValidator;

  String? Function(String? password) get passwordValidator =>
      Validator.passwordValidator;

  String? Function(String? confirmPassword) get confirmPasswordValidator =>
      (confirmPassword) {
        return Validator.confirmPasswordValidator(
            confirmPassword, passwordController.text.trim());
      };

  // Setters
  set isHidden(bool val) {
    _isHidden = val;
    notifyListeners();
  }

  void onModelReady() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  void onModelDestroy() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  Future<bool> register() async {
    var res = await _firebaseService.signUp(
      _nameController.text,
      _emailController.text.trim(),
      _passwordController.text,
    );
    _localStorageService.isLoggedIn = res != null;
    return res != null;
  }
}
