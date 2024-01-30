import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studnets_app/controller/controller.dart';
import 'package:studnets_app/model/model_db.dart';
import 'package:studnets_app/screen/student_details/studentdetails.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    final studentList = databaseProvider.studentList;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (context, index) {
                 final student = studentList[index];
                return GestureDetector(
                  
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDetails(stdetails: student)));
                  },
                  child: CustomListTile(title: student.name, subtitle: student.classname, imageUrl: student.imagex));
                //  ListTile(
                //   title: Text(student.name),
                //   subtitle: Text(student.classname),
                // );
              }),
        ));
  }

  void deletestudent(rtx, StudentModel student) {
    showDialog(
      context: rtx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Do You Want delete Name ?'),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(rtx);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}


class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( bottom: 5),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color.fromRGBO(247, 241, 239, 0.994),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              // color: Colors.white,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 70, 70, 70),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: 100, 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(imageUrl),
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
