import 'package:galaxy/database/db_functions.dart';
import 'package:galaxy/database/db_model.dart';

import 'package:galaxy/recently/recent.dart';
import 'package:hive_flutter/hive_flutter.dart';

final String _boxName = 'recent';

Future<void> addRecentlyplayedSong(
    int songId, String name, String artistname) async {
  final box = await Hive.openBox<Recentmodel>(_boxName);
  final recentlyplayedsong =
      Recentmodel(songId: songId, name: name, artistname: artistname);
  int currentindex =
      box.values.toList().indexWhere((song) => song.songId == songId);
  if (currentindex != -1) {
    box.putAt(currentindex, recentlyplayedsong);
  } else {
    box.add(recentlyplayedsong);
  }

  if (box.length > 10) {
    box.delete(10);
  }
}

Future<List<Recentmodel>> getallrecentSong() async {
  final box = await Hive.openBox<Recentmodel>(_boxName);
  return box.values.toList().reversed.toList();
}

Future<void> deleteRecentSong(int songId) async {
  final box = await Hive.openBox<Recentmodel>(_boxName);
  final indexToDelete =
      box.values.toList().indexWhere((song) => song.songId == songId);
  if (indexToDelete != -1) {
    box.deleteAt(indexToDelete);
  }
}

Future<List<MusicModel>> showRecentSong() async {
  final box = await Hive.openBox<Recentmodel>(_boxName);
  List<MusicModel> recentsong = [];
  List<MusicModel> song = await getAllSongs();

  for (int i = 0; i < song.length; i++) {
    for (int j = 0; j < box.length; j++) {
      if (box.values.toList()[j].songId == song[i].songid) {
        recentsong.add(song[i]);
      }
    }
  }

  recentsong = recentsong.reversed.toList();

  return recentsong;
}
