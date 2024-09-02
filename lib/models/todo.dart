import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String todoId;
  String content;
  bool done;

  TodoModel({required this.todoId, required this.content, required this.done});

  TodoModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot})
      : todoId = '',
        content = '',
        done = false {
    todoId = documentSnapshot.id;
    content =
        (documentSnapshot.data() as Map<String, dynamic>)['content'] as String;
    done = (documentSnapshot.data() as Map<String, dynamic>)['done'] as bool;
  }
}
