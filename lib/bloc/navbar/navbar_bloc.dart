import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvents, NavbarState> {
  NavbarBloc() : super(HomeNavBar());

  @override
  Stream<NavbarState> mapEventToState(
    NavbarEvents event,
  ) async* {
    switch (event) {
      case NavbarEvents.Profile:
        yield ProfileNavBar();
        break;
      default:
        yield HomeNavBar();
        break;
    }
  }
}