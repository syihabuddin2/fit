import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit/service/profile/profileservice.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileService profileService;

  ProfileBloc({required this.profileService}) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    var firebaseAuth = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    if (event is ProfileStarted) {
      String? name;
      String? gender;
      String? dateOfBirth;
      double? height;
      double? weight;
      try{
         await firestore.collection("users").doc(firebaseAuth!.uid).get().then((value){
           print(value.data());
            name = value.data()!["name"];
            gender = value.data()!["gender"];
            dateOfBirth = value.data()!["dateOfBirth"];
            height = value.data()!["height"];
            weight = value.data()!["weight"];
        });
        yield ProfileSuccessState(
          name: name,
          gender: gender,
          dateOfBirth: dateOfBirth,
          height: height,
          weight: weight,
        );
      } catch (error) {
        yield ProfileError(error: error.toString());
      }
    }
  }
}
