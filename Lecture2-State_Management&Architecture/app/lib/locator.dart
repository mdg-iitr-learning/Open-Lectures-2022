import 'package:app/services/local_storage_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() async {
  locator.registerSingleton<LocalStorageService>(
    await LocalStorageService.getInstance(),
  );
}
