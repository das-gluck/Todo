import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:todo/Controller/controller.dart';

import '../Model/model.dart';
import 'my_notes.dart';


class NoteList extends StatelessWidget {
  final NoteController nc = Get.put(NoteController());
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Todo App"),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
              onPressed: (){
              Get.to(MyNote());
              }
          ),
          body: Column(
            children: [
              const SizedBox(height: 20),
              // SerachBar(),
              SearchBar(),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Obx(
                      () => nc.notes.isEmpty ? Center(child: Text("No wook to do ")) :
                          ListView.builder(
                            itemCount: nc.found.length,
                            itemBuilder: (context , index) => Card(
                              child: ListTile(
                                title: Text(nc.notes[index].title!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),),
                                leading: Text("${index+1}.",style: const TextStyle(fontSize: 15),),
                                trailing: Wrap(
                                  children: [
                                    IconButton(
                                        onPressed: (){
                                          Get.to(MyNote(index: index,));
                                        },
                                        icon: const Icon(Icons.create),
                                    ),
                                    IconButton(
                                      onPressed: (){
                                        Get.defaultDialog(
                                          title: 'Delete',
                                          middleText: 'Sure want to delete',
                                          onCancel: () => Get.back(),
                                          onConfirm: () {
                                            nc.notes.removeAt(index);
                                            Get.back();
                                          },
                                          confirmTextColor: Colors.white,
                                        );
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

class SearchBar extends StatelessWidget {
  // final TextEditingController controller;
  // final VoidCallback onSearch;
  final NoteController nc = Get.put(NoteController());

  SearchBar({super.key});
  // SearchBar({required this.controller , required this.onSearch});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            prefixIcon: Icon(Icons.search,
              color: Colors.black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              maxWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey)
        ),
        // onChanged: (_) {
        //   onSearch();
        // },
        onChanged: (value) => nc.searchEle(value),
      ),
    );
  }
}

