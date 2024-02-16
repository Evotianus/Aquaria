class Timers {
  int? id;
  int? minutes;
  int? userId;
  int? fishId;
  String? dayName;

  Timers(
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

  factory Timers.fromJson(Map<String, dynamic> json) {
    return Timers(
      json["id"],
      json["minutes"],
      json["userId"],
      json["fishId"],
      json["dayName"],
    );
  }
}
