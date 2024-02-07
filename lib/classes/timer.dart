class Timer {
  int? id;
  int? minutes;
  int? userId;
  int? fishId;

  Timer(
    this.id,
    this.minutes,
    this.userId,
    this.fishId,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "minutes": minutes,
        "userId": userId,
        "fishId": fishId,
      };

  factory Timer.fromJson(Map<String, dynamic> json) {
    return Timer(
      json["id"],
      json["minutes"],
      json["userId"],
      json["fishId"],
    );
  }
}
