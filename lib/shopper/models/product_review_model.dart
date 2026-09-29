import 'package:dart_mappable/dart_mappable.dart';

part 'product_review_model.mapper.dart';

@MappableClass()
class ProductReview with ProductReviewMappable {
  const ProductReview({
    this.id,
    this.rating,
    this.comment,
    this.name,
    this.user,
    this.createdAt,
  });

  final String? id;
  final num? rating;
  final String? comment;
  final String? name;
  // The reviewer, when the API embeds them.
  final dynamic user;
  final String? createdAt;

  String get authorName {
    final userName = user is Map ? user['name'] : null;
    return (name ?? userName ?? 'Customer').toString();
  }

  static final fromMap = ProductReviewMapper.fromMap;
  static final fromJson = ProductReviewMapper.fromJson;
}
