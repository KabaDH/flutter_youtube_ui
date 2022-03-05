import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';

import 'data.dart';

///Видео, которое проигрывается
final providerVideo = StateNotifierProvider.autoDispose<VideoState, Video?>(
    (ref) => VideoState());

class VideoState extends StateNotifier<Video?> {
  VideoState() : super(null);

  void setNewVideo(Video? video) => state = video;
}
// или можно так
// final providerVideo = StateProvider.autoDispose<Video?>((ref) => null);

///Текущий экран
final providerScreenIndex =
    StateNotifierProvider.autoDispose<ScreenIndexState, int>(
        (ref) => ScreenIndexState());

class ScreenIndexState extends StateNotifier<int> {
  ScreenIndexState() : super(0);

  void selectNewScreen(int index) => state = index;
}

///Управление миниплеером
final providerMiniPlayerController =
    StateNotifierProvider<MiniPlayerControllerState, MiniplayerController>(
        (ref) => MiniPlayerControllerState());

class MiniPlayerControllerState extends StateNotifier<MiniplayerController> {
  MiniPlayerControllerState() : super(MiniplayerController());
}
