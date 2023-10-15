
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studentapp_provider/model/modal.dart';

class StudentData extends  ChangeNotifier{
  
  List<StudentModel>students=[];
  
  Future<void>addStudent(StudentModel student)async{
    final studentDB=await Hive.openBox<StudentModel>('student_db');
    students.add(student);
    await studentDB.add(student);
    notifyListeners();
  }
  Future<void>getAllStudents()async{
    final studentDB= await Hive.openBox<StudentModel>('student_db');
    students.clear();
   students.addAll(studentDB.values);
    notifyListeners();
  }
  Future<void>deleteStudent(int index) async{
    final studentDB=await Hive.openBox<StudentModel>('student_db');
    await studentDB.delete(index);
    getAllStudents();

  }
  Future<void>update(int index,StudentModel student)async{
    final studentDB= await Hive.openBox<StudentModel>('student_db');
    await studentDB.putAt(index, student);
    getAllStudents();
    notifyListeners();
  }

}