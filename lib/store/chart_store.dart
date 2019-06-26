import 'package:mobx/mobx.dart';
part 'chart_store.g.dart';

class ChartStore = _ChartStore with _$ChartStore;
abstract class _ChartStore with Store{

}

/// Build (generate .g.dart) flutter packages pub run build_runner build
/// Watch (update .g.dart automatically) flutter packages pub run build_runner watch
/// Clean before updating: flutter packages pub run build_runner watch --delete-conflicting-outputs

