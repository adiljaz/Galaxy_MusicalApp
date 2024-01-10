import 'package:galaxy/playlist/playlist_model.dart';
import 'package:hive_flutter/hive_flutter.dart';


String _boxname='playlist'; 

void addPlaylist(String name ) async {
  var box = await Hive.openBox<Playlistmodel>(_boxname);
  var playlist = Playlistmodel(name:name ,song:[] );
await box.add(playlist);
}

Future<List<Playlistmodel>> getallPlaylist()async{
  var box =await Hive.openBox<Playlistmodel>(_boxname);
  return box.values.toList();
}

void addSongtoPlaylist(String playlistname , List <String> song ) async{
  var box = await  Hive.openBox<Playlistmodel>(_boxname);
  var playlist= box.values.firstWhere((sng) => sng.name==playlistname);
  playlist.song.addAll(song);
  await box.put(playlist.key, playlist);
}


void deletePlaylist(String playlistName, List<String> song ) async{
  var box = await Hive.openBox<Playlistmodel>(_boxname); 
  var playlist =box.values.firstWhere((sng) => sng.name == playlistName);
  playlist.song.addAll(song);
  await box.delete(playlist.key);
}


void editPLaylistName(String oldname, String newName)async{
  var box= await Hive.openBox<Playlistmodel>(_boxname);
  var playlist =box.values.firstWhere((sng) => sng.name==oldname);
  playlist.name=newName;
  await box.put(playlist.key, playlist);

}


