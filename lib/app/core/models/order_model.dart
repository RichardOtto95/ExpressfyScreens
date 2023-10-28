import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  double? freight;
  int? amount;
  double? price;
  double? rating;
  String? status;
  String? token;
  String? addressId;
  String? id;
  String? customerId;
  String? adsId;
  String? sellerId;
  String? discontinuedBy;
  String? userIdDiscontinued;
  String? discontinuedReason;
  bool? rated;
  Timestamp? createdAt;
  Timestamp? startDate;
  Timestamp? endDate;
  Timestamp? sendDate;

  OrderModel({
    this.id,
    this.customerId,
    this.adsId,
    this.sellerId,
    this.discontinuedBy,
    this.discontinuedReason,
    this.userIdDiscontinued,
    this.rating,
    this.startDate,
    this.endDate,
    this.freight,
    this.amount,
    this.rated,
    this.status,
    this.price,
    this.token,
    this.addressId,
    this.createdAt,
    this.sendDate,
  });

  factory OrderModel.fromDocumentSnapshot(DocumentSnapshot doc) => OrderModel(
        id: doc['id'],
        customerId: doc['customer_id'],
        sellerId: doc['seller_id'],
        discontinuedBy: doc['discontinued_by'],
        discontinuedReason: doc['discontinued_reason'],
        userIdDiscontinued: doc['user_id_discontinued'],
        startDate: doc['start_date'],
        endDate: doc['end_date'],
        freight: doc['freight'].toDouble(),
        amount: doc['amount'],
        price: doc['price'].toDouble(),
        rated: doc['rated'],
        status: doc['status'],
        token: doc['token'],
        addressId: doc['address_id'],
        createdAt: doc['created_at'],
        adsId: doc['ads_id'],
        sendDate: doc['send_date'],
        rating: doc['rating'] != null ? doc['rating'].toDouble() : null,
      );

  Map<String, dynamic> toJson({OrderModel? order}) => order == null
      ? {
          'id': id,
          'customer_id': customerId,
          'seller_id': sellerId,
          'discontinued_by': discontinuedBy,
          'discontinued_reason': discontinuedReason,
          'start_date': startDate,
          'end_date': endDate,
          'freight': freight,
          'amount': amount,
          'rated': rated,
          'status': status,
          'token': token,
          'address_id': addressId,
          'created_at': createdAt,
          'price': price,
          'ads_id': adsId,
          'user_id_discontinued': userIdDiscontinued,
          'send_date': sendDate,
          'rating': rating,
        }
      : {
          'id': order.id,
          'customer_id': order.customerId,
          'seller_id': order.sellerId,
          'discontinued_by': order.discontinuedBy,
          'discontinued_reason': order.discontinuedReason,
          'start_date': order.startDate,
          'end_date': order.endDate,
          'freight': order.freight,
          'amount': order.amount,
          'rated': order.rated,
          'status': order.status,
          'token': order.token,
          'address_id': order.addressId,
          'created_at': order.createdAt,
          'price': order.price,
          'ads_id': order.adsId,
          'user_id_discontinued': order.userIdDiscontinued,
          'send_date': order.sendDate,
          'rating': order.rating,
        };
}
