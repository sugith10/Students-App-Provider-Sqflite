import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_10/controller/controller.dart';
import 'package:sqflite_10/model/model_db.dart';
import 'package:sqflite_10/screen/home_screen/list_view/list_view.dart';
import 'package:sqflite_10/screen/student_details/studentdetails.dart';

class SearchProvider extends ChangeNotifier {
  List<StudentModel> _findUserList = [];

  List<StudentModel> get findUserList => _findUserList;

  void search(String query, List<StudentModel> studentList) {
    _findUserList = studentList
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()) ||
            student.classname.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);

    final studentList = databaseProvider.studentList;
    final findUserList = searchProvider.findUserList;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                onChanged: (value) {
                  searchProvider.search(value, studentList);
                },
                decoration: const InputDecoration(
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: findUserList.length,
                itemBuilder: (context, index) {
                  final student = findUserList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StudentDetails(stdetails: student),
                        ),
                      );
                    },
                    child: CustomListTile(
                      title: student.name,
                      subtitle: student.classname,
                      imageUrl: student.imagex,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  //... rest of the code remains unchanged
}


