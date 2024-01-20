import 'package:galaxy/database/db_functions.dart';
import 'package:galaxy/database/db_model.dart';
import 'package:galaxy/playlist/playlist_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

String _boxname = 'playlist';

// Function to add a song to a playlist
Future<int> addPlaylist(String name) async {
  var box = await Hive.openBox<Playlistmodel>(_boxname);
  var playlist = Playlistmodel(name: name, song: []);
  var playlistId = await box.add(playlist);
  return playlistId;
}

Future<List<Playlistmodel>> getallPlaylist() async {
  var box = await Hive.openBox<Playlistmodel>(_boxname);
  return box.values.toList();
}

void deletePlaylist(String playlistName, List<int> song) async {
  var box = await Hive.openBox<Playlistmodel>(_boxname);
  var playlist = box.values.firstWhere((sng) => sng.name == playlistName);

  playlist.song.clear();

  await box.delete(playlist.key);
}

void editPlaylistName(String oldName, String newName) async {
  var box = await Hive.openBox<Playlistmodel>(_boxname);
  var playlist = box.values.firstWhere((sng) => sng.name == oldName);
  playlist.name = newName;
  await box.put(playlist.key, playlist);
}

Future<bool> addSongToPlaylist(int playlistId, int songId) async {
  var box = await Hive.openBox<Playlistmodel>(_boxname);
  var playlist = box.get(playlistId);

  if (playlist != null) {
    if (!playlist.song.contains(songId)) {
      playlist.song.add(songId);
      await box.put(playlistId, playlist);
      return true; // Song added successfully
    } else {
      return false; // Song already exists in the playlist
    }
  }

  return false; // Playlist not found
}

Future<List<MusicModel>> getPlaylistSongs(int playlistkey) async {
  print('justin');

  List<MusicModel> song = [];
  final box = await Hive.openBox<Playlistmodel>(_boxname);

  List<MusicModel> sng = await getAllSongs();

  final playlistId = await box.get(playlistkey);
  print("hallo${playlistId!.song.length}");

  for (int i = 0; i < playlistId.song.length; i++) {
    for (int j = 0; j < sng.length; j++) {
      if (sng[j].songid == playlistId.song[i]) {
        song.add(sng[j]);
      }
    }
  }
  for (MusicModel m in song) {
    print('get song ply ${m.songname}');
  }

  return song;
}

void deleteSongFromPlaylist(int playlistId, int songId) async {
  var box = await Hive.openBox<Playlistmodel>(_boxname);
  var playlist = box.get(playlistId);
  if (playlist != null) {
    playlist.song.remove(songId);
    await box.put(playlistId, playlist);
    print('song deleted from the playlist');
  }
}

Future<bool> ifSongContain(MusicModel song, dynamic key) async {
  bool contain = false;
  final playbox = await Hive.openBox<Playlistmodel>(_boxname);
  final box = playbox.get(key);
  List<int> isd = box!.song;
  for (int i = 0; i < isd.length; i++) {
    if (isd[i] == song.songid) {
      contain = true;
    }
  }

  return contain;
}





// Future<void> addSongToPlaylist(int playlistId, int songId) async {
//   var box = await Hive.openBox<Playlistmodel>(_boxname);
//   var playlist = box.get(playlistId);

//   playlist?.song.add(songId);
//   await box.put(playlistId, playlist!);

//   print('hallo ${playlist.song.length}');
// }
