part of 'navbar_bloc.dart';

abstract class NavbarState extends Equatable {
  const NavbarState();

  @override
  List<Object> get props => [];
}

class NavbarInitial extends NavbarState {}

class HomeNavBar extends NavbarState {
  final String title = "Home";
  final int itemIndex = 0;
}

class ProfileNavBar extends NavbarState {
  final String title = "Profile";
  final int itemIndex = 1;
}