import 'package:flutter/widgets.dart';

abstract class TrainingsEvent {}

class FetchTrainingsDataEvent extends TrainingsEvent {
  final bool isFilter;
  final BuildContext context;

  FetchTrainingsDataEvent({
    this.isFilter = false,
    required this.context,
  });
}
