
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? id;
  String curtainHeight;
  String curtainWidth;
  String curtainPriceForSelling;
  String curtainRealPrice;
  String curtainSellPrice;
  String benefit;
  String createdDate;
  String finishDate;
  String collectionType;
  String? status;

  Product({ this.id,
    required this.curtainHeight,
    required this.curtainWidth,
    required this.curtainPriceForSelling,
    required this.curtainRealPrice,
    required this.curtainSellPrice,
    required this.benefit,
    required this.createdDate,
    required this.finishDate,
    required this.collectionType,
    required this.status});

  factory Product.fromFirestore(QueryDocumentSnapshot book) {
    return Product(
      id: book.id,
    curtainHeight: book.get('curtainHeight'),
  curtainWidth: book.get('curtainWidth'),
  curtainPriceForSelling: book.get('curtainPriceForSelling'),
  curtainRealPrice: book.get('curtainRealPrice'),
  curtainSellPrice: book.get('curtainSellPrice'),
  benefit: book.get('benefit'),
  createdDate: book.get('date'),
      finishDate: book.get('finishDate'),
  collectionType: book.get('collectionType'),
  status: book.get('status'),
    );
  }

}
