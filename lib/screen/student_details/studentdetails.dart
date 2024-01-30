import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_10/controller/controller.dart';
import 'package:sqflite_10/model/model_db.dart';
import 'package:sqflite_10/screen/editstudent.dart';

class StudentDetails extends StatelessWidget {
  final StudentModel stdetails;

  const StudentDetails({Key? key, required this.stdetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final databaseProvider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              databaseProvider.deleteStudent(stdetails.id!);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
              color: Color.fromARGB(255, 207, 45, 33),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              child: Image.file(
                File(stdetails.imagex),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  buildDetailRow('Name', stdetails.name),
                  const SizedBox(
                    height: 25,
                  ),
                  buildDetailRow('Class', stdetails.classname),
                  const SizedBox(
                    height: 25,
                  ),
                  buildDetailRow('Parent', stdetails.father),
                  const SizedBox(
                    height: 25,
                  ),
                  buildDetailRow('Mobile', stdetails.pnumber),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor:  Color.fromARGB(255, 89, 55, 32),
        onPressed: (){
        
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditStudent(student: stdetails,)));
      }, child: Icon(Icons.edit, color:  Colors.white,),),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$title :',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 55, 55, 55),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
