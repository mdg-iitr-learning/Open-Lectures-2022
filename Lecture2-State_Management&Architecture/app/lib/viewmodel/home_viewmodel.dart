import 'package:app/enums/view_state.dart';
import 'package:app/locator.dart';
import 'package:app/model/data_model.dart';
import 'package:app/services/api_service.dart';
import 'package:app/viewmodel/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final ApiService api = locator<ApiService>();

  late List<DataModel> _data;

  List<DataModel> get data => _data;

  set data(List<DataModel> data) {
    _data = data;
    notifyListeners();
  }

  void onModelReady() {
    getData();
  }

  Future<void> getData({bool isReload = false}) async {
    if (!isReload) setState(ViewState.BUSY);
    try {
      data = await api.getData();
    } catch (e) {
      setState(ViewState.ERROR);
      setErrorMessage(e.toString());
    }
    setState(ViewState.IDLE);
  }
}
