import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_provider/core/color.dart';
import 'package:studentapp_provider/model/modal.dart';
import 'package:studentapp_provider/provider/dailog_screen/dialog_screen.dart';
import 'package:studentapp_provider/provider/database.dart';
import 'package:studentapp_provider/provider/image_function/image_function.dart';

final formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();
TextEditingController mailController = TextEditingController();
TextEditingController ageController = TextEditingController();
TextEditingController contactController = TextEditingController();
String studentImageEdit = '';

class EditStudent extends StatelessWidget {
  const EditStudent({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    initialize(context, index);
    return Scaffold(
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
          'ADD STUDENT',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 3, 3, 3),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            Stack(
              children: [
                Center(
                  child:
                      Consumer<StudentImage>(builder: (context, value, child) {
                    final selectedImage = value.imgPath;
                    return selectedImage == null
                        ? GestureDetector(
                            onTap: () => getimage(value),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  FileImage(File(studentImageEdit)),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => getimage(value),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(File(selectedImage)),
                            ),
                          );
                  }),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: Consumer<StudentImage>(
                    builder: (context, value, child) => GestureDetector(
                      onTap: () => getimage(value),
                      child: const Padding(
                        padding: EdgeInsets.only(
                          right: 175,
                        ),
                        child: CircleAvatar(
                          radius: 15,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: colorblack,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  hintText: 'Name',
                ),
                validator: (value) =>
                    nameController.text.isEmpty ? 'Name field is empty' : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: TextFormField(
                controller: mailController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: colorblack,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  hintText: 'Email',
                ),
                validator: (value) =>
                    nameController.text.isEmpty ? 'Name field is empty' : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              child: TextFormField(
                controller: ageController,
                maxLength: 2,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: colorblack,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  hintText: 'Age',
                ),
                validator: (value) =>
                    nameController.text.isEmpty ? 'Name field is empty' : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: contactController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3,
                      color: colorblack,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  hintText: 'Number',
                ),
                validator: (value) =>
                    nameController.text.isEmpty ? 'Name field is empty' : null,
              ),
            ),
            Consumer<StudentImage>(
              builder: (context, value, child) => Consumer<StudentData>(
                builder: (context, data, child) => Consumer<DailogProvider>(
                  builder: (context, alert, child) => Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 110, right: 100, top: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (value.imgPath == null) {
                                  value.imgPath = studentImageEdit;
                                  update(index, context);
                                } else {
                                  update(index, context);
                                }
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 7, 7, 7),
                            ),
                            child: const Text('Update',
                                style:
                                    TextStyle(fontSize: 15, color: colorwhite)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> initialize(BuildContext context, int index) async {
  final studentData = Provider.of<StudentData>(context, listen: false);
  String name = studentData.students[index].name;
  nameController = TextEditingController(text: name);
  String email = studentData.students[index].email;
  mailController = TextEditingController(text: email);
  int age = studentData.students[index].age;
  ageController = TextEditingController(text: age.toString());
  int contact = studentData.students[index].contact;
  contactController = TextEditingController(text: contact.toString());
  studentImageEdit = studentData.students[index].profile;
}

getimage(StudentImage value) async {
  await value.getImage();
}

void update(int index, BuildContext context) {
  final img = Provider.of<StudentImage>(context, listen: false);
  final data = Provider.of<StudentData>(context, listen: false);
  final alert = Provider.of<DailogProvider>(context, listen: false);
  final studentObject = StudentModel(
      id: DateTime.now(),
      profile: img.imgPath!,
      name: nameController.text.trim(),
      email: mailController.text.trim(),
      age: int.parse(ageController.text.trim()),
      contact: int.parse(contactController.text.trim()));
  data.update(index, studentObject);
  img.imgPath = null;
  alert.success(context);
  Navigator.of(context).pop();
}
