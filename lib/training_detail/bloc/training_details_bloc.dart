import 'package:auzmor_assignment/common/models/training_model.dart';
import 'package:auzmor_assignment/training_detail/bloc/training_details_event.dart';
import 'package:auzmor_assignment/training_detail/bloc/training_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingDetailsBloc
    extends Bloc<TrainingDetailsEvent, TrainingDetailsState> {
  final TrainingModel trainingData;

  TrainingDetailsBloc({required this.trainingData})
      : super(InitialTrainingDetailsState()) {
    on((event, emit) async {});
  }
}
