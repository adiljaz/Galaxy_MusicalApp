

import 'package:galaxy/database/db_model.dart';
import 'package:galaxy/playlist/playlist_model.dart';
import 'package:hive_flutter/hive_flutter.dart';


String _boxname='playlist'; 

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
  playlist.song.addAll(song);
  await box.delete(playlist.key);
}



void editPlaylistName(String oldName, String newName) async {
  var box = await Hive.openBox<Playlistmodel>(_boxname);
  var playlist = box.values.firstWhere((sng) => sng.name == oldName);
  playlist.name = newName;
  await box.put(playlist.key, playlist);
}


Future<void> addSongToPlaylist(int playlistId, List<int> songId) async {
  var box = await Hive.openBox<Playlistmodel>(_boxname);
  var playlist = box.get(playlistId);
  if (playlist != null) {
    playlist.song.addAll(songId);
    await box.put(playlistId, playlist);
  }
}






Future <List<MusicModel>> getPlaylistSong(int playlisId) async{

var box=await Hive.openBox<Playlistmodel>(_boxname);
var playlist =box.get(playlisId);

if(playlist!=null){
  List<int> songIds=playlist.song; 
  List<MusicModel> playlistSOngs;
}

return [];

}




Future<List<MusicModel>> getPlaylistSongs(int playlistId) async {
  var box = await Hive.openBox<Playlistmodel>(_boxname);
  var playlist = box.get(playlistId);

  if (playlist != null) {
    List<int> songIds = playlist.song;
    List<MusicModel> playlistSongs = [];

    // Assuming MusicModel has attributes songid, songname, artistname
    for (var songId in songIds) {
      var song = await getSongById(songId);
      if (song != null) {
        playlistSongs.add(song);
      }
    }

    return playlistSongs;
  }

  return []; 
}



Future<MusicModel?> getSongById(int songId) async {
 
}











