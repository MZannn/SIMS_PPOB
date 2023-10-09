class TransactionHistoryModelResponse {
  int? status;
  String? message;
  TransactionHistoryModel? data;

  TransactionHistoryModelResponse({
    this.status,
    this.message,
    this.data,
  });

  factory TransactionHistoryModelResponse.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryModelResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : TransactionHistoryModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class TransactionHistoryModel {
  int? offset;
  int? limit;
  List<TransactionHistory>? records;

  TransactionHistoryModel({
    this.offset,
    this.limit,
    this.records,
  });

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryModel(
        offset: json["offset"],
        limit: json["limit"],
        records: json["records"] == null
            ? []
            : List<TransactionHistory>.from(
                json["records"]!.map((x) => TransactionHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "records": records == null
            ? []
            : List<dynamic>.from(records!.map((x) => x.toJson())),
      };
}

class TransactionHistory {
  String? invoiceNumber;
  String? transactionType;
  String? description;
  int? totalAmount;
  DateTime? createdOn;

  TransactionHistory({
    this.invoiceNumber,
    this.transactionType,
    this.description,
    this.totalAmount,
    this.createdOn,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        invoiceNumber: json["invoice_number"],
        transactionType: json["transaction_type"],
        description: json["description"],
        totalAmount: json["total_amount"],
        createdOn: json["created_on"] == null
            ? null
            : DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "transaction_type": transactionType,
        "description": description,
        "total_amount": totalAmount,
        "created_on": createdOn?.toIso8601String(),
      };
}
