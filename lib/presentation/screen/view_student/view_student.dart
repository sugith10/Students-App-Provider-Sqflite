import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studnets_app/controller/controller.dart';
import 'package:studnets_app/model/model_db.dart';
import 'package:studnets_app/presentation/screen/edit_screen/editstudent.dart';


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
              color: Color.fromARGB(255, 89, 55, 32),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 400,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  File(stdetails.imagex),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
         
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
          const Spacer(),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor:  const Color.fromARGB(255, 89, 55, 32),
        onPressed: (){
        
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditStudent(student: stdetails,)));
      }, child: const Icon(Icons.edit, color:  Colors.white,),),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Row(
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
