import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_provider/provider/dailog_screen/dialog_screen.dart';
import 'package:studentapp_provider/provider/database.dart';
import 'package:studentapp_provider/screens/add_students/add_students.dart';
import 'package:studentapp_provider/screens/student_detils/student_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentData>(context);
    studentProvider.getAllStudents();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'HOME SCREEN',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 3, 3, 3),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => navigateToForm(context),
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            Consumer<StudentData>(
              builder: (context, value, child) => value.students.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: value.students.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            child: SizedBox(
                              height: 70,
                              child: Card(
                                color: const Color.fromARGB(255, 203, 201, 201),
                                elevation: 10,
                                child: ListTile(
                                  onTap: () {
                                    navigateToProfile(context, index);
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(
                                        File(value.students[index].profile)),
                                    radius: 30,
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        value.students[index].name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Consumer<DailogProvider>(
                                        builder: (context, value, child) =>
                                            IconButton(
                                                onPressed: () =>
                                                    value.dialogBuilder(
                                                        context, index),
                                                icon: const Icon(Icons.delete)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ));
  }
}

void navigateToForm(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => AddStudents(),
    ),
  );
}

void navigateToProfile(BuildContext context, int index) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => StudentDetails(index: index),
    ),
  );
}
