import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//for picking the image
import 'package:firebase_storage/firebase_storage.dart';
// for uploading the image to our firebase storage
import 'package:cloud_firestore/cloud_firestore.dart';
//saving the url of uploaded image to our application

class Image_Upload extends StatefulWidget {
  String? userid;

  Image_Upload({Key? key, this.userid}) : super(key: key);

  @override
  _Image_UploadState createState() => _Image_UploadState();
}

class _Image_UploadState extends State<Image_Upload> {
  final imagepicker = ImagePicker();
  File? _image;
  String? downlaodUrl;
  Future imagePickerMethod() async {
    final pick = await imagepicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnackBar('No File Selected', Duration(milliseconds: 400));
      }
    });
  }

  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(
      content: Text(snackText),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // uploading image on firebase, and adding that image url to firestore
  Future UploadImage() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final postId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${widget.userid}/images")
        .child('post_$postId');
    await ref.putFile(_image!);
    downlaodUrl = await ref.getDownloadURL();
    // Uploading image url to firestore
    await firebaseFirestore
        .collection("users")
        .doc(widget.userid)
        .collection("images")
        .add({"downloadUrl": downlaodUrl}).whenComplete(() =>
            showSnackBar("Image Uploaded Successfully", Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 110, 104, 134),
      appBar: AppBar(title: Text("Upload Image")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Column(children: [
                const Text(
                  'Uplaod Image',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _image == null
                              ? const Center(child: Text('No Image found'))
                              : Image.file(_image!),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              imagePickerMethod();
                            },
                            child: Text(' Select Image')),
                        ElevatedButton(
                            onPressed: () {
                              //upload only when image has some values
                              if (_image != null) {
                                UploadImage();
                              } else {
                                showSnackBar("Select Image first",
                                    Duration(milliseconds: 100));
                              }
                            },
                            child: Text(' Upload Image')),
                      ],
                    ),
                  ),
                ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
