import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/screen/to_do_page.dart';
import 'package:http/http.dart' as http;

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  void initState() {
    super.initState();
    fetchData();
  }

  List items = [];
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Todo List")),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchData,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Todo Item',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  String title = items[index]['title'];
                  String description = items[index]['description'];
                  String id = items[index]['_id'];
                  return Card(
                    child: ListTile(
                        leading: CircleAvatar(
                          child: Text("${index + 1}"),
                        ),
                        title: Text(title),
                        subtitle: Text(description),
                        trailing: PopupMenuButton(onSelected: (value) {
                          if (value == 'edit') {
                            // to perform edit
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ToDoPage(
                                        title, description, id, true)));
                          } else if (value == 'delete') {
                            // to perform delete and update list
                            onDelete(id);
                          }
                        }, itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: Text('Edit'),
                              value: 'edit',
                            ),
                            PopupMenuItem(
                              child: Text('Delete'),
                              value: 'delete',
                            ),
                          ];
                        })),
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigator.push(context, navigationAdd);
          navigationAdd();
        },
        label: Text("Add Todo"),
      ),
    );
  }

  Future<void> navigationAdd() async {
    final route = MaterialPageRoute(
      builder: (context) => ToDoPage("", "", "", false),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  Future<void> onDelete(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      setState(() {
        // items.removeWhere((item) => item['id'] == id);
        fetchData();
      });
      print('Success fully deleted of id:$id');
    } else {
      print('Delete request failed');
    }
  }

  Future<void> fetchData() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
    // print(response.statusCode);
    // print(response.body);
  }
}
