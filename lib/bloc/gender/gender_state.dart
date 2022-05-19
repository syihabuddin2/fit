part of 'gender_bloc.dart';

abstract class GenderState extends Equatable {
  const GenderState();
  
  @override
  List<Object> get props => [];
}

class GenderInitial extends GenderState {}

class ManState extends GenderState {
  final int itemIndex = 0;
}

class WomanState extends GenderState {
  final int itemIndex = 1;
}