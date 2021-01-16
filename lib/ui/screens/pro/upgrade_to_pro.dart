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
              text: 'Buy Premium',
              fontSize: 30,
            ),
            SizedBox(height: 10,),
            Heading(
              text: 'To unlock report feature you should have to pay N 100',
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
                label: 'Pay N 100',
                textColor: Colors.black,
                onPressed: (){},
            ),

            SizedBox(height: 10,),

            Heading(
              text: 'Restore purchase',
              fontSize: 18,
            ),

            SizedBox(height: 10,),

            Heading(
              text: 'Payments will be charged to your iTunes Account after confirmation Subscription automatically renewed unless auto-renewed is turned off At least 24 hours before the end of the subscription period. Account Will be charged for renewal with in 24 hours prior to the current period.',
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
                    label: 'Privacy Policy',
                    onPressed: (){
                    Navigator.pushNamed(context, '/privacy');
                    },
                ),
                SizedBox(width: 10,),
                RoundedButton(
                  width: 20,
                    borderRadius: 5,
                    label: 'Terms of Use',
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
