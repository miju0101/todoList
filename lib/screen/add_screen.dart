import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/dao/database.dart';

class AddScreen extends StatelessWidget {
  final Function refresh;

  const AddScreen({required this.refresh});
  
  @override
  Widget build(BuildContext context) {
    TextEditingController  title_controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(CupertinoIcons.back), onPressed: (){
          Navigator.pop(context);
        },),
        title: Text("할 일 추가"),
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
                await MyDataBase.addTodo(title_controller.text);
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