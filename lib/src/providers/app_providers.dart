import 'package:flutter_riverpod/flutter_riverpod.dart';



final titleProvider = Provider((ref) => 'Riverpod 2 Play');
final counterProvider = StateProvider<int>((ref) => 0);
final themeSwitchProvider = StateProvider((ref) {
  return true;
});

