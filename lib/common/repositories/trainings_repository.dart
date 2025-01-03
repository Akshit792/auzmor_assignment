import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:auzmor_assignment/common/config/constants.dart';
import 'package:auzmor_assignment/common/models/training_model.dart';

class TrainingsRepository {
  Future<List<TrainingModel>> fetchSessions() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    final String response =
        await rootBundle.loadString(AppConstants.kTrainingDataPath);

    final Map<String, dynamic> jsonData = json.decode(response);

    return (jsonData["trainings"] as List)
        .map((item) => TrainingModel.fromJson(item))
        .toList();
  }
}
