import '../../../constant/app_constant.dart';
import '../../../core/loading.dart';
import '../../../core/crypt.dart';
import '../model/data_model.dart';
import '../view/home_view.dart';

abstract class HomeViewModel extends LoadingStatefull<HomeView> {
  List<DataModel> items = [];

  final Map<String, dynamic> formData = {
    'frmID': Crypt().encrypt("dioTest"),
    'id': Crypt().encrypt("1"),
    'token': Crypt().encrypt(AppConstant.instance.queryKey),
  };
}
