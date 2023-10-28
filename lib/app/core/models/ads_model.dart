import 'package:cloud_firestore/cloud_firestore.dart';

class AdsModel {
  List<dynamic> images;
  String title;
  String description;
  String category;
  String option;
  String type;
  String id;
  String status;
  String sellerId;
  bool isNew;
  bool paused;
  bool highlighted;
  int ratings;
  int likeCount;
  double price;
  double? oldPrice;
  Timestamp? createdAt;

  AdsModel({
    this.sellerId = '',
    this.oldPrice = 0,
    this.ratings = 0,
    this.likeCount = 0,
    this.status = '',
    this.highlighted = false,
    this.createdAt,
    this.paused = false,
    this.id = '',
    this.option = '',
    this.images = const [],
    this.title = '',
    this.description = '',
    this.category = '',
    this.type = '',
    this.isNew = true,
    this.price = 0,
  });

  factory AdsModel.fromDocument(DocumentSnapshot ds) => AdsModel(
        category: ds['category'],
        description: ds['description'],
        images: ds['images'],
        isNew: ds['new'],
        price: ds['price'].toDouble(),
        title: ds['title'],
        type: ds['type'],
        option: ds['option'],
        id: ds['id'],
        paused: ds['paused'],
        createdAt: ds['created_at'],
        highlighted: ds['highlighted'],
        status: ds['status'],
        ratings: ds['ratings'],
        likeCount: ds['like_count'],
        oldPrice: ds['old_price'].toDouble(),
        sellerId: ds['seller_id'],
      );

  Map<String, dynamic> toJson() => {
        'category': category,
        'description': description,
        'images': images,
        'new': isNew,
        'price': price,
        'title': title,
        'type': type,
        'option': option,
        'id': id,
        'created_at': createdAt,
        'paused': paused,
        'highlighted': highlighted,
        'status': status,
        'ratings': ratings,
        'like_count': likeCount,
        'old_price': oldPrice,
        'seller_id': sellerId,
      };

  /// Return a map with two fields: "length" and "rating"

  Future<Map<String, dynamic>> getRating() async {
    QuerySnapshot ratings = await FirebaseFirestore.instance
        .collection("ads")
        .doc(id)
        .collection("ratings")
        .where("status", isEqualTo: "VISIBLE")
        .get();

    double ratingGrade = 0;

    for (DocumentSnapshot rating in ratings.docs) {
      ratingGrade += rating.get("product_rating");
    }

    return {
      "rating": ratingGrade / ratings.docs.length,
      "length": ratings.docs.length,
    };
  }
}
