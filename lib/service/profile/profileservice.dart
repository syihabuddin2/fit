import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {

  var firebaseAuth = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProfile({String? name, String? dateOfBirth, String? gender, double? height, double? weight}) async {
    await firestore.collection("users").doc(firebaseAuth!.uid).set({
      'name': name,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'height': height,
      'weight': weight,
    });
  }

  Future<void> getProfile() async {
    await firestore.collection("users").doc(firebaseAuth!.uid).get().then((value){
      print(value.data());
    });
  }


}
