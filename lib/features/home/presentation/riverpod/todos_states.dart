// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:planitt/core/entities/to_do_entity.dart';

// enum TodosTab { today, upcoming, all }

// class TodosState {
//   final TodosTab currentTab;
//   final String searchQuery;
//   final AsyncValue<List<ToDoEntity>> todos;

//   TodosState({
//     this.currentTab = TodosTab.today,
//     this.searchQuery = "",
//     this.todos = const AsyncValue.loading(),
//   });

//   TodosState copyWith({
//     TodosTab? currentTab,
//     String? searchQuery,
//     AsyncValue<List<ToDoEntity>>? todos,
//   }) {
//     return TodosState(
//       currentTab: currentTab ?? this.currentTab,
//       searchQuery: searchQuery ?? this.searchQuery,
//       todos: todos ?? this.todos,
//     );
//   }
// }
