import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/models/pamentHistortydataModel.dart';
import 'package:dating_app/models/planModel.dart';
import 'package:dating_app/models/user_model.dart';

import 'matches_api.dart';

class DataBase
{
  final firebaseStore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getPlans()async{
    var data = await firebaseStore.collection("plans").get();
    return data;
  }
  
  Future<VipPlanDetail> getVipPlan(String planId)async
  {
    var _d = await firebaseStore.collection("plans").doc(planId).get();

    var p = VipPlanDetail.fromJson(_d.data()??{});
    return p;
  }


  Future<void> getTransectionHistory() async{
    var data = await firebaseStore.collection("paymentHistory").where("userId",isEqualTo: UserModel().user.userId).get();
    List<PaymentHistory> _data = data.docs.map((e){
      return PaymentHistory.fromJson(e.data());
    }).toList();
  }

}