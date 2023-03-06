import 'dart:convert';
import 'dart:math';

import 'package:saver/Services/shared_prefrences_service.dart';

class ItemModelSearch {
  int? id;
  String name;
  String catagory;
  String datePurchased;
  String expiryDate;
  String dateAdded;
  String notes;
  double purchaseAmount;
  int expectedLifeSpan;
  bool isLive;
  int pastLife;
  String reciptImage;
  String productImage;
  ItemModelSearch({
    this.id,
    required this.name,
    required this.catagory,
    required this.datePurchased,
    required this.expiryDate,
    required this.dateAdded,
    required this.notes,
    required this.purchaseAmount,
    required this.expectedLifeSpan,
    required this.isLive,
    required this.pastLife,
    required this.reciptImage,
    required this.productImage,
  });

  ItemModelSearch copyWith({
    int? id,
    String? name,
    String? catagory,
    String? datePurchased,
    String? expiryDate,
    String? dateAdded,
    String? notes,
    double? purchaseAmount,
    int? expectedLifeSpan,
    bool? isLive,
    int? pastLife,
    String? reciptImage,
    String? productImage,
  }) {
    return ItemModelSearch(
      id: id ?? this.id,
      name: name ?? this.name,
      catagory: catagory ?? this.catagory,
      datePurchased: datePurchased ?? this.datePurchased,
      expiryDate: expiryDate ?? this.expiryDate,
      dateAdded: dateAdded ?? this.dateAdded,
      notes: notes ?? this.notes,
      purchaseAmount: purchaseAmount ?? this.purchaseAmount,
      expectedLifeSpan: expectedLifeSpan ?? this.expectedLifeSpan,
      isLive: isLive ?? this.isLive,
      pastLife: pastLife ?? this.pastLife,
      reciptImage: reciptImage ?? this.reciptImage,
      productImage: productImage ?? this.productImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'catagory': catagory,
      'datePurchased': datePurchased,
      'expiryDate': expiryDate,
      'dateAdded': dateAdded,
      'notes': notes,
      'purchaseAmount': purchaseAmount,
      'expectedLifeSpan': expectedLifeSpan,
      'isLive': isLive ? 0 : 1,
      'pastLife': pastLife,
      'reciptImage': reciptImage,
      'productImage': productImage,
    };
  }

  factory ItemModelSearch.fromMap(Map<String, dynamic> map) {
    return ItemModelSearch(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      catagory: map['catagory'] ?? '',
      datePurchased: map['datePurchased'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      dateAdded: map['dateAdded'] ?? '',
      notes: map['notes'] ?? '',
      purchaseAmount: map['purchaseAmount']?.toDouble() ?? 0.0,
      expectedLifeSpan: map['expectedLifeSpan']?.toInt() ?? 0,
      isLive: map['isLive'] == 0 ? false : true,
      pastLife: map['pastLife']?.toInt() ?? 0,
      reciptImage: map['reciptImage'] ?? '',
      productImage: map['productImage'] ?? '',
    );
  }

  /// save amount per month
  double getSaveAmount() {
    return max(purchaseAmount / expectedLifeSpan, 0);
  }

  double getProgress() {
    // print((getSaveAmount() * _getMonthsPassed() / getInflatedAmount()));
    return max(
        (getSaveAmount() * getMonthsPassed() / getInflatedAmount()).abs(), 0);
  }

  /// SAVINGS FOR MONTHS PASSED
  double getSavings() {
    return min(getSaveAmount() * getMonthsPassed(),
        (getInflatedAmount() / expectedLifeSpan) * expectedLifeSpan);
  }

  double getMonthsPassed() {
    Duration dur = DateTime.now().difference(DateTime.parse(datePurchased));
    return (dur.inDays / 30);
  }

  double _getMonthUnderLifeExpectancy() {
    Duration dur = DateTime.parse(datePurchased)
        .add(Duration(days: expectedLifeSpan * 30))
        .difference(DateTime.parse(datePurchased));
    return (dur.inDays / 30);
  }

  double getInflatedAmount() {
    return max(
        purchaseAmount *
            (pow((SharedPrefrencesService.inflation / 100) + 1,
                expectedLifeSpan / 12)),
        0);
  }

  String toJson() => json.encode(toMap());

  factory ItemModelSearch.fromJson(String source) =>
      ItemModelSearch.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, catagory: $catagory, datePurchased: $datePurchased, expiryDate: $expiryDate, dateAdded: $dateAdded, notes: $notes, purchaseAmount: $purchaseAmount, expectedLifeSpan: $expectedLifeSpan, isLive: $isLive, pastLife: $pastLife, reciptImage: $reciptImage, productImage: $productImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModelSearch &&
        other.id == id &&
        other.name == name &&
        other.catagory == catagory &&
        other.datePurchased == datePurchased &&
        other.expiryDate == expiryDate &&
        other.dateAdded == dateAdded &&
        other.notes == notes &&
        other.purchaseAmount == purchaseAmount &&
        other.expectedLifeSpan == expectedLifeSpan &&
        other.isLive == isLive &&
        other.pastLife == pastLife &&
        other.reciptImage == reciptImage &&
        other.productImage == productImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        catagory.hashCode ^
        datePurchased.hashCode ^
        expiryDate.hashCode ^
        dateAdded.hashCode ^
        notes.hashCode ^
        purchaseAmount.hashCode ^
        expectedLifeSpan.hashCode ^
        isLive.hashCode ^
        pastLife.hashCode ^
        reciptImage.hashCode ^
        productImage.hashCode;
  }
}
