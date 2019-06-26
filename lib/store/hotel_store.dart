import 'package:mobx/mobx.dart';
part 'hotel_store.g.dart';

class HotelStore = _HotelStore with _$HotelStore;
abstract class _HotelStore with Store{

}

/// Build (generate .g.dart) flutter packages pub run build_runner build
/// Watch (update .g.dart automatically) flutter packages pub run build_runner watch
/// Clean before updating: flutter packages pub run build_runner watch --delete-conflicting-outputs

