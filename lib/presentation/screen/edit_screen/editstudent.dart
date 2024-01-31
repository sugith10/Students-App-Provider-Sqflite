import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studnets_app/controller/controller.dart';
import 'package:studnets_app/model/model_db.dart';
import 'package:studnets_app/presentation/screen/home_screen/homescreen.dart';

class EditStudent extends StatelessWidget {
  final StudentModel student;

  EditStudent({super.key,  required this.student});

  String? updatedImagepath;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  final _guardianController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {

       final databaseProvider = Provider.of<DatabaseProvider>(context);

    _nameController.text = student.name;
    _classController.text = student.classname;
    _guardianController.text = student.father;
    _mobileController.text = student.pnumber;
    updatedImagepath = student.imagex;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
        actions: [
          IconButton(
            onPressed: () {
              editStudentClicked(
                context,
                student,
                databaseProvider
              );
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreeen()));
            },
            icon: const Icon(Icons.cloud_upload),
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    InkWell(
                      onTap: () => editPhoto(context),
                      child: CircleAvatar(
                        backgroundImage: updatedImagepath != null
                            ? FileImage(File(updatedImagepath!))
                            : FileImage(File(student.imagex)),
                        radius: 80,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    const Icon(Icons.abc_outlined),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                 // Class input field with validation
                  Row(
                    children: [
                      const Icon(Icons.class_outlined),
                      const SizedBox(
                          width: 10), // Add spacing between icon and text field
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _classController,
                          decoration: InputDecoration(
                            labelText: "Class",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Class';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Guardian input field with validation
                  Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(
                          width: 10), // Add spacing between icon and text field
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _guardianController,
                          decoration: InputDecoration(
                            labelText: "Parent",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Parent Name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Mobile input field with validation
                  Row(
                    children: [
                      const Icon(Icons.phone_sharp),
                      const SizedBox(
                          width: 10), // Add spacing between icon and text field
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _mobileController,
                          decoration: InputDecoration(
                            labelText: "Mobile",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Mobile';
                            } else if (value.length != 10) {
                              return 'Mobile number should be 10 digits';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }
    updatedImagepath = image.path.toString();
  }

  Future<void> editStudentClicked(BuildContext context, StudentModel student,  DatabaseProvider databaseProvider) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.toUpperCase();
      final classA = _classController.text.toString().trim();
      final father = _guardianController.text;
      final phonenumber = _mobileController.text.trim();

      final updatedStudent = StudentModel(
        id: student.id,
        name: name,
        classname: classA,
        father: father,
        pnumber: phonenumber,
        imagex: updatedImagepath ?? student.imagex,
      );

      // Assuming you have a function to edit student in your DatabaseProvider class
      await databaseProvider.editStudent(
        updatedStudent.id!,
        updatedStudent.name,
        updatedStudent.classname,
        updatedStudent.father,
        updatedStudent.pnumber,
        updatedStudent.imagex,
      );
    }
  }

  void editPhoto(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Photo'),
          actions: [
            Column(
              children: [
                Row(
                  children: [
                    const Text('Choose from camera'),
                    IconButton(
                      onPressed: () {
                        getImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Choose from gallery '),
                    IconButton(
                      onPressed: () {
                        getImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.image,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
