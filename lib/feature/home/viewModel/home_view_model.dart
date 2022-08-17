import 'package:flutter/cupertino.dart';

import '../../../constant/app_constant.dart';
import '../../../core/loading.dart';
import '../../../core/crypt.dart';
import '../model/data_model.dart';
import '../view/home_view.dart';

abstract class HomeViewModel extends LoadingStatefull<HomeView> {
  List<DataModel> data = [];
  bool dataIsLoading = false;
  late ScrollController scrollController;

  final Map<String, dynamic> formData = {
    'frmID': Crypt().encrypt("dioTest"),
    'id': Crypt().encrypt("1"),
    'token': Crypt().encrypt(AppConstant.instance.queryKey),
  };

  // void _listenScroll(context) {
  //   scrollController.addListener(() {
  //     if (scrollController.position.atEdge) {
  //       if (scrollController.position.pixels != 0) {
  //         BlocProvider.of<HomeCubit>(context).loadData(formData);
  //       }
  //     }
  //   });
  // }

  // _listenScroll(context);

}
