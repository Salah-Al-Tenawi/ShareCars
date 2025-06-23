import 'package:sharecars/core/api/api_end_points.dart';
import 'package:sharecars/features/profiles/domain/entity/car_entity.dart';

class CarModel extends CarEntity {
  final String typeOfCar;
  final String colorOfCar;
  final int numberOfSeats;
  final String? carPic;
  final bool radio;
  final bool smoking;

  CarModel({
    required this.typeOfCar,
    required this.colorOfCar,
    required this.numberOfSeats,
    this.carPic,
    required this.radio,
    required this.smoking,
  }) : super(
            type: typeOfCar,
            color: colorOfCar,
            seats: numberOfSeats,
            image: carPic,
            hasRadio: radio,
            allowsSmoking: smoking);

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      typeOfCar: json[ApiKey.typeOfCar],
      colorOfCar: json[ApiKey.colorOfCar],
      numberOfSeats: json[ApiKey.numberOfSeats],
      carPic: json[ApiKey.carPic],
      radio: json[ApiKey.radio] == 1 ? true : false,
      smoking: json[ApiKey.smoking] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.typeOfCar: typeOfCar,
      ApiKey.colorOfCar: colorOfCar,
      ApiKey.numberOfSeats: numberOfSeats,
      ApiKey.carPic: carPic,
      ApiKey.radio: radio == true ? 1 : 0, // تحويل من bool إلى int
      ApiKey.smoking: smoking == true ? 1 : 0, // تحويل من bool إلى int
    };
  }
}
