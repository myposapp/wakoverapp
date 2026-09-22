class StoreHub {
  final String id;
  final String name;
  final String handle;
  final String category;
  final double rating;
  final int reviewCount;
  final String location;
  final bool isVerified;
  final String description;

  StoreHub({
    required this.id,
    required this.name,
    required this.handle,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.isVerified,
    required this.description,
  });

  factory StoreHub.fromJson(Map<String, dynamic> json) {
    return StoreHub(
      id: json['id'] as String,
      name: json['name'] as String,
      handle: json['handle'] as String,
      category: json['category'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      location: json['location'] as String,
      isVerified: json['isVerified'] as bool,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'handle': handle,
      'category': category,
      'rating': rating,
      'reviewCount': reviewCount,
      'location': location,
      'isVerified': isVerified,
      'description': description,
    };
  }
}
