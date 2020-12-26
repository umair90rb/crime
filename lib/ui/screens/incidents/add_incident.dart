import 'package:community_support/ui/shared/bar.dart';
import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/card.dart';
import 'package:community_support/ui/widget/heading.dart';
import 'package:community_support/ui/widget/input.dart';
import 'package:flutter/material.dart';

class AddIncident extends StatelessWidget {

  List<String> crimeIcon = [
    'inturders',
    'child',
    'bulg',
    'murder',
  ];

  List<String> crime = [
    'Inturders',
    'Child Abuse',
    'Bulgery',
    'Murder'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('REPORT INCIDENT'),
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          SizedBox(height: 5,),
          Container(height: 160,
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, i){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                  child: IconCard(icon: crimeIcon[i], title: crime[i],),
                );
              },
            ),
          ),


          RoundedInput(
            backgroundColor: Colors.white,
            elevation: true,
            label: '',
            preIcon: Icons.location_pin,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 215,
                child: RoundedInput(
                  backgroundColor: Colors.white,
                  elevation: true,
                  label: '',
                  preIcon: Icons.calendar_today,
                ),
              ),
              SizedBox(
                width: 215,
                child: RoundedInput(
                  backgroundColor: Colors.white,
                  elevation: true,
                  label: 'Time',
                  preIcon: Icons.access_time,
                ),
              ),
            ],
          ),
          RoundedInput(
            borderRadius: 20,
            backgroundColor: Colors.white,
            maxLines: 5,
            label: 'Label',
            elevation: true,
          ),
          FlatButton.icon(onPressed: (){}, icon: Icon(Icons.camera), label: Text('Upload Photo/Video', style: TextStyle(decoration: TextDecoration.underline))),
          FlatButton.icon(onPressed: (){}, icon: Icon(Icons.mic), label: Text('Add Voice Recording', style: TextStyle(decoration: TextDecoration.underline))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Heading(
              fontSize: 20,
              text: 'T&Cs: By Posting This Reports You Indicate Acceptance Of Our Terms and Condition',
              color: Colors.grey,
              align: TextAlign.justify,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButton(label: 'Cancel', onPressed: (){}),
              SizedBox(width: 10,),
              RoundedButton(label: 'Submit Report', onPressed: (){}),
            ],
          )
        ],
      ),
    );
  }
}
