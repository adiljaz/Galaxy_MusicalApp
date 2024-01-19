import 'package:flutter/material.dart';
import 'package:galaxy/Screens/home/home.dart';
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

 void setCurrentSong(int index, int i) {
    if (index >= 0 && index < _songList.length) {
      _id = index;
      _currentSong = _songList[index];
      notifyListeners();
    }
  }


  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  void togglePlayPause() {
  if (_isPlaying) {
    audioplayer.pause();
  } else {
    audioplayer.play();
  }
  _isPlaying = !_isPlaying;
  notifyListeners();
}

  

}