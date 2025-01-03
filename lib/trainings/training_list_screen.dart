import 'package:auzmor_assignment/common/config/constants.dart';
import 'package:auzmor_assignment/common/models/training_model.dart';
import 'package:auzmor_assignment/training_detail/bloc/training_details_bloc.dart';
import 'package:auzmor_assignment/training_detail/training_details_screen.dart';
import 'package:auzmor_assignment/trainings/bloc/training_bloc.dart';
import 'package:auzmor_assignment/trainings/bloc/training_event.dart';
import 'package:auzmor_assignment/trainings/bloc/training_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingListScreen extends StatefulWidget {
  const TrainingListScreen({super.key});

  @override
  State<TrainingListScreen> createState() => _TrainingListScreenState();
}

class _TrainingListScreenState extends State<TrainingListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingsBloc, TrainingsState>(
      builder: (context, state) {
        final TrainingsBloc trainingsBloc =
            BlocProvider.of<TrainingsBloc>(context);

        if (state is InitialTrainingsState) {
          fetchTrainingsData(
            trainingsBloc: trainingsBloc,
          );
        }

        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: (state is LoadingTrainingsState)
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              : Column(
                  children: [
                    if (state is LoadedTrainingsState)
                      buildHighLightedTrainingsCarousel(
                        trainingsBloc: trainingsBloc,
                      ),
                    Flexible(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(15),
                        itemCount: trainingsBloc.trainingsList.length,
                        itemBuilder: (context, index) {
                          return buildTrainingDetailsCard(
                            trainingsBloc: trainingsBloc,
                            trainingData: trainingsBloc.trainingsList[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget buildHighLightedTrainingsCarousel({
    required TrainingsBloc trainingsBloc,
  }) {
    final double height = MediaQuery.of(context).size.height;

    final bool isFilterApplied =
        trainingsBloc.filterSettings.values.any((list) => list.isNotEmpty);

    return Container(
      height: (height * 0.49),
      color: Colors.red,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: (height * 0.3),
                color: Colors.red,
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey[350],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: (MediaQuery.of(context).padding.top + 10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    ("Trainings"),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 35,
                    bottom: 15,
                  ),
                  child: Text(
                    ("HighLights"),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: (height * 0.19),
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  ),
                  items: trainingsBloc.highlightedTrainingsList.map(
                    (trainingData) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: FadeInImage.assetNetwork(
                                      placeholder:
                                          AppConstants.kPlaceHolderImagePath,
                                      image: trainingData.imageUrl,
                                      fit: BoxFit.cover,
                                      fadeInDuration: const Duration(
                                        milliseconds: 300,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        trainingData.name,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2,
                                          bottom: 2,
                                        ),
                                        child: Text(
                                          ("${trainingData.address} ${trainingsBloc.formatDateRange(
                                            startDate: trainingData.startDate,
                                            endDate: trainingData.endDate,
                                          )}"),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 2,
                                              bottom: 12,
                                            ),
                                            child: Text(
                                              ("\$${trainingData.price}"),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                          const Row(
                                            children: [
                                              Text(
                                                ("View Details"),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 2,
                                                ),
                                                child: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return BlocProvider(
                                              create: (context) =>
                                                  TrainingDetailsBloc(
                                                trainingData: trainingData,
                                              ),
                                              child:
                                                  const TrainingDetailsScreen(),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: SizedBox(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: InkWell(
                            onTap: () {
                              showFiltersBottomSheet(
                                trainingsBloc: trainingsBloc,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: (isFilterApplied
                                      ? Colors.red
                                      : Colors.grey[500]!),
                                  width: 1.1,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.filter_list,
                                    size: 16,
                                    color: (isFilterApplied
                                        ? Colors.red
                                        : Colors.grey[500]),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    ("Fitler"),
                                    style: TextStyle(
                                      color: (isFilterApplied
                                          ? Colors.red
                                          : Colors.grey[500]),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTrainingDetailsCard({
    required TrainingsBloc trainingsBloc,
    required TrainingModel trainingData,
  }) {
    final double width = MediaQuery.of(context).size.width;

    final String trainingDateRange = trainingsBloc.formatDateRange(
      startDate: trainingData.startDate,
      endDate: trainingData.endDate,
    );

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 6,
      ),
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Container(
          height: 145,
          margin: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          child: Row(
            children: [
              SizedBox(
                width: (width * 0.25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text(
                        trainingDateRange,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      trainingData.time,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      trainingData.address,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: DottedLine(
                  direction: Axis.vertical,
                  dashColor: Colors.grey,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trainingData.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  trainingData.trainerImageUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                ("Session Trainer"),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                trainingData.trainerName,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                        elevation: 1,
                        color: Colors.red,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BlocProvider(
                                  create: (context) => TrainingDetailsBloc(
                                    trainingData: trainingData,
                                  ),
                                  child: const TrainingDetailsScreen(),
                                );
                              },
                            ),
                          );
                        },
                        child: const Text(
                          ("Enroll Now"),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showFiltersBottomSheet({
    required TrainingsBloc trainingsBloc,
  }) {
    String selectedFilter = ("Trainer");

    final List<String> filterTypes = ["Trainer", "Location", "Training Type"];

    BorderRadiusGeometry borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(12),
      topRight: Radius.circular(12),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, changeState) {
            final List<String> filterOptions = (selectedFilter == "Trainer")
                ? trainingsBloc.trainersList
                : (selectedFilter == "Location")
                    ? trainingsBloc.locationsList
                    : trainingsBloc.trainingTypesList;

            final double width = MediaQuery.of(context).size.width;

            return Container(
              width: width,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              ("Select Filters"),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              ...filterTypes.map(
                                (type) {
                                  return buildfilterTypeChip(
                                    label: type,
                                    isSeleted: (selectedFilter == type),
                                    onTap: () {
                                      selectedFilter = type;
                                      changeState(() {});
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 300,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: filterOptions.map(
                                  (value) {
                                    final String filterKey = selectedFilter
                                        .toLowerCase()
                                        .replaceAll(' ', '_');

                                    final bool isSelected = trainingsBloc
                                        .filterSettings[filterKey]!
                                        .contains(value);

                                    return buildFilterOptions(
                                      label: value,
                                      isSelected: isSelected,
                                      filterType: selectedFilter,
                                      onChanged: (newValue) {
                                        if (newValue == true) {
                                          if (!trainingsBloc
                                              .filterSettings[filterKey]!
                                              .contains(value)) {
                                            trainingsBloc
                                                .filterSettings[filterKey]!
                                                .add(value);
                                          }
                                        } else {
                                          trainingsBloc
                                              .filterSettings[filterKey]!
                                              .remove(value);
                                        }
                                        changeState(() {});
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 20,
                          right: 20,
                          bottom: 25,
                        ),
                        child: MaterialButton(
                          color: Colors.red,
                          minWidth: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () {
                            fetchTrainingsData(
                              isFilter: true,
                              trainingsBloc: trainingsBloc,
                            );
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            ("Apply"),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget buildfilterTypeChip({
    required String label,
    required bool isSeleted,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: (MediaQuery.of(context).size.width * 0.38),
        color: (!isSeleted ? Colors.grey[300] : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isSeleted)
              Container(
                height: 60,
                width: 5,
                color: Colors.red,
              ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: (isSeleted ? FontWeight.w600 : FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterOptions({
    required String label,
    required bool isSelected,
    required String filterType,
    required void Function(bool?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: isSelected,
            onChanged: onChanged,
            side: const BorderSide(
              color: Colors.grey,
            ),
            activeColor: Colors.red,
            checkColor: Colors.white,
          ),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: (isSelected ? Colors.red : Colors.grey[700]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void fetchTrainingsData({
    bool isFilter = false,
    required TrainingsBloc trainingsBloc,
  }) {
    trainingsBloc.add(
      FetchTrainingsDataEvent(
        context: context,
        isFilter: isFilter,
      ),
    );
  }
}
