import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;
abstract class _HomeStore with Store{

}

/// Build (generate .g.dart) flutter packages pub run build_runner build
/// Watch (update .g.dart automatically) flutter packages pub run build_runner watch
/// Clean before updating: flutter packages pub run build_runner watch --delete-conflicting-outputs

