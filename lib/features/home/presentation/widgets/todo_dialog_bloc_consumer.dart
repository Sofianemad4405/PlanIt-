// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:planitt/features/home/presentation/cubit/home_cubit.dart';
// import 'package:planitt/features/home/presentation/widgets/todo_read_dialog.dart';

// class TodoDialogBlocConsumer extends StatefulWidget {
//   const TodoDialogBlocConsumer({super.key});

//   @override
//   State<TodoDialogBlocConsumer> createState() => _TodoDialogBlocConsumerState();
// }

// class _TodoDialogBlocConsumerState extends State<TodoDialogBlocConsumer> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer(
//       builder: (context, state) {
//         if (state is HomeViewingTodo) {
//           return TodoReadDialog(toDoKey: state.todo.key);
//         }
//         return const SizedBox.shrink();
//       },
//       listener: (context, state) {},
//     );
//   }
// }
