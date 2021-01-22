import 'package:community_support/localization/demo_localization.dart';
import 'package:community_support/main.dart';
import 'package:flutter/material.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  List<bool> _selection;

  void _languageChanged(language, context) {
    Locale _temp;
    switch (language) {
      case 0:
        _temp = Locale('en', 'US');
        break;
      case 1:
        _temp = Locale('bn', 'BD');
        break;
      default:
        _temp = Locale('en', 'US');
    }

    MyApp.setLocale(context, _temp);
  }

  @override
  void initState() {
    _selection = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),

          Builder(
            builder: (context) => ToggleButtons(
              children: [
                Text(
                  'Eng',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  'Igbo',
                  style: TextStyle(fontSize: 10),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderWidth: 0,
              fillColor: Colors.black,
              selectedColor: Colors.white,
              splashColor: Colors.amber,
              color: Colors.black,
              constraints: BoxConstraints(minWidth: 50, minHeight: 30),
              onPressed: (int index) {
                print('index $index');
                setState(() {
                  _selection[index == 0 ? 1 : 0] =
                      !_selection[index == 0 ? 1 : 0];
                  _selection[index] = true;
                });
                _languageChanged(index, context);
                // tab.animateTo(index);
              },
              isSelected: _selection,
            ),
          ),

          SizedBox(
            height: 50,
          ),

          Text(DemoLocalization.of(context).getTranslatedValue('easy_invoice_slider'))
        ],
      ),
    );
  }
}
