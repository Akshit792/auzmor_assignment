import 'package:auzmor_assignment/common/models/training_session_model.dart';
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
    return BlocBuilder<TrainingBloc, TrainingState>(
      builder: (context, state) {
        final TrainingBloc trainingBloc =
            BlocProvider.of<TrainingBloc>(context);

        if (state is InitialTraningState) {
          _fetchTrainingSessionsData(
            trainingBloc: trainingBloc,
          );
        }

        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: Column(
            children: [
              _buildHighLightsTrainingCarousel(trainingBloc: trainingBloc),
              (state is LoadingTraningState)
                  ? const Center(child: CircularProgressIndicator())
                  : Flexible(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(15),
                        itemCount: trainingBloc.trainingSessionsDataList.length,
                        itemBuilder: (context, index) {
                          return _buildTrainingSessionCard(
                            trainingBloc: trainingBloc,
                            trainingSessionData:
                                trainingBloc.trainingSessionsDataList[index],
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

  Widget _buildHighLightsTrainingCarousel({
    required TrainingBloc trainingBloc,
  }) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.red,
      height: height * 0.47,
      child: Stack(
        children: [
          // Background
          Column(
            children: [
              Container(
                height: height * 0.3,
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
          // Top Content
          Padding(
            padding: EdgeInsets.only(
              // TODO : android
              top: MediaQuery.of(context).padding.top + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "Trainings",
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
                    "HighLights",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: height * 0.19,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  ),
                  items: trainingBloc.trainingSessionsDataList.map(
                    (trainingSessionsData) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Stack(
                              children: [
                                InkWell(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.network(
                                        trainingSessionsData.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        trainingSessionsData.name,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2,
                                          bottom: 2,
                                        ),
                                        child: Text(
                                          "${trainingSessionsData.address} ${trainingBloc.formatDateRange(
                                            startDate:
                                                trainingSessionsData.startDate,
                                            endDate:
                                                trainingSessionsData.endDate,
                                          )}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
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
                                              "\$${trainingSessionsData.price}",
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
                                                "View Details",
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
                                      // move to details page
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
                              // Open a filer model
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[500]!,
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
                                    color: Colors.grey[500],
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Fitler",
                                    style: TextStyle(
                                      color: Colors.grey[500],
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

  Widget _buildTrainingSessionCard({
    required TrainingBloc trainingBloc,
    required TrainingSessionModel trainingSessionData,
  }) {
    final double width = MediaQuery.of(context).size.width;

    final String sessionDateRange = trainingBloc.formatDateRange(
      startDate: trainingSessionData.startDate,
      endDate: trainingSessionData.endDate,
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
                width: width * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text(
                        sessionDateRange,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      trainingSessionData.time,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      trainingSessionData.address,
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
                  horizontal: 15.0,
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
                      trainingSessionData.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
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
                                  trainingSessionData.trainerImageUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Session Trainer",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                trainingSessionData.trainerName,
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
                          // Navigate to next screen
                        },
                        child: const Text(
                          "Enroll Now",
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

  void _fetchTrainingSessionsData({
    required TrainingBloc trainingBloc,
  }) {
    trainingBloc.add(
      FetchTrainingSessionData(
        context: context,
      ),
    );
  }
}
