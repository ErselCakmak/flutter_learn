import '../../core/project_style.dart';

class AppConstant {
  static AppConstant? _instance;
  static AppConstant get instance {
    _instance ??= AppConstant._init();
    return _instance!;
  }

  AppConstant._init();

  final String baseUrl = "https://appkutusu.com/oacademy/process";
  final int queryTimeOut = 10;
  final String queryKey = 'nRJZ3ctCZVAWzFTA';

  final CustomColors color = CustomColors();
  final CustomTextStyle style = CustomTextStyle();
  final CustomPaddings padding = CustomPaddings();
  final CustomButton button = CustomButton();
}
