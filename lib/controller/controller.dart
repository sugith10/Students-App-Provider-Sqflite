import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studnets_app/model/model_db.dart';


class DatabaseProvider extends ChangeNotifier {
  late Database _db;
  final List<StudentModel> _studentList = [];

  DatabaseProvider() {
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    _db = await openDatabase(
      'student_db',
      version: 1,
      onCreate: (Database db, version) async {
        await db.execute(
            'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, classname TEXT, father TEXT, pnumber TEXT, imagex TEXT)');
      },
    );
    log("Database created successfully.");
    await getStudentData(); // Initial data retrieval
  }

  List<StudentModel> get studentList => _studentList;

  Future<void> getStudentData() async {
    final result = await _db.rawQuery("SELECT * FROM student");
       log('All Students data : $result');
    _studentList.clear();
    for (var map in result) {
      final student = StudentModel.fromMap(map);
      _studentList.add(student);
    }
    notifyListeners();
  }

  Future<void> addStudent(StudentModel value) async {
    try {
      await _db.rawInsert(
        'INSERT INTO student(name,classname,father,pnumber,imagex) VALUES(?,?,?,?,?)',
        [value.name, value.classname, value.father, value.pnumber, value.imagex],
      );
      await getStudentData();
    } catch (e) {
      print('Error inserting data: $e');
    }
  }

  Future<void> deleteStudent(int id) async {
    await _db.delete('student', where: 'id=?', whereArgs: [id]);
    await getStudentData();
  }

  Future<void> editStudent(int id, String name, String classname, String father, String pnumber, String imagex) async {
    final dataflow = {
      'name': name,
      'classname': classname,
      'father': father,
      'pnumber': pnumber,
      'imagex': imagex,
    };
    await _db.update('student', dataflow, where: 'id=?', whereArgs: [id]);
    await getStudentData();
  }
}
