import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:todo/Model/model.dart';
import 'package:todo/Controller/controller.dart';



class MyNote extends StatelessWidget {

  int? index ;
  MyNote({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    final NoteController nc = Get.find();
    String text = "";
    text = index == null ? " " : nc.notes[index!].title!;
    TextEditingController textEditingController = TextEditingController(text: text);
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: index == null ? const Text("create a New Note") : Text("Update note"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                        controller: textEditingController,
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'create a new note!!',
                          labelText: 'My Note',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                        style: TextStyle(fontSize: 20),
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                      ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            Get.back();
                          },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                          child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          if(index == null ){
                            nc.notes.add(Note(title: textEditingController.text));
                          }else{
                            var updateNote = nc.notes[index!];
                            updateNote.title = textEditingController.text;
                            nc.notes[index!] = updateNote;
                          }

                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: index == null ? const Text("Add") : const Text("Update"),
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
}
