import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  Timestamp? createdAt;
  double? productRating;
  double? sellerRating;
  double? deliveryRating;
  String? productOpnion;
  String? productAnswer;
  String? sellerAnswer;
  String? sellerOpnion;
  String? deliveryOpnion;
  String? deliveryAnswer;
  String? sellerId;
  String? customerId;
  String? adsId;
  String? status;
  String? id;
  String? orderId;
  bool? answered;
  int? scorefyRating;

  RatingModel({
    this.productAnswer,
    this.sellerAnswer,
    this.deliveryAnswer,
    this.answered,
    this.adsId,
    this.createdAt,
    this.customerId,
    this.deliveryOpnion,
    this.deliveryRating,
    this.id,
    this.orderId,
    this.productOpnion,
    this.productRating,
    this.scorefyRating,
    this.sellerId,
    this.sellerOpnion,
    this.sellerRating,
    this.status,
  });

  factory RatingModel.fromDocumentSnapshot(DocumentSnapshot doc) => RatingModel(
        adsId: doc['ads_id'],
        createdAt: doc['created_at'],
        customerId: doc['customer_id'],
        deliveryOpnion: doc['delivery_opnion'],
        deliveryRating: doc['delivery_rating'].toDouble(),
        id: doc['id'],
        productOpnion: doc['product_opnion'],
        productRating: doc['product_rating'].toDouble(),
        scorefyRating: doc['scorefy_rating'],
        sellerId: doc['seller_id'],
        sellerOpnion: doc['seller_opnion'],
        sellerRating: doc['seller_rating'].toDouble(),
        status: doc['status'],
        orderId: doc['order_id'],
        deliveryAnswer: doc['delivery_answer'],
        productAnswer: doc['seller_answer'],
        sellerAnswer: doc['product_answer'],
      );

  Map<String, dynamic> toJson({RatingModel? model}) => model != null
      ? {
          "ads_id": model.adsId,
          "created_at": model.createdAt,
          "customer_id": model.customerId,
          "delivery_opnion": model.deliveryOpnion,
          "delivery_rating": model.deliveryRating,
          "id": model.id,
          "product_opnion": model.productOpnion,
          "product_rating": model.productRating,
          "scorefy_rating": model.scorefyRating,
          "seller_id": model.sellerId,
          "seller_opnion": model.sellerOpnion,
          "seller_rating": model.sellerRating,
          "status": model.status,
          "order_id": model.orderId,
          "answered": model.answered,
          "product_answer": model.productAnswer,
          "seller_answer": model.sellerAnswer,
          "delivery_answer": model.deliveryAnswer,
        }
      : {
          "ads_id": adsId,
          "created_at": createdAt,
          "customer_id": customerId,
          "delivery_opnion": deliveryOpnion,
          "delivery_rating": deliveryRating,
          "id": id,
          "product_opnion": productOpnion,
          "product_rating": productRating,
          "scorefy_rating": scorefyRating,
          "seller_id": sellerId,
          "seller_opnion": sellerOpnion,
          "seller_rating": sellerRating,
          "status": status,
          "order_id": orderId,
          "answered": answered,
          "product_answer": productAnswer,
          "seller_answer": sellerAnswer,
          "delivery_answer": deliveryAnswer,
        };
}
