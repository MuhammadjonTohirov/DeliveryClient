// Domain enums
enum UserRole {
  customer,
  driver,
  restaurant,
  admin,
}

enum OrderStatus {
  placed,
  confirmed,
  preparing,
  readyForPickup,
  pickedUp,
  onTheWay,
  delivered,
  cancelled,
}

enum DriverAvailabilityStatus {
  available,
  busy,
  offline,
}

enum DriverTaskStatus {
  pending,
  accepted,
  rejected,
  pickedUp,
  delivered,
  cancelled,
}

enum Rating {
  one,
  two,
  three,
  four,
  five,
}

extension RatingExtension on Rating {
  int get value {
    switch (this) {
      case Rating.one:
        return 1;
      case Rating.two:
        return 2;
      case Rating.three:
        return 3;
      case Rating.four:
        return 4;
      case Rating.five:
        return 5;
    }
  }

  static Rating fromInt(int value) {
    switch (value) {
      case 1:
        return Rating.one;
      case 2:
        return Rating.two;
      case 3:
        return Rating.three;
      case 4:
        return Rating.four;
      case 5:
        return Rating.five;
      default:
        return Rating.one;
    }
  }
}
