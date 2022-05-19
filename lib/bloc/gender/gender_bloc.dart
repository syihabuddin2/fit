import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gender_event.dart';
part 'gender_state.dart';

class GenderBloc extends Bloc<GenderEvents, GenderState> {
  GenderBloc() : super(GenderInitial());

  @override
  Stream<GenderState> mapEventToState(
    GenderEvents event,
  ) async* {
    switch (event) {
      case GenderEvents.Woman:
        yield WomanState();
        break;
      default:
        yield ManState();
        break;
    }
  }
}
