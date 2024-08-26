

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/dialogs/vip_dialog.dart';
import 'package:dating_app/models/planModel.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';



class PlanViewTile extends StatefulWidget {
   final VipPlanDetail plan;
   final bool active;
   final Widget? icon;
  const PlanViewTile({this.active = false,this.icon,required this.plan,super.key});

  @override
  State<PlanViewTile> createState() => _PlanViewTileState();
}

class _PlanViewTileState extends State<PlanViewTile> {
  @override
  Widget build(BuildContext context) {

    Duration? leftDays;

    if(widget.active)
      {
       leftDays = getLeftDays(UserModel().user.activePlan!.planEndDate!);
      }


    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(

        leading: widget.icon??Image.asset('assets/images/crow_badge.png',
            width: 50, height: 50),

        //title
        title: Text("${widget.plan.planTitle}"??""),

        //title Style
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18, fontWeight: FontWeight.bold),

        //price
        subtitle: Text("${widget.plan.price?.toInt()}"),

        //price Text Style
        subtitleTextStyle:const  TextStyle(
            fontSize: 19,
            color: Colors.green,
            fontWeight: FontWeight.bold),



        //Button
        trailing: widget.active? Text("${leftDays!.inDays+1} Days left ",style: TextStyle(color: Colors.green,fontSize: 16),):ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith((s)=>const EdgeInsets.symmetric(horizontal: 10,vertical: 3)),
            foregroundColor:MaterialStateProperty.resolveWith((s)=>Colors.white) ,
           backgroundColor: MaterialStateProperty.resolveWith((s)=>Colors.green),
          ),
          onPressed: () async {

            Razorpay razorpay = Razorpay();

            var options = {
              'key': 'rzp_test_0wFRWIZnH65uny',
              'amount':
              int.parse("${widget.plan.price?.toInt()}") * 100, //in paise.
              'name': 'Friend Book',
              'description': 'Fine T-Shirt',
              'timeout': 60, // in seconds
              'prefill': {
                'contact': '7389681128',
                'email': 'gaurav.kumar@example.com'
              }
            };



            var date = DateTime.now();
            var date2 = DateTime.now();


            razorpay.open(options);
            razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
            razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
            razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);


          },child:const  Text("BUY"),),


      ),
    );
  }


  getLeftDays(DateTime endDate)
  {
    var crDate = DateTime.now();



    var _leftDate = endDate.difference(crDate);


    return _leftDate;
  }



  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    final _textStyle =
    TextStyle(fontSize: 18, color: Theme.of(context).scaffoldBackgroundColor);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>()));
    print("asdfasdfa 2 ");
    showDialog(context: context,barrierDismissible: false, builder: (context)=>  AlertDialog(
      title: Text('Success',style: TextStyle(fontSize: 22,color: Colors.white),),
      content:
      Text("You have successfuly purchased the subscription",style: TextStyle(fontSize: 15,color: Colors.white),),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
          Navigator.pop(context);
        }, child: Text('Ok', style: _textStyle,))
      ],

      ),
    );
    // Do something when payment succeeds
    
    var user = UserModel().user;
    var doc = FirebaseFirestore.instance.collection("Users").doc(user.userId);
    var doc2 = FirebaseFirestore.instance.collection("paymentHistory");

    var curruntDatTime = DateTime.now() ;


    var _d ={
      "activePlan":{
        "planId": widget.plan.id,
        "activeDate": curruntDatTime.toIso8601String(),
        "planEndDate":curruntDatTime.add(Duration(days: widget.plan.days??0)).toIso8601String(),
        "leftDay":0,
      }
    };


    var _history = {
      "date":curruntDatTime.toIso8601String(),
      "userId":user.userId,
      "planId":widget.plan.id,
      "planName":widget.plan.planTitle,
      "amount":widget.plan.price,
      "days":widget.plan.days,
      "transictionId":response.paymentId,
    };
    await doc.update(_d);
    await doc2.add(_history);
    
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails

    print("asdfasdfa 2 ");
    showDialog(context: context,barrierDismissible: false, builder: (context)=>const AlertDialog(
      title: Text('Failed to subscribe',style: TextStyle(fontSize: 22,color: Colors.white),),
      content: Text("You have cancelled the subscription",style: TextStyle(fontSize: 15,color: Colors.white),),
      actions: [

      ],

    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected

    print("asdfasdfa 1 ");
    showDialog(context: context, builder: (context)=>const AlertDialog(
      content: Text("Cancel"),
    ));
  }
}
