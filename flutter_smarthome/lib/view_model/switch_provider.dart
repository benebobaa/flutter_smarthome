import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SwitchProvider with ChangeNotifier {
  final data = FirebaseDatabase.instance.ref();

  bool _home = false;
  bool _lamp = false;
  bool _fan = false;

  bool get home => _home;
  bool get lamp => _lamp;
  bool get fan => _fan;

  set lamp(bool value) {
    data.child('light').set({'switch': value});
    _lamp = value;
    notifyListeners();
  }

  set fan(bool value) {
    data.child('fan').set({'switch': value});
    _fan = value;
    notifyListeners();
  }

  set home(bool value) {
    _home = value;
    notifyListeners();
  }

  Color get color1 => (_home) ? Colors.green : Colors.grey;
  Color get color2 => (_lamp) ? Colors.green : Colors.grey;
  Color get color3 => (_fan) ? Colors.green : Colors.grey;
  String get homeTxt => (_home) ? 'Unlocked' : 'Locked';
  String get lampTxt => (_lamp) ? 'On' : 'Off';
  String get fanTxt => (_fan) ? 'On' : 'Off';
}
