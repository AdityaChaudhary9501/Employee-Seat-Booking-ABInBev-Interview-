import 'dart:io';

import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ab_inbev/widget/button_widget.dart';
import 'package:ab_inbev/providers/firebase_api.dart';

class vaccinationscreen extends StatefulWidget {
  const vaccinationscreen({Key? key}) : super(key: key);

  @override
  State<vaccinationscreen> createState() => _vaccinationscreenState();
}

class _vaccinationscreenState extends State<vaccinationscreen> {
  UploadTask? task;
  File? file;
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Vaccination Status'),
      ),

      body: Center(

          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Upload your vaccination certificate'),
              ButtonWidget(
                text: 'Select File',
                icon: Icons.attach_file,
                onClicked: selectFile,
              ),
              SizedBox(height: 8),
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48),
              ButtonWidget(
                text: 'Upload File',
                icon: Icons.cloud_upload_outlined,
                onClicked: uploadFile,
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
            ],
          )
      ),
    );
  }


Future selectFile() async {
  final result = await FilePicker.platform.pickFiles(allowMultiple: false);

  if (result == null) return;
  final path = result.files.single.path!;

  setState(() => file = File(path));
}

Future uploadFile() async {
  if (file == null) return;

  final fileName = basename(file!.path);
  final destination = 'files/$fileName';

  task = FirebaseApi.uploadFile(destination, file!);
  setState(() {});

  if (task == null) return;

  final snapshot = await task!.whenComplete(() {});
  final urlDownload = await snapshot.ref.getDownloadURL();

  print('Download-Link: $urlDownload');
}

Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
  stream: task.snapshotEvents,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final snap = snapshot.data!;
      final progress = snap.bytesTransferred / snap.totalBytes;
      final percentage = (progress * 100).toStringAsFixed(2);

      return Text(
        '$percentage %',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else {
      return Container();
    }
  },
);
}
