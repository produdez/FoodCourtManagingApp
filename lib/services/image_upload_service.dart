import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
/*
This is the service that help to:
-Pick image from device
-Upload that image to cloud
-Save the cloud image's url on upload
 */
class ImageUploadService {
  StorageUploadTask uploadTask;
  final CollectionReference dishDB = Firestore.instance.collection("imageDB");
  Future<File> getImageFromImagePicker() async { //picking an image from the gallery
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print('Image Path $image');
    return image;
  }
  Future<String> uploadPic(File image, DocumentReference docRef) async { //upload the currently held image to the cloud
    //the image would be chose from imagePicker, other wise the image file is empty and will not upload
    String id = docRef.documentID;
    if(image == null) return null;
    String fileName = basename(id);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageTaskSnapshot uploadTask = await firebaseStorageRef.putFile(image).onComplete;
     String imageURL = (await uploadTask.ref.getDownloadURL()).toString();
     docRef.updateData({
       "imageURL" : imageURL,
     });
     return imageURL;
  }

  Future<String> getURL(String nameID) async { //get the url of a image on storage from it's name
    //this function works but, the result when url is not found is unexpected
    StorageReference imageStorageReference =
        FirebaseStorage.instance.ref().child(nameID);
    String imageURL = (await imageStorageReference.getDownloadURL()).toString();
    return imageURL;
  }

  Future<Widget> getImageFromCloud(BuildContext context, String imageName) async { // Get the image widget from it's name on the cloud
    //currently, the image is an URL, which is slow and get reset when scrolling (not very good)
    //TODO: maybe find a way to get a file from the storage so that the dish can keep that data offline and not refresh (stream?)
    Image m;
    await loadImage(imageName).then((downloadUrl) async {
      m = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.fill,
        key: ValueKey(downloadUrl.toString())
      );
    });
    return m;
  }

  Future<dynamic> loadImage( String imageName) async { //load image info from cloud
    return await FirebaseStorage.instance.ref().child(imageName).getDownloadURL();
  }

  Future removeImageFromStorage(String imageName) async {
    var imageRef = FirebaseStorage.instance.ref().child(imageName);
    return await imageRef.delete();
  }


}
