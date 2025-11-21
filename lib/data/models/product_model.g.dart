// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'thumbnail': instance.thumbnail,
      'images': instance.images,
      'description': instance.description,
      'category': instance.category,
    };
