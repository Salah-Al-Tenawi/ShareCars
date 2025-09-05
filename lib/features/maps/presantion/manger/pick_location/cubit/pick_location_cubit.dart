import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:sharecars/features/maps/data/repo/map_repo.dart';

part 'pick_location_state.dart';

class PickLocationCubit extends Cubit<PickLocationState> {
  final MapRepoIm mapsRepo;

  PickLocationCubit(this.mapsRepo) : super(PickLocationInitial());

  Future<void> selectPoint(LatLng point) async {
    emit(PickLocationLoading(point));

    final result = await mapsRepo.getPlaceName(point);

    result.fold(
      (error) {
        try {
          emit(PickLocationError(
            point: point,
            message: "تعذر جلب اسم المكان 😢",
          ));
        } catch (e) {}
      },
      (name) {
        emit(PickLocationLoaded(
          point: point,
          placeName: name,
        ));
      },
    );
  }
}
