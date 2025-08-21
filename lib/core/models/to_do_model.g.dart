// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoModelAdapter extends TypeAdapter<ToDoModel> {
  @override
  final int typeId = 0;

  @override
  ToDoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoModel(
      title: fields[0] as String,
      description: fields[1] as String?,
      createdAt: fields[2] as DateTime,
      dueDate: fields[3] as DateTime?,
      priority: fields[4] as String,
      subtasks: (fields[5] as List?)?.cast<String>(),
      project: fields[6] as ProjectModel,
      isToday: fields[7] as bool,
      isTomorrow: fields[8] as bool,
      isOverdue: fields[9] as bool,
      key: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.dueDate)
      ..writeByte(4)
      ..write(obj.priority)
      ..writeByte(5)
      ..write(obj.subtasks)
      ..writeByte(6)
      ..write(obj.project)
      ..writeByte(7)
      ..write(obj.isToday)
      ..writeByte(8)
      ..write(obj.isTomorrow)
      ..writeByte(9)
      ..write(obj.isOverdue)
      ..writeByte(10)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
