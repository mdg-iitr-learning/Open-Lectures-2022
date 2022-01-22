import 'package:app/locator.dart';
import 'package:app/services/firebase_auth_service.dart';
import 'package:app/services/local_storage_service.dart';
import 'package:app/viewmodel/base_viewmodel.dart';

class ProfileViewModel extends BaseViewModel {
  final FirebaseAuthService _service = locator<FirebaseAuthService>();
  final LocalStorageService _storageService = locator<LocalStorageService>();

  Future<void> signout() async {
    await _service.signOut();
    _storageService.isLoggedIn = false;
  }
}
