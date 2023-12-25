import 'package:flutter/material.dart';
import 'package:galaxy/database/db_model.dart';

class SongModelProvider with ChangeNotifier {
  int _id = 0;
  int get id => _id;

  void setId(int id) {
    _id = id;
    notifyListeners();
  }


    // String? _currentSongId;
     MusicModel? _currentSong;


      // String? get currentSongId => _currentSongId;
        MusicModel? get currentSong => _currentSong;

  //        void setId(String id) {
  //   _currentSongId = id;
  //   notifyListeners();
  // }
    void updateCurrentSong(MusicModel song) {
    _currentSong = song;
    notifyListeners();
  }
}




