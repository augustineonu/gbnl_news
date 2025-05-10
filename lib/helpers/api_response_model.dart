import 'dart:convert';

class ApiResponseModel {
    final dynamic message;
    final dynamic status;
    final dynamic data;

    ApiResponseModel({
        required this.message,
        required this.status,
         this.data,
    });

    factory ApiResponseModel.fromRawJson(String str) => ApiResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ApiResponseModel.fromJson(Map<String, dynamic> json) => ApiResponseModel(
        message: json["message"] ?? "No data",
        status: json["status"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data,
    };
}
