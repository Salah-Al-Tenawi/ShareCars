import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sharecars/core/api/api_consumer.dart';
import 'package:sharecars/core/api/api_end_points.dart';
import 'package:sharecars/core/utils/functions/upload_file_to_api.dart';
import 'package:sharecars/features/vieryfiy_user/data/model/verifiy_user_modle.dart';

class VerifitUserRemoteDataSource {
  final ApiConSumer api;

  VerifitUserRemoteDataSource({required this.api});

  Future<VerifiyUserModle> checkUpPassenger(XFile faceIdPic, XFile backIdPic) async {
    final response =await api.post(ApiEndPoint.verifypassenger, data: {
      ApiKey.faceIdPic: faceIdPic,
      ApiKey.backIdPic: backIdPic,
    });
    return VerifiyUserModle.fromJson(response);
  }

  Future<VerifiyUserModle> checkUpDriver(XFile ?faceIdPic, XFile ?backIdPic,
      XFile ?drivingLicensePic, XFile ?mechanicCardPic) async{ 
        final response =await api.post(ApiEndPoint.verifydriver, data: {
      ApiKey.faceIdPic: await uploadFiletoApi(faceIdPic),
      ApiKey.backIdPic: await uploadFiletoApi(backIdPic) ,
      ApiKey.licensePic: await uploadFiletoApi(drivingLicensePic)  ,
      ApiKey.mechanicCardPic :await uploadFiletoApi ( mechanicCardPic)
    });
    return VerifiyUserModle.fromJson(response);
      }
}
