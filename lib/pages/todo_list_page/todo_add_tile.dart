import 'package:fittin_todo/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:fittin_todo/pages/todo_list_page/todo_list_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TodoAddTile extends StatefulWidget {
  const TodoAddTile({super.key});

  @override
  State<TodoAddTile> createState() => TodoAddTileState();
}
 final List<TodoModel> todosAdd = [];
int flag = 0;
int delete = 0;
class TodoAddTileState extends State<TodoAddTile> {
  final myController = TextEditingController();
  DateTime? _date = note?.deadline;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        centerTitle: true,
        automaticallyImplyLeading: false,
        /*Кнопка, закрывающая редактор заметок*/
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            flag++;
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          /*Кнопка для сохранения заметки*/
          TextButton(
              onPressed: (){
                todosAdd.add(TodoModel(text: myController.text, deadline: _date));
                Navigator.pop(context);
              },
              child: Text(
                  'СОХРАНИТЬ',
              style: GoogleFonts.raleway(
                fontSize: 20,
                height: 20 / 14,
                color: const Color(0xFFFF9900),
                fontWeight: FontWeight.bold,
              ),
              ),
          )
        ],
      ),
      body: SafeArea(
      top: false,
      child: Column(
        children: [
          Card(
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
            child:
              TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 20,
              minLines: 7,
              controller: myController,
              decoration: InputDecoration(
                  hintText: note != null ? note?.text :'Здесь будут мои заметки',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
              ),
                onTap: (){
                if (note != null){
                  myController.text = note!.text;
                }
                },
            ),
          ),
          /*Календарь*/
          ListTile(
            title: const Text('Дедлайн'),
              onTap: () async{
                final res = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 100)),
                );
                setState(() {
                  _date = res;
                });
              },
            subtitle: _date != null ? Text(DateFormat('dd-MM-yyyy').format(_date!)): null,
            trailing: Checkbox(
              value: _date != null ? true : false,
              onChanged: (value){
                setState(() {

                });
              },
            ),
          ),
          /*Кнопка для удаления существующей заметки*/
          if (note != null)
            TextButton(
              onPressed: () {
                delete++;
                Navigator.pop(context);
              },
              child: Row(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.delete, color: Color(0xFFF85535)),),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Удалить',
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        height: 20 / 14,
                        color: const Color(0xFFF85535),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
    );
  }
}