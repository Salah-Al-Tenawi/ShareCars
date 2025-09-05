import 'package:get_it/get_it.dart';
import 'package:sharecars/core/api/dio_consumer.dart';
import 'package:sharecars/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:sharecars/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:sharecars/features/auth/data/repo/auth_repo_im.dart';
<<<<<<< HEAD
import 'package:sharecars/features/chat/data/data_source/chat_remote_data_source.dart';
import 'package:sharecars/features/chat/data/repo/chat_repo_im.dart';
import 'package:sharecars/features/chat/domain/repo/chat_repo.dart';
=======
import 'package:sharecars/features/trip_me/data/data%20source/trip_me_remote_data_source.dart';
import 'package:sharecars/features/trip_me/data/repo/trip_me_repo_im.dart';
import 'package:sharecars/features/trip_me/presantion/manger/cubit/trip_me_cubit.dart';
>>>>>>> 3dde7578015b3894eab2dc1e9cd7375179ddb1af

final getit = GetIt.instance;

locatorService() {
  // ✅ Dio
  getit.registerSingleton<DioConSumer>(DioConSumer());

  // ✅ Auth
  getit.registerSingleton<AuthRemoteDataSourceIM>(
    AuthRemoteDataSourceIM(api: getit.get<DioConSumer>()),
  );
  getit.registerSingleton<AuthLocalDataSourceIm>(AuthLocalDataSourceIm());
  getit.registerSingleton<AuthRepoIm>(
    AuthRepoIm(
      authRemoteDataSource: getit.get<AuthRemoteDataSourceIM>(),
      authLocalDataSourceIm: getit.get<AuthLocalDataSourceIm>(),
    ),
  );
<<<<<<< HEAD

  // ✅ Chat (إضافات الشات)
  getit.registerSingleton<ConversationsRemoteDataSource>(
    ConversationsRemoteDataSourceIM 
(api: getit.get<DioConSumer>()),
  );

  getit.registerSingleton<ChatRepo>(
    ChatRepoImpl(remoteDataSource: getit.get<ConversationsRemoteDataSource>()),
  );
=======
  getit.registerSingleton<TripMeCubit>(TripMeCubit(TripMeRepoIm(
      tripMeRemoteDataSource:
          TripMeRemoteDataSource(api: getit.get<DioConSumer>()))));
>>>>>>> 3dde7578015b3894eab2dc1e9cd7375179ddb1af
}
