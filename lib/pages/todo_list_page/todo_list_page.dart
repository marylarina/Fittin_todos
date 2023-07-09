import 'package:fittin_todo/models/todo_model.dart';
import 'package:fittin_todo/pages/todo_list_page/todo_add_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}
  TodoModel? note;

class _TodoListPageState extends State<TodoListPage> {
  final List<TodoModel> _todos = [];

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        centerTitle: true,
        title: Text(
          'Мои дела',
          style: themeData.textTheme.headlineSmall?.copyWith(),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 5,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    /*Две кнопки для удаления и зачеркивания заметки соответственно*/
                    SlidableAction(
                      onPressed: (value){
                        setState((){
                          _todos.removeAt(index);
                    });
                      },
                      icon: Icons.delete,
                      backgroundColor: const Color(0xFFF85535),
                    )
                  ],
                ),
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (value){
                        setState((){
                          _todos[index].done ? _todos[index] = _todos[index].copyWith(done: false):
                          _todos[index] = _todos[index].copyWith(done: true);
                        });
                      },
                      icon: Icons.done,
                      backgroundColor: const Color(0xFF45B443),
                    ),
                  ],
                ),
                /*При долгом нажатии на заметку ее можно отредактировать или удалить*/
                child: GestureDetector(
                  onLongPress: () async{
                    note = TodoModel(text: _todos[index].text, deadline: _todos[index].deadline);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const TodoAddTile() ;
                        },
                      ),
                    );
                    setState(
                          () {
                            if (flag == 0) {
                              if(delete == 0) {
                                _todos[index] = TodoModel(
                                    text: todosAdd[0].text.isNotEmpty
                                        ? todosAdd[0].text
                                        : 'Пустая заметка', deadline: todosAdd[0].deadline);
                                todosAdd.clear();
                                note = null;
                              }else{
                                _todos.removeAt(index);
                                note = null;
                              }
                            }else{
                              flag = 0;
                              note = null;}
                      },
                    );
                  },
                   child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _todos[index].done,
                  onChanged: (value) {
                    final checked = value ?? false;
                    setState(() {
                      _todos[index] = _todos[index].copyWith(
                        done: checked,
                      );
                    });
                  },
                     title: Text(
                      _todos[index].text,
                       style: TextStyle(
                         fontSize: 20,
                         height: 20 / 16,
                         color: _todos[index].done ? Colors.black12: Colors.black,
                         decoration: _todos[index].done ? TextDecoration.lineThrough: TextDecoration.none,
                         decorationColor: _todos[index].done ? Colors.black12: Colors.black,
                       ),
                  ),
                     subtitle: _todos[index].deadline != null ? Text(DateFormat('dd-MM-yyyy').format(_todos[index].deadline!)) : null,
                ),
                ),
              );
            },
          ),
        ),
      ),
      /*Кнопка для добавления новой заметки*/
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const TodoAddTile() ;
              },
            ),
          );
          setState(
            () {
              if(flag == 0) {
                _todos.add(TodoModel(
                    text: todosAdd[0].text.isNotEmpty
                        ? todosAdd[0].text
                        : 'Пустая заметка', deadline: todosAdd[0].deadline));
                todosAdd.clear();
              }else{flag = 0; note = null;}
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
