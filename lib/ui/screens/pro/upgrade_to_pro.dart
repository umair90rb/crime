import 'package:community_support/localization/demo_localization.dart';
import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/heading.dart';
import 'package:flutter/material.dart';

class UpgradeToPro extends StatefulWidget {
  @override
  _UpgradeToProState createState() => _UpgradeToProState();
}

class _UpgradeToProState extends State<UpgradeToPro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25,),
            Row(children: [BackButton()],),
            SizedBox(height: 10,),

            Heading(
              text: DemoLocalization.of(context).getTranslatedValue('buy_premium'),
              fontSize: 30,
            ),
            SizedBox(height: 10,),
            Heading(
              text: DemoLocalization.of(context).getTranslatedValue('unlock_report_feature'),
              fontSize: 20,
              align: TextAlign.center,
            ),

            SizedBox(height: 30,),

            Container(
              child: Icon(
                Icons.lock_open_rounded,
                size: 100,
                color: Colors.amber,
              ),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      const Color(0xFF3366FF),
                      const Color(0xFF00CCFF),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                ),
                shape: BoxShape.circle,
              ),
            ),

            SizedBox(height: 40,),
            
            RoundedButton(
                backgroundColor: Colors.amber,
                label: DemoLocalization.of(context).getTranslatedValue('pay_n_100'),
                textColor: Colors.black,
                onPressed: (){},
            ),

            SizedBox(height: 10,),

            Heading(
              text: DemoLocalization.of(context).getTranslatedValue('restore_purchase'),
              fontSize: 18,
            ),

            SizedBox(height: 10,),

            Heading(
              text: DemoLocalization.of(context).getTranslatedValue('payment_term'),
              fontSize: 14,
              align: TextAlign.justify,
              color: Colors.grey,
            ),

            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedButton(
                  width: 20,
                  borderRadius: 5,
                    label: DemoLocalization.of(context).getTranslatedValue('privacy_policy'),
                    onPressed: (){
                    Navigator.pushNamed(context, '/privacy');
                    },
                ),
                SizedBox(width: 10,),
                RoundedButton(
                  width: 20,
                    borderRadius: 5,
                    label: DemoLocalization.of(context).getTranslatedValue('terms_of_use'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/terms');
                    },
                ),
              ],
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
