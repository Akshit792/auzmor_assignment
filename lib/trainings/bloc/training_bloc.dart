import 'package:auzmor_assignment/common/config/log_print.dart';
import 'package:auzmor_assignment/common/models/training_session_model.dart';
import 'package:auzmor_assignment/common/repositories/training_repository.dart';
import 'package:auzmor_assignment/trainings/bloc/training_event.dart';
import 'package:auzmor_assignment/trainings/bloc/training_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  List<TrainingSessionModel> trainingSessionsDataList = [];

  List<TrainingSessionModel> highlightedTrainingSessionList = [];

  final List<String> trainerNames = [
    "Mark Hamilton",
    "Sarah Johnson",
    "Anna Lee",
    "Michael Rodriguez",
    "Laura Simmons",
  ];

  final List<String> trainingCategory = [
    "Leadership",
    "Human Resources",
    "Project Management",
    "Communication",
    "Team Management",
  ];

  final List<String> locations = [
    "New York, ZK",
    "Chicago, IL",
    "Phoenix, AZ",
    "San Francisco, CA",
    "Dallas, TX",
    "West Des Moines",
    "San Diego, CA",
    "Boston, MA",
    "Houston, TX",
  ];

  final Map filterData = {
    "location": [],
    "trainer": [],
    "training_type": [],
  };

  TrainingBloc() : super(InitialTraningState()) {
    on<FetchTrainingSessionData>(
      (event, emit) async {
        try {
          emit(LoadingTraningState());

          final trainingRepository = RepositoryProvider.of<TrainingRepository>(
            event.context,
          );

          trainingSessionsDataList = await trainingRepository.fetchSessions();

          highlightedTrainingSessionList = trainingSessionsDataList
              .where((session) => session.isFeatured)
              .toList();

          if (event.isFilter) {
            trainingSessionsDataList =
                trainingSessionsDataList.where((session) {
              final isLocationMatch = filterData['location']!.isEmpty
                  ? true
                  : filterData['location']?.contains(session.location) ?? false;
              final isTrainerMatch = filterData['trainer']!.isEmpty
                  ? true
                  : filterData['trainer']?.contains(session.trainerName) ??
                      false;
              final isCategoryMatch = filterData['training_type']!.isEmpty
                  ? true
                  : filterData['training_type']?.contains(session.category) ??
                      false;

              return isLocationMatch && isTrainerMatch && isCategoryMatch;
            }).toList();
          }

          emit(LoadedTraningState());
        } catch (error, stackTrace) {
          const String errorMsg =
              ("Failed to fetch training session data : Fetch Training Session Data Event");

          LogPrint().error(
            error: error,
            errorMsg: errorMsg,
            stackTrace: stackTrace,
          );

          emit(ErrorTraningState());
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


          
          // sessions.where((session) => session.category == category).toList();

          // Future<List<TrainingSessionModel>> getAllSessions() async {
  //   return await _fetchSessions();
  // }

  // Future<List<TrainingSessionModel>> getFeaturedSessions() async {
  //   final sessions = await _fetchSessions();
  //   return sessions.where((session) => session.isFeatured).toList();
  // }

  // Future<List<TrainingSessionModel>> getSessionsByCategory(String category) async {
  //   final sessions = await _fetchSessions();
  //   return sessions.where((session) => session.category == category).toList();
  // }

  // all training page 
  // training details page