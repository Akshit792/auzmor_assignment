// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingSessionModel _$TrainingSessionModelFromJson(
        Map<String, dynamic> json) =>
    TrainingSessionModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      location: json['location'] as String,
      trainerName: json['trainer_name'] as String,
      trainerImageUrl: json['trainer_image_url'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      time: json['time'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      category: json['category'] as String,
      isFeatured: json['is_featured'] as bool,
      address: json['address'] as String,
      price: json['price'] as int,
    );

Map<String, dynamic> _$TrainingSessionModelToJson(
        TrainingSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'trainer_name': instance.trainerName,
      'trainer_image_url': instance.trainerImageUrl,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'time': instance.time,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'category': instance.category,
      'is_featured': instance.isFeatured,
      'address': instance.address,
      'price': instance.price,
    };
