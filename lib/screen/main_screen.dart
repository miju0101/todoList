import 'package:flutter/material.dart';
import 'package:todo_list/dao/database.dart';
import 'package:todo_list/screen/add_screen.dart';
import 'package:todo_list/screen/update_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  List<Map<String, dynamic>> todos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData() async{
    var datas = await MyDataBase.getTodos();
    setState(() {
      todos = datas;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("할 일"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: isLoading == true? const Center(child: Text("loading...")):
          ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Text(todos[index]['title']),
                    const Spacer(),
                    IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen(todo: todos[index], refresh: refreshData)));
                      }, 
                      icon: Icon(Icons.edit)
                    ), 
                    IconButton(
                      onPressed: (){
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return AlertDialog(
                              content: Text("삭제하실건가요?"),
                              actions: [
                                Center(
                                  child: GestureDetector(
                                    onTap: () async{
                                      await MyDataBase.deleteTodo(todos[index]['id']);
                                      setState(() {
                                        refreshData();
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("예"),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete)
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            },
          )
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => AddScreen(refresh: refreshData))
        );
      }, child: const Icon(Icons.add)),
    );
  }
}