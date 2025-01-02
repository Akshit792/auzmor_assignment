import 'package:auzmor_assignment/common/config/log_print.dart';
import 'package:auzmor_assignment/common/models/training_session_model.dart';
import 'package:auzmor_assignment/common/repositories/training_repository.dart';
import 'package:auzmor_assignment/trainings/bloc/training_event.dart';
import 'package:auzmor_assignment/trainings/bloc/training_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  List<TrainingSessionModel> trainingSessionsDataList = [];

  TrainingBloc() : super(InitialTraningState()) {
    on<FetchTrainingSessionData>(
      (event, emit) async {
        try {
          emit(LoadingTraningState());

          final trainingRepository = RepositoryProvider.of<TrainingRepository>(
            event.context,
          );

          trainingSessionsDataList = await trainingRepository.fetchSessions();

          emit(LoadedTraningState());
        } catch (error, stackTrace) {
          const String errorMsg =
              ("Failed to fetch training session data : Fetch Training Session Data Event");

          LogPrint().error(
            error: error,
            errorMsg: errorMsg,
            stackTrace: stackTrace,
          );
        }
      },
    );
  }

  String formatDateRange({
    required String startDate,
    required String endDate,
  }) {
    final String startFormatted =
        DateFormat('MMM dd').format(DateTime.parse(startDate));

    final String endFormatted =
        DateFormat('dd yyyy').format(DateTime.parse(endDate));

    final String formattedDateRange = "$startFormatted - $endFormatted";

    return formattedDateRange;
  }
}

// isFeatured
           // sessions.where((session) => session.isFeatured).toList();
          
          // sessions.where((session) => session.category == category).toList();