import 'package:json_annotation/json_annotation.dart';

import '../../../service/interface/network_model.dart';

part 'dio_test_model.g.dart';

@JsonSerializable()
class DioTestModel extends INetworkModel<DioTestModel> {
  final String? iD;
  final String? userID;
  final String? text;
  final String? date;

  DioTestModel({this.iD, this.userID, this.text, this.date});

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DioTestModelFromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() {
    return _$DioTestModelToJson(this);
  }
}
