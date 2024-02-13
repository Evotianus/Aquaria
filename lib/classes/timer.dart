class Timer {
  int? id;
  int? minutes;
  int? userId;
  int? fishId;
  String? dayName;

  Timer(
    this.id,
    this.minutes,
    this.userId,
    this.fishId,
    this.dayName,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "minutes": minutes,
        "userId": userId,
        "fishId": fishId,
        "dayName": dayName,
      };

  factory Timer.fromJson(Map<String, dynamic> json) {
    return Timer(
      json["id"],
      json["minutes"],
      json["userId"],
      json["fishId"],
      json["dayName"],
    );
  }
}
