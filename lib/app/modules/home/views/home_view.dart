import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task3/app/data/themeManager.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //initialize the correct icon of mode switch button
    controller.icon.value = Theme.of(context).brightness == Brightness.dark
        ? Icon(Icons.nightlight)
        : Icon(Icons.sunny);
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).primaryColor,
        title: const Text('NOTE MANAGER'),
        actions: [
          const Text('Mode'),
          Obx(() => IconButton(
                //observable object for toggle value
                icon: controller.icon.value, //icon variable
                onPressed: () {
                  controller.icon
                          .value = //get if app is dark mode based on brightness
                      Theme.of(context).brightness == Brightness.dark
                          ? const Icon(Icons.sunny)
                          : const Icon(Icons.nightlight);
                  ThemeManager()
                      .changeTheme(); //change theme and store it in local storage using a theme manager
                },
              ))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          //show guiding text when the list is empty
          Padding(
              padding: const EdgeInsets.all(8),
              child: Obx(() => Text(controller.textCheck()))),

          //adding notes section
          AddNote(controller: controller),

          //a responsive space between sections
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),

          //viewing notes
          NoteTile(controller: controller),
        ],
      ),
    );
  }
}

class AddNote extends StatelessWidget {
  const AddNote({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            //first textField is for title
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: TextField(
              controller: controller.inputTitleController.value,
              decoration: const InputDecoration(hintText: "Add a note title.."),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                //second textField is for content
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: TextField(
                  controller: controller.inputDetailsController.value,
                  decoration: const InputDecoration(hintText: "Details..."),
                )),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.2,
              child: IconButton(
                icon: const Icon(Icons.add), //add ot update icon button
                onPressed: () {
                  controller.addNote(controller.inputTitleController.value.text,
                      controller.inputDetailsController.value.text);
                  controller.inputTitleController.value.text =
                      ''; //empty text field when task is added
                  controller.inputDetailsController.value.text = '';
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.controller,
  });

  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        //interactive list updating when a task is added or deleted
        return ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              //for a note to expand when pressed on
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.notes[index].title),
                  Row(
                    children: [
                      IconButton(
                          //delete icon
                          onPressed: () {
                            controller.removeNote(index);
                          },
                          icon: const Icon(Icons.delete)),
                      IconButton(
                          //edit icon
                          onPressed: () {
                            controller.inputTitleController.value.text =
                                controller.notes[index].title;
                            controller.inputDetailsController.value.text =
                                controller.notes[index].details;
                            controller.editNote(index);
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  )
                ],
              ),
              children: [
                Text(controller.notes[index].details)
              ], //shows content of a note when expanded
            );
          },
        );
      }),
    );
  }
}
