import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../service/interface/network_model.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel extends Equatable with INetworkModel<ResponseModel> {
  final String? message;
  final String? code;

  const ResponseModel({
    this.message,
    this.code,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$ResponseModelFromJson(json);
  }

  @override
  Map<String, dynamic>? toJson() {
    return _$ResponseModelToJson(this);
  }

  @override
  List<Object?> get props => [message, code];
}
