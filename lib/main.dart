import 'package:auzmor_assignment/common/repositories/trainings_repository.dart';
import 'package:auzmor_assignment/trainings/bloc/training_bloc.dart';
import 'package:auzmor_assignment/trainings/training_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (context) => TrainingsRepository(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TrainingsBloc>(
          create: (BuildContext context) => TrainingsBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TrainingListScreen(),
      ),
    );
  }
}
