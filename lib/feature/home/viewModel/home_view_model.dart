import 'package:dio/dio.dart';

import '../../../constant/app_constant.dart';
import '../../../core/loading.dart';
import '../../../core/crypt.dart';
import '../../../service/network_manager.dart';
import '../../../service/project_network_manager.dart';
import '../model/data_model.dart';
import '../view/home_view.dart';

abstract class HomeViewModel extends LoadingStatefull<HomeView> {
  List<DataModel> items = [];
  final INetworkManager networkManager = INetworkManager(ProjectNetworkManager.instance.service);

  var formData = FormData.fromMap({
    'frmID': Crypt().encrypt("dioTest"),
    'id': Crypt().encrypt("1"),
    'token': Crypt().encrypt(AppConstant.instance.queryKey),
  });
}
