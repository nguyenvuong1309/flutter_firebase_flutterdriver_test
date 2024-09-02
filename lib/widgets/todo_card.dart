import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoCard extends StatelessWidget {
  final FirebaseFirestore firestore;
  final String uid;
  final TodoModel todo;

  const TodoCard({
    required this.firestore,
    required this.uid,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(todo.content),
        // Thêm các thuộc tính khác nếu cần
      ),
    );
  }
}
