
import 'dart:convert';

VipPlanDetail vipPlanDetailFromJson(String str) => VipPlanDetail.fromJson(json.decode(str));

String vipPlanDetailToJson(VipPlanDetail data) => json.encode(data.toJson());

class VipPlanDetail {
  String? id;
  int? days;
  String? planTitle;
  int? price;

  VipPlanDetail({
    this.id,
    this.days,
    this.planTitle,
    this.price,
  });

  factory VipPlanDetail.fromJson(Map<String, dynamic> json) => VipPlanDetail(
    days: json["days"],
    planTitle: json["planTitle"],
    price: json["price"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "days": days,
    "planTitle": planTitle,
    "price": price,
  };
}
