import 'package:brew/models/brew_model.dart';
import 'package:brew/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String name, String sugar, int strength) async {
    try {
      await brewCollection
          .doc(uid)
          .update({'name': name, 'sugar': sugar, 'strength': strength});
    } catch (e) {
      print(e);
    }
  }

  Future addUserData(String name, String sugar, int strength) async {
    try {
      await brewCollection
          .doc(uid)
          .set({'name': name, 'sugar': sugar, 'strength': strength});
    } catch (e) {
      print(e);
    }
  }

  Stream<List<BrewModel>> get brews {
    return brewCollection.snapshots().map(BrewModel.makeBrewList);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_getUserData);
  }

  UserData _getUserData(DocumentSnapshot doc) {
    return UserData(
      uid: uid,
      name: doc.data()['name'],
      sugar: doc.data()['sugar'],
      strength: doc.data()['strength'],
    );
  }
}
