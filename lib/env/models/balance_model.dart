class BalanceModelResponse {
  int? status;
  String? message;
  BalanceModel? data;

  BalanceModelResponse({
    this.status,
    this.message,
    this.data,
  });

  factory BalanceModelResponse.fromJson(Map<String, dynamic> json) =>
      BalanceModelResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : BalanceModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class BalanceModel {
  int? balance;

  BalanceModel({
    this.balance,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
      };
}
