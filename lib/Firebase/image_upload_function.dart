import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

//This class houses the necessary firebase functions related to uploading an image
//It takes in a required parameter that is instances of firebase, FirebaseStorage.instance

class Uploadmage {
  FirebaseStorage storage;

  Uploadmage({required this.storage});

  //This function uploads an image to the relevant folder in the firebase storage
  //both the upload product image and upload account profile image will make use of
  //the downloadURL returned from this function
  //it taken in the selected file as a Uint8List variable and
  //uses the specified path to store in firebase storage

  Future uploadImage(Uint8List imagefile, String uid, String path) async {
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = storage.ref().child(path).child("post_$postID");
    await ref.putData(
        imagefile,
        SettableMetadata(
          cacheControl: "public,max-age=300",
          contentType: "image/jpeg",
        ));

    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }
}
