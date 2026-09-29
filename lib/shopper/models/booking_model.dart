import 'package:dart_mappable/dart_mappable.dart';
import 'merchant_info_model.dart';
import 'product_image_model.dart';

part 'booking_model.mapper.dart';

@MappableClass()
class BookingPlace with BookingPlaceMappable {
  const BookingPlace({this.id, this.name, this.images});

  final String? id;
  final String? name;
  final List<ProductImage>? images;

  static final fromMap = BookingPlaceMapper.fromMap;
  static final fromJson = BookingPlaceMapper.fromJson;
}

@MappableClass()
class BookingVisitor with BookingVisitorMappable {
  const BookingVisitor({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.dateTime,
    this.code,
    this.description,
  });

  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  @MappableField(key: 'date_time')
  final String? dateTime;
  // Access code the visitor presents on arrival.
  final String? code;
  final String? description;

  static final fromMap = BookingVisitorMapper.fromMap;
  static final fromJson = BookingVisitorMapper.fromJson;
}

@MappableClass()
class Booking with BookingMappable {
  const Booking({
    this.id,
    this.status,
    this.bookingCode,
    this.dateTime,
    this.startDate,
    this.endDate,
    this.merchant,
    this.merchantPlaces,
    this.cart,
    this.visitors,
    this.paymentReference,
    this.createdAt,
  });

  final String? id;
  final String? status;
  @MappableField(key: 'booking_code')
  final String? bookingCode;
  // Set for time-slot bookings; stays use start/end dates instead.
  @MappableField(key: 'date_time')
  final String? dateTime;
  @MappableField(key: 'start_date')
  final String? startDate;
  @MappableField(key: 'end_date')
  final String? endDate;
  final MerchantInfo? merchant;
  @MappableField(key: 'merchant_places')
  final List<BookingPlace>? merchantPlaces;
  final List<BookingPlace>? cart;
  final List<BookingVisitor>? visitors;
  @MappableField(key: 'payment_reference')
  final String? paymentReference;
  final String? createdAt;

  /// What was booked: the places, or the cart items when no place is set.
  List<BookingPlace> get bookedItems {
    final places = merchantPlaces ?? const [];
    return places.isNotEmpty ? places : (cart ?? const []);
  }

  bool get canManageVisitors => status == 'upcoming' || status == 'active';

  static final fromMap = BookingMapper.fromMap;
  static final fromJson = BookingMapper.fromJson;
}
