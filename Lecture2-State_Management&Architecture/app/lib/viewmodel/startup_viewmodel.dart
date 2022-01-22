import 'package:app/locator.dart';
import 'package:app/services/local_storage_service.dart';
import 'package:app/viewmodel/base_viewmodel.dart';

class StartUpViewModel extends BaseViewModel {
  final LocalStorageService localStorageService =
      locator<LocalStorageService>();

  Future<bool> onModelReady() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return localStorageService.isLoggedIn;
    });
  }
}
