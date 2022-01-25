import 'package:app/enums/view_state.dart';
import 'package:app/locator.dart';
import 'package:app/model/data_model.dart';
import 'package:app/services/api_service.dart';
import 'package:app/services/firebase_service.dart';
import 'package:app/viewmodel/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final ApiService api = locator<ApiService>();
  final FirebaseService service = locator<FirebaseService>();
  int _currentIndex = 0;

  late Map<String, DataModel> _data, _allCountries, _favorites;

  Map<String, DataModel> get data => _data;
  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    if (index == 0) {
      _data = _allCountries;
    } else {
      _data = _favorites;
    }
    notifyListeners();
  }

  void updateFavorites(DataModel item, bool toAdd) async {
    if (toAdd) {
      _favorites[item.country] = item;
    } else {
      _favorites.remove(item.country);
    }
    await service.saveFavorites(_favorites.keys.toList());
    notifyListeners();
  }

  void onModelReady() async {
    _favorites = {};
    _data = _allCountries = {};
    await getData();
    for (var res in await service.fetchFavorites()) {
      _favorites[res] = _allCountries[res]!;
    }
  }

  Future<void> getData() async {
    setState(ViewState.BUSY);
    try {
      for (var res in await api.getData()) {
        _allCountries[res.country] = res;
      }

      for (var key in _favorites.keys) {
        _favorites[key] = _allCountries[key]!;
      }

      _data = _currentIndex == 0 ? _allCountries : _favorites;
    } catch (e) {
      setState(ViewState.ERROR);
      setErrorMessage(e.toString());
    }
    setState(ViewState.IDLE);
  }
}
