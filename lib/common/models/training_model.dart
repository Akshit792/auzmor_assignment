import 'package:json_annotation/json_annotation.dart';

part 'training_model.g.dart';

@JsonSerializable()
class TrainingModel {
  @JsonKey(name: "id")
  final int id;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "location")
  final String location;

  @JsonKey(name: "trainer_name")
  final String trainerName;

  @JsonKey(name: "trainer_image_url")
  final String trainerImageUrl;

  @JsonKey(name: "start_date")
  final String startDate;

  @JsonKey(name: "end_date")
  final String endDate;

  @JsonKey(name: "time")
  final String time;

  @JsonKey(name: "description")
  final String description;

  @JsonKey(name: "image_url")
  final String imageUrl;

  @JsonKey(name: "category")
  final String category;

  @JsonKey(name: "is_featured")
  final bool isFeatured;

  @JsonKey(name: "address")
  final String address;

  @JsonKey(name: "price")
  final int price;

  TrainingModel({
    required this.id,
    required this.name,
    required this.location,
    required this.trainerName,
    required this.trainerImageUrl,
    required this.startDate,
    required this.endDate,
    required this.time,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.isFeatured,
    required this.address,
    required this.price,
  });

  factory TrainingModel.fromJson(Map<String, dynamic> json) =>
      _$TrainingModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingModelToJson(this);
}
