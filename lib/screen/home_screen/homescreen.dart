import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studnets_app/provider/home_screen.dart';
import 'package:studnets_app/screen/add_screen/addstudent.dart';
import 'package:studnets_app/screen/home_screen/grid_view/grid_view.dart';
import 'package:studnets_app/screen/home_screen/list_view/list_view.dart';
import 'package:studnets_app/screen/search_screen/searchscreen.dart';

class HomeScreeen extends StatelessWidget {
  const HomeScreeen({super.key});

   


  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Students Record',
          style: TextStyle(
              color: Color.fromARGB(255, 89, 55, 32),
              fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctxs) => const SearchScreen()));
              },
              icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: Column(
        children: [
           Expanded(
            child: Consumer<HomeScreenProvider>(
              builder: (context, homeScreenProvider, child) {
                return homeScreenProvider.index == 0
                    ? const StudentListGridView()
                    : const StudentList();
              },
            ),
            // child: SizedBox(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: true, 
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 89, 55, 32),
          shape: const CircleBorder(),
          elevation: 4, 
          onPressed: () {
            addstudent(context);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_3x3_rounded), label: 'Grid'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List')
        ],
        currentIndex: Provider.of<HomeScreenProvider>(context).index,
        onTap: (int index) {
           Provider.of<HomeScreenProvider>(context, listen: false)
              .setIndex(index);
        },
      ),
    );
  }

  void addstudent(gtx) {
    Navigator.of(gtx)
        .push(MaterialPageRoute(builder: (gtx) =>  AddStudent()));
  }
}
