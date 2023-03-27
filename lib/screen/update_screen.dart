import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/dao/database.dart';

class UpdateScreen extends StatelessWidget {
  final Map<String, dynamic> todo;
  final Function refresh;

  const UpdateScreen({required this.todo,required this.refresh ,Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController  title_controller = TextEditingController();
    title_controller.text = todo['title'];
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(CupertinoIcons.back), onPressed: (){
          Navigator.pop(context);
        },),
        title: const Text("수정"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: title_controller,
                decoration: const InputDecoration(
                  hintText: "할 일"
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: () async{
                await MyDataBase.updateTodo(todo['id'], title_controller.text);
                await refresh();
                Navigator.pop(context);
              }, child: const Text("완료"))
            ],
          ),
        )
      )
    );
  }
}