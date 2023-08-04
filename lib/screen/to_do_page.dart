import 'dart:convert';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:todo/screen/to_do_list.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage(this.title, this.description, this.id, this.is_Edit,
      {super.key});
  // const ToDoPage({super.key});
  final String title;
  final String description;
  final String id;
  final bool is_Edit;

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: widget.is_Edit == false ? Text("Add Todo") : Text("Edit Todo"),
        ),
      ),
      body: ListView(padding: EdgeInsets.all(20), children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            hintText: 'Title',
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            hintText: 'Description',
          ),
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          minLines: 5,
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.is_Edit == false) {
              submitData();
            } else {
              editData(widget.id);
              // submitData();
            }
          },
          child: widget.is_Edit == false ? Text('Submit') : Text('Update'),
        )
      ]),
    );
  }

  Future<void> submitData() async {
    // Get the data from form
    final title = titleController.text;
    final description = descriptionController.text;
    final data = {
      "title": title,
      "description": description,
      "is_completed": true
    };

    //submit data to the server
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });

    // show success or fail message based on status
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 201) {
      showSuccessNotification('Successfully Submitted');
      titleController.text = "";
      descriptionController.text = "";
    } else {
      showErrorNotification('Erro Occurred');
    }
  }

  Future<void> editData(String id) async {
    // Get the data from form
    final title = titleController.text;
    final description = descriptionController.text;
    final data = {
      "title": title,
      "description": description,
      "is_completed": true
    };

    //submit data to the server
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });

    // show success or fail message based on status
    if (response.statusCode == 200) {
      showSuccessNotification('Successfully Updated');
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ToDoList(),
      //     ));
      setState(() {});
    } else {
      showErrorNotification('You Cannot Changed');
    }
    // print(response.body);
  }

  void showSuccessNotification(String message) {
    var green = Colors.green;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: green,
      ),
    );
  }

  void showErrorNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
