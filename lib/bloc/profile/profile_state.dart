part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  String? name;
  String? gender;
  String? dateOfBirth;
  double? height;
  double? weight;

  ProfileSuccessState({this.name, this.gender, this.dateOfBirth, this.height, this.weight});
}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String error;

  ProfileError({required this.error});
}
