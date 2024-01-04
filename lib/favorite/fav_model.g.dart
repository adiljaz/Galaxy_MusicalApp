// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LikedSongModelAdapter extends TypeAdapter<LikedSongModel> {
  @override
  final int typeId = 1;

  @override
  LikedSongModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LikedSongModel(
      songid: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LikedSongModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.songid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikedSongModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
