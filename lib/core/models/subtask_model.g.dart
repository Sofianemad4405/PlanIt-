// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubtaskModelAdapter extends TypeAdapter<SubtaskModel> {
  @override
  final int typeId = 4;

  @override
  SubtaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubtaskModel(
      title: fields[0] as String,
      isCompleted: fields[1] as bool,
      index: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SubtaskModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.isCompleted)
      ..writeByte(2)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
