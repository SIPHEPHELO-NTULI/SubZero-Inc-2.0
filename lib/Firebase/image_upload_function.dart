import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class Uploadmage {
  FirebaseStorage storage;

  Uploadmage({required this.storage});
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
