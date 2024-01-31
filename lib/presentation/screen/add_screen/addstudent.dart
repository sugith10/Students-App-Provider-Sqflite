import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studnets_app/controller/controller.dart';
import 'package:studnets_app/model/model_db.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});

  File? image25;
  String? imagepath;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  final _guardianController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(0, 255, 255, 255),
      //   automaticallyImplyLeading: false,
      //   // title: const Text('Add Student'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            size: 40,
                            color: Color.fromARGB(255, 43, 43, 43),
                          ))),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onTap: () {
                      print('he;;');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        size: 150,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Name input field with validation
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: const Icon(Icons.abc_outlined),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Class input field with validation
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _classController,
                    decoration: InputDecoration(
                      labelText: "Class",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: const Icon(Icons.class_outlined),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Class';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Guardian input field with validation
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _guardianController,
                    decoration: InputDecoration(
                      labelText: "Guardian",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Guardian';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Mobile input field with validation
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _mobileController,
                    decoration: InputDecoration(
                      labelText: "Mobile",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: const Icon(Icons.phone_sharp),
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

                  const SizedBox(height: 50),

                  OutlinedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                          const Size(double.infinity, 55)),
                    ),
                    onPressed: () {
                      addstudentclicked(context, databaseProvider);
                    },
                    child: const Text(
                      'Add Student',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addstudentclicked(
      BuildContext context, DatabaseProvider databaseProvider) async {
    if (_formKey.currentState!.validate() && image25 != null) {
      final name = _nameController.text.toUpperCase();
      final classA = _classController.text.toString().trim();
      final father = _guardianController.text;
      final phonenumber = _mobileController.text.trim();

      final stdData = StudentModel(
        name: name,
        classname: classA,
        father: father,
        pnumber: phonenumber,
        imagex: imagepath!,
      );
      await databaseProvider.addStudent(stdData);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Color.fromARGB(255, 102, 223, 164),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add Profile Picture '),
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<void> getimage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }

    image25 = File(image.path);
    imagepath = image.path.toString();
    // setState(() {
    //   image25 = File(image.path);
    //   imagepath = image.path.toString();
    // });
  }

  void addphoto(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: const Text('Choose Image From.......'),
          actions: [
            IconButton(
              onPressed: () {
                getimage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                getimage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.image,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
