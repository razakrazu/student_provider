import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_provider/core/color.dart';
import 'package:studentapp_provider/model/modal.dart';
import 'package:studentapp_provider/provider/dailog_screen/dialog_screen.dart';
import 'package:studentapp_provider/provider/database.dart';
import 'package:studentapp_provider/provider/image_function/image_function.dart';
import 'package:studentapp_provider/screens/add_students/student_photo.dart';

class AddStudents extends StatelessWidget {
  AddStudents({super.key});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final ageController = TextEditingController();
  final contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            const Stack(
              children: [
                Center(child: StudentPhoto()),
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
                              left: 100, right: 90, top: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (value.imgPath == null) {
                                  alert.notSuccess(context);
                                } else {
                                  isSccess(value, data, context);
                                }
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 7, 7, 7),
                            ),
                            child: const Text('Submit',
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

  void isSccess(
      StudentImage value, StudentData data, BuildContext context) async {
    final selectedImage = value.imgPath;
    if (selectedImage == null) {
      return;
    }

    final studentObject = StudentModel(
      id: DateTime.now(),
      profile: selectedImage,
      name: nameController.text.trim(),
      email: mailController.text.trim(),
      age: int.parse(ageController.text),
      contact: int.parse(contactController.text.trim()),
    );

    data.addStudent(studentObject);
    value.imgPath = null;
    Navigator.of(context).pop();
  }
}
