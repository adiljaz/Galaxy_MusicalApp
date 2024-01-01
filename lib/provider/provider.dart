import 'package:flutter/material.dart';
import 'package:galaxy/database/db_model.dart';

class SongModelProvider with ChangeNotifier {
  List<MusicModel> _songList = [];
  int _id = 0;

  int get id => _id;
  List<MusicModel> get songList => _songList;

  void setId(int id) {
    _id = id;
    notifyListeners();
  }

  void setSongList(List<MusicModel> songs) {
    _songList = songs;
    notifyListeners();
  }

  MusicModel? _currentSong;

  MusicModel? get currentSong => _currentSong;

  void updateCurrentSong(MusicModel song) {
    _currentSong = song;
    notifyListeners();
  }
}
