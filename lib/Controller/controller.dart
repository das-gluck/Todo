import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../Model/model.dart';


class NoteController extends GetxController{
  var notes = <Note>[].obs;
  var found = <Note>[].obs;
  var result = <Note>[].obs;


  @override
  void onInit() {
    List? storedNotes = GetStorage().read('notes');
    if(storedNotes != null){
      notes = storedNotes.map((e) => Note.fromJson(e)).toList().obs;
      //found = storedNotes.map((e) => Note.fromJson(e)).toList().obs;
    }
    ever(notes, (_){
      GetStorage().write('notes', notes.toList());
    });

    found = notes;
    print(notes.length);
    super.onInit();

  }

  void add(Note n){
    notes.add(n);
  }

  void searchEle(String value){

    if(value.isEmpty){
      found = notes;
    }else {
      found.assignAll(
        notes.where((note) =>
        note.title?.toLowerCase()
            .contains(value.toLowerCase()) ?? false)
            .toList(),
      );
      // found = notes.where((note) =>
      // note.title?.toLowerCase()
      //     .contains(value.toLowerCase()) ?? false)
      //     .toList().obs;
    }
    found = notes;
  }



}