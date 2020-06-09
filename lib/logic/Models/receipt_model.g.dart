// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) {
  return ReceiptModel(
    id: json['id'] as String,
    companyName: json['companyName'] as String,
    categoryName: json['categoryName'] as String,
    products: (json['products'] as List)
        ?.map((e) =>
            e == null ? null : ProductModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    sum: (json['sum'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ReceiptModelToJson(ReceiptModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'categoryName': instance.categoryName,
      'products': instance.products,
      'sum': instance.sum,
    };
