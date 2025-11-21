import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  ProductModel({
    required String id,
    required String title,
    required double price,
    required String thumbnail,
    required List<String> images,
    required String description,
    required String category,
  }) : super(
          id: id,
          title: title,
          price: price,
          thumbnail: thumbnail,
          images: images,
          description: description,
          category: category,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

