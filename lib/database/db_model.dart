
import 'package:hive_flutter/hive_flutter.dart';
 part 'db_model.g.dart';

@HiveType(typeId: 0)
class MusicModel {
  @HiveField(0)
  int  songid;
  @HiveField(1)
  String songname;
  @HiveField(2)
  String artistname;
  @HiveField(3)
  String uri;
  MusicModel({required this.artistname,required this.songid,required this.songname,required this.uri});
}