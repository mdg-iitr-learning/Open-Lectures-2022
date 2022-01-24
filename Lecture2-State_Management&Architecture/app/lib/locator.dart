import 'package:app/services/api_service.dart';
import 'package:app/services/firebase_auth_service.dart';
import 'package:app/services/local_storage_service.dart';
import 'package:app/viewmodel/home_viewmodel.dart';
import 'package:app/viewmodel/login_viewmodel.dart';
import 'package:app/viewmodel/profile_viewmodel.dart';
import 'package:app/viewmodel/register_viewmodel.dart';
import 'package:app/viewmodel/startup_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  // Services
  locator.registerSingleton<LocalStorageService>(
    await LocalStorageService.getInstance(),
  );
  locator.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  locator.registerSingleton<ApiService>(ApiService());

  // Viewmodel
  locator.registerFactory<StartUpViewModel>(() => StartUpViewModel());
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
}
