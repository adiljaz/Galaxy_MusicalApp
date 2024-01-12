// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistmodelAdapter extends TypeAdapter<Playlistmodel> {
  @override
  final int typeId = 3;

  @override
  Playlistmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playlistmodel(
      name: fields[0] as String,
      song: (fields[1] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Playlistmodel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.song);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
