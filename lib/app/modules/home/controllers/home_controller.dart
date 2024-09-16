import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task3/app/data/note.dart';
import 'package:task3/app/data/themeManager.dart';

class HomeController extends GetxController {
  RxList<Note> notes = RxList<Note>([]); //list of current notes
  Rx<TextEditingController> inputTitleController =
      TextEditingController().obs; //controller of note input
  Rx<TextEditingController> inputDetailsController =
      TextEditingController().obs;
  RxString text = RxString(''); //guiding text on the top of page
  var isDarkMode = false.obs;
  var icon = Icon(Icons.sunny).obs;

  final box = GetStorage();

  @override
  void onInit() {
    // load the notes when the controller is initialized
    loadNotes();
    storageInfo(); //for making sure everything is on track
    super.onInit();

    //notes.value = getNotes();
    //print(notes.isEmpty);
  }

  void storageInfo() {
    print('Stored notes: ${box.read('notes')}');
    print('Mode: ${ThemeManager().isSavedDarkMode()}');
  }

  void loadNotes() {
    //loading nodes in the shape of List<Dynamic> to load it correctly
    List<dynamic> storedNotes = box.read('notes') ?? [];
    List<Note> noteList =
        storedNotes.map((noteMap) => Note.fromMap(noteMap)).toList();
    notes.assignAll(
        noteList); // Assign the deserialized notes to the reactive list
  }

  void saveNotes(List<Note> notes) {
    // convert each note to a Map<String, dynamic> for proper storage locally
    List<Map<String, dynamic>> noteList =
        notes.map((note) => note.toMap()).toList();
    box.write('notes',
        noteList); // saving the list of maps to GetStorage (local storage)
  }

  void addNote(String title, String details) {
    if (title.isNotEmpty && details.isNotEmpty) {
      //both title and details should not be empty
      Note note = Note(title: title, details: details);
      notes.add(note);
      saveNotes(notes); //updating the notes in local memory
    }
  }

  void removeNote(int index) {
    //index is always in range (listview builer)
    notes.removeAt(index);
    saveNotes(notes); //updating the notes in local memory
  }

  void editNote(int index) {
    notes.removeAt(index);
    box.write('notes', notes); //updating the notes in local memory
  }

  String textCheck() {
    //guide text only when there's no notes
    if (notes.isEmpty) {
      return "Try adding some notes.";
    } else {
      return '';
    }
  }
}
/*
  

  
}*/
