class Campaign {
  final String id;
  final String title;
  final String code;
  final String discount;
  String status; // 'active', 'paused'
  int usedCount;
  final String duration;

  Campaign({
    required this.id,
    required this.title,
    required this.code,
    required this.discount,
    required this.status,
    required this.usedCount,
    required this.duration,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'] as String,
      title: json['title'] as String,
      code: json['code'] as String,
      discount: json['discount'] as String,
      status: json['status'] as String,
      usedCount: json['usedCount'] as int,
      duration: json['duration'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'code': code,
      'discount': discount,
      'status': status,
      'usedCount': usedCount,
      'duration': duration,
    };
  }
}
