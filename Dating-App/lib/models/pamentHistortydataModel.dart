

class PaymentHistory {
  int? amount;
  DateTime? date;
  int? days;
  String? planId;
  String? planName;
  String? transictionId;
  String? userId;

  PaymentHistory({
    this.amount,
    this.date,
    this.days,
    this.planId,
    this.planName,
    this.transictionId,
    this.userId,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
    amount: json["amount"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    days: json["days"],
    planId: json["planId"],
    planName: json["planName"],
    transictionId: json["transictionId"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "date": date?.toIso8601String(),
    "days": days,
    "planId": planId,
    "planName": planName,
    "transictionId": transictionId,
    "userId": userId,
  };
}
