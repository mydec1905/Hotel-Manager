import 'package:mobx/mobx.dart';
part 'tour_store.g.dart';

class TourStore = _TourStore with _$TourStore;
abstract class _TourStore with Store{

}

/// Build (generate .g.dart) flutter packages pub run build_runner build
/// Watch (update .g.dart automatically) flutter packages pub run build_runner watch
/// Clean before updating: flutter packages pub run build_runner watch --delete-conflicting-outputs

