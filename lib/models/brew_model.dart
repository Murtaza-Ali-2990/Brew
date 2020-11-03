import 'package:cloud_firestore/cloud_firestore.dart';

class BrewModel {
  String name, sugar;
  int strength;

  BrewModel(this.name, this.sugar, this.strength);

  static List<BrewModel> makeBrewList(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((e) => BrewModel(
            e.data()['name'], e.data()['sugar'], e.data()['strength']))
        .toList();
  }

  @override
  String toString() {
    return 'Name: $name\nSugars: $sugar\nStrength: $strength';
  }
}
