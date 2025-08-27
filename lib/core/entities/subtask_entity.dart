class SubtaskEntity {
  String title;
  bool isCompleted;
  int index;

  SubtaskEntity({
    required this.title,
    this.isCompleted = false,
    required this.index,
  });

  SubtaskEntity copyWith({String? title, bool? isCompleted, int? index}) =>
      SubtaskEntity(
        title: title ?? this.title,
        isCompleted: isCompleted ?? this.isCompleted,
        index: index ?? this.index,
      );
}
