class ServiceModelResponse {
  int? status;
  String? message;
  List<ServiceModel>? data;

  ServiceModelResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ServiceModelResponse.fromJson(Map<String, dynamic> json) =>
      ServiceModelResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ServiceModel>.from(
                json["data"]!.map((x) => ServiceModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ServiceModel {
  String? serviceCode;
  String? serviceName;
  String? serviceIcon;
  int? serviceTariff;

  ServiceModel({
    this.serviceCode,
    this.serviceName,
    this.serviceIcon,
    this.serviceTariff,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        serviceCode: json["service_code"],
        serviceName: json["service_name"],
        serviceIcon: json["service_icon"],
        serviceTariff: json["service_tariff"],
      );

  Map<String, dynamic> toJson() => {
        "service_code": serviceCode,
        "service_name": serviceName,
        "service_icon": serviceIcon,
        "service_tariff": serviceTariff,
      };
}
