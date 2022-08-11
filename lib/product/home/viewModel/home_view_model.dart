import 'package:dio/dio.dart';

import '../../../constant/app_constant.dart';
import '../../../core/loading.dart';
import '../../../core/crypt.dart';
import '../../../service/network_manager.dart';
import '../../../service/project_network_manager.dart';
import '../model/dio_test_model.dart';
import '../view/home_view.dart';

abstract class HomeViewModel extends LoadingStatefull<HomeView> {
  late final INetworkManager _networkManager;
  List<DioTestModel> items = [];

  var formData = FormData.fromMap({
    'frmID': Crypt().encrypt("dioTest"),
    'id': Crypt().encrypt("1"),
    'token': Crypt().encrypt(AppConstant.instance.queryKey),
  });

  @override
  void initState() {
    super.initState();
    _networkManager = INetworkManager(ProjectNetworkManager.instance.service);
    _fetchData();
  }

  Future<void> _fetchData() async {
    changeLoading();
    items = await _networkManager.fetchData<DioTestModel, DioTestModel>(formData, model: DioTestModel());
    changeLoading();
  }
}
