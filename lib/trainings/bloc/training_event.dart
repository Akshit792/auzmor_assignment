import 'package:flutter/widgets.dart';

class TrainingEvent {}

class FetchTrainingSessionData extends TrainingEvent {
  final BuildContext context;

  FetchTrainingSessionData({required this.context});
}
