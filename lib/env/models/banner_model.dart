class ResponseResultBannerModel {
  int? status;
  String? message;
  List<BannerModel>? data;

  ResponseResultBannerModel({
    this.status,
    this.message,
    this.data,
  });

  factory ResponseResultBannerModel.fromJson(Map<String, dynamic> json) =>
      ResponseResultBannerModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<BannerModel>.from(
                json["data"]!.map((x) => BannerModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BannerModel {
  String? bannerName;
  String? bannerImage;
  String? description;

  BannerModel({
    this.bannerName,
    this.bannerImage,
    this.description,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        bannerName: json["banner_name"],
        bannerImage: json["banner_image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "banner_name": bannerName,
        "banner_image": bannerImage,
        "description": description,
      };
}
