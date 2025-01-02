import 'package:flutter/widgets.dart';

class TrainingEvent {}

class FetchTrainingSessionData extends TrainingEvent {
  final BuildContext context;
  final bool isFilter;

  FetchTrainingSessionData({
    required this.context,
    this.isFilter = false,
  });
}
