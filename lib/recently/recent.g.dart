// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentmodelAdapter extends TypeAdapter<Recentmodel> {
  @override
  final int typeId = 2;

  @override
  Recentmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recentmodel(
      songId: fields[0] as int,
      name: fields[1] as String,
      artistname: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Recentmodel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.songId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.artistname);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
