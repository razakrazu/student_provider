import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_provider/core/color.dart';
import 'package:studentapp_provider/core/condent.dart';
import 'package:studentapp_provider/provider/database.dart';
import 'package:studentapp_provider/screens/edit_screen/edit_screen.dart';

int? student;

class StudentDetails extends StatelessWidget {
  const StudentDetails({key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    student = index;
    return Consumer<StudentData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: colorwhite,
                size: 30,
              )),
          title: const Text(
            'STUDENT DETAILS',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 3, 3, 3),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, bottom: 90, top: 30),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 145, 139, 139),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                  border: Border.all(width: 0),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Center(
                      child: CircleAvatar(
                    backgroundImage:
                        FileImage(File(value.students[index].profile)),
                    radius: 90,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'NAME : ${value.students[index].name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'AGE :  ${value.students[index].age}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'CONTACT : ${value.students[index].contact}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'EMAIL: ${value.students[index].email}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  kheight10,
                  ElevatedButton(
                      onPressed: () => navigateToedit(context, student),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 7, 7, 7),
                      ),
                      child: const Text('Edit',
                          style: TextStyle(fontSize: 15, color: colorwhite))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void navigateToedit(BuildContext context, int? index) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditStudent(index: index!),
    ),
  );
}
