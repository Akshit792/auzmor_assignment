import 'package:auzmor_assignment/common/config/log_print.dart';
import 'package:auzmor_assignment/common/models/training_model.dart';
import 'package:auzmor_assignment/common/repositories/trainings_repository.dart';
import 'package:auzmor_assignment/trainings/bloc/training_event.dart';
import 'package:auzmor_assignment/trainings/bloc/training_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TrainingsBloc extends Bloc<TrainingsEvent, TrainingsState> {
  List<TrainingModel> trainingsList = [];

  List<TrainingModel> highlightedTrainingsList = [];

  final List<String> trainersList = [
    "Anna Lee",
    "Laura Simmons",
    "Mark Hamilton",
    "Sarah Johnson",
    "Michael Rodriguez",
  ];

  final List<String> trainingTypesList = [
    "Leadership",
    "Communication",
    "Team Management",
    "Human Resources",
    "Project Management",
  ];

  final List<String> locationsList = [
    "Chicago, IL",
    "Dallas, TX",
    "Boston, MA",
    "Phoenix, AZ",
    "Houston, TX",
    "New York, ZK",
    "San Diego, CA",
    "West Des Moines",
    "San Francisco, CA",
  ];

  final Map<String, List<dynamic>> filterSettings = {
    "trainer": [],
    "location": [],
    "training_type": [],
  };

  TrainingsBloc() : super(InitialTrainingsState()) {
    on<FetchTrainingsDataEvent>(
      (event, emit) async {
        try {
          emit(LoadingTrainingsState());

          final trainingsRepository =
              RepositoryProvider.of<TrainingsRepository>(event.context);

          trainingsList = await trainingsRepository.fetchSessions();

          _setHighlightedTrainings();

          if (event.isFilter) {
            _filterTrainingsData();
          }

          emit(LoadedTrainingsState());
        } catch (e, s) {
          LogPrint().error(
            error: e,
            stackTrace: s,
            errorMsg: "Failed to fetch trainings data",
          );

          emit(ErrorTrainingsState());
        }
      },
    );
  }

  void _setHighlightedTrainings() {
    highlightedTrainingsList =
        trainingsList.where((data) => data.isFeatured).toList();
  }

  void _filterTrainingsData() {
    trainingsList = trainingsList.where(
      (data) {
        final bool isLocationMatch = filterSettings["location"]!.isEmpty
            ? true
            : filterSettings["location"]!.contains(data.location);

        final bool isTrainerMatch = filterSettings["trainer"]!.isEmpty
            ? true
            : filterSettings["trainer"]!.contains(data.trainerName);

        final bool isCategoryMatch = filterSettings["training_type"]!.isEmpty
            ? true
            : filterSettings["training_type"]!.contains(data.category);

        return (isLocationMatch && isTrainerMatch && isCategoryMatch);
      },
    ).toList();
  }

  String formatDateRange({
    required String startDate,
    required String endDate,
  }) {
    final String startFormatted =
        DateFormat("MMM dd").format(DateTime.parse(startDate));

    final String endFormatted =
        DateFormat("dd yyyy").format(DateTime.parse(endDate));

    final String formattedDateRange = ("$startFormatted - $endFormatted");

    return formattedDateRange;
  }
}
