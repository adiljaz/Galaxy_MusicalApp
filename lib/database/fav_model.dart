
import 'package:hive_flutter/hive_flutter.dart';
 part 'fav_model.g.dart';

@HiveType(typeId: 1)
class LikedSongModel extends HiveObject{
@HiveField(0)
  int songid;

  LikedSongModel({required this.songid});

}