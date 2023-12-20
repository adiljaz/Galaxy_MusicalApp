import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongModelProvider with ChangeNotifier {
  int _id = 0;
  int get id => _id;

  void setId(int id) {
    _id = id;
    notifyListeners();
  }


    // String? _currentSongId;
     SongModel? _currentSong;


      // String? get currentSongId => _currentSongId;
        SongModel? get currentSong => _currentSong;

  //        void setId(String id) {
  //   _currentSongId = id;
  //   notifyListeners();
  // }
    void updateCurrentSong(SongModel song) {
    _currentSong = song;
    notifyListeners();
  }
}




