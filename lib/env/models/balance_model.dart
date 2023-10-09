class ResponseResultBalanceModel {
  int? status;
  String? message;
  BalanceModel? data;

  ResponseResultBalanceModel({
    this.status,
    this.message,
    this.data,
  });

  factory ResponseResultBalanceModel.fromJson(Map<String, dynamic> json) =>
      ResponseResultBalanceModel(
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
