import 'dart:convert';

List<Product> productFromJson(List list) =>
    List<Product>.from(list.map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.imageUrl,
    this.name,
    this.shortDesc,
    this.origPrice,
    this.discountPrice,
    this.discountPercentage,
    this.longDesc,
  });

  String imageUrl;
  String name;
  String shortDesc;
  String origPrice;
  String discountPrice;
  String discountPercentage;
  LongDesc longDesc;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        imageUrl: json["imageURL"],
        name: json["name"],
        shortDesc: json["shortDesc"],
        origPrice: json["OrigPrice"],
        discountPrice: json["DiscountPrice"],
        discountPercentage: json["discountPercentage"],
        longDesc: LongDesc.fromJson(json["longDesc"]),
      );

  Map<String, dynamic> toJson() => {
        "imageURL": imageUrl,
        "name": name,
        "shortDesc": shortDesc,
        "OrigPrice": origPrice,
        "DiscountPrice": discountPrice,
        "discountPercentage": discountPercentage,
        "longDesc": longDesc.toJson(),
      };
}

class LongDesc {
  LongDesc({
    this.discountDetails,
    this.exchangeDtls,
    this.sizeDetails,
    this.seller,
    this.details,
  });

  String discountDetails;
  String exchangeDtls;
  List<Map<String, String>> sizeDetails;
  String seller;
  List<Map<String, String>> details;

  factory LongDesc.fromJson(Map<String, dynamic> json) => LongDesc(
        discountDetails: json["discountDetails"],
        exchangeDtls: json["exchangeDtls"],
        sizeDetails: List<Map<String, String>>.from(json["sizeDetails"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
        seller: json["seller"],
        details: List<Map<String, String>>.from(json["details"].map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
      );

  Map<String, dynamic> toJson() => {
        "discountDetails": discountDetails,
        "exchangeDtls": exchangeDtls,
        "sizeDetails": List<dynamic>.from(sizeDetails.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
        "seller": seller,
        "details": List<dynamic>.from(details.map(
            (x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
      };
}
