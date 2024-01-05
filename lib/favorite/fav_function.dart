
import 'package:galaxy/database/db_functions.dart';
import 'package:galaxy/database/db_model.dart';
import 'package:galaxy/favorite/fav_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

const _boxName = 'liked songs';

Future<void> addlikedSong(int songId) async {
  final box = await Hive.openBox<LikedSongModel>(_boxName);
  final likedSong = LikedSongModel(songid: songId);
  await box.add(likedSong);
  print(box.length);
}





List<int> favSongs = [];
ifLickd() async {
  favSongs.clear();
  final box = await Hive.openBox<LikedSongModel>(_boxName);
  List<LikedSongModel> song = box.values.toList();
  for (LikedSongModel s in song) {
    favSongs.add(s.songid);
  }
}




Future<void> removeLikedSong(int songId) async {
  final box = await Hive.openBox<LikedSongModel>(_boxName);

  for (LikedSongModel s in box.values.toList()) {
    if (songId == s.songid) {
      box.delete(s.key);
    }
  }
  
}

Future<List<LikedSongModel>> getLikedSongs() async {
  final box = await Hive.openBox<LikedSongModel>(_boxName);

  return box.values.toList();
}

Future<List<MusicModel>> showLike() async {
  final box = await Hive.openBox<LikedSongModel>(_boxName);
  List<MusicModel> likedsongs = [];

  List<MusicModel> sng = await getAllSongs();

  for (int i = 0; i < sng.length; i++) {
    for (int j = 0; j < box.length; j++) {
      if (box.values.toList()[j].songid == sng[i].songid) {
        likedsongs.add(sng[i]);
      }
    }
  }

  return likedsongs;
}


List<int> a= [];


 
