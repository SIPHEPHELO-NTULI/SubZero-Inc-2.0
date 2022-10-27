import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:give_a_little_sdp/Encryption/encryption.dart';
import 'package:give_a_little_sdp/Models/user_model.dart';

//This class houses the necessary firebase functions related to the account details of the user
//It takes in required parameters that are instances of FirebaseAuth.instance or FirebaseFirestore.instance
//in the case of testing it will take (MockFirebaseAuth.instance or MockFirebaseFirestore.instance)

class AccountDetails {
  final FirebaseFirestore fire;
  final FirebaseAuth auth;

  AccountDetails({required this.fire, required this.auth});

  //This function retrieved the current users details by using their uid and returns a snapshot of the document

  Future getUserAccountDetails(String uid) async {
    DocumentSnapshot doc = await fire.collection("Users").doc(uid).get();
    return doc;
  }

  //This function retrieved the current users name by using their uid and calling the above 'getUserDetails' and returns a string
  //It uses the userModel class (fromMap function) to map the data from the document to retrieve the relevant name field
  //This is used to display the users name in the appBar

  Future<String> getUserName(String uid) async {
    String name = "";
    UserModel userModel;
    await getUserAccountDetails(uid).then((value) => {
          userModel = UserModel.fromMap(value.data()),
          name = userModel.name.toString()
        });
    return name;
  }

  //This function retrieved the current users profile picture by using their uid and returns a string containing the imageURL
  //If the user has not chosen an image, the default image is returned which is stored in firebase storage
  //This is used to display the users profile image in the appBar

  Future<String> getUserAccountImage(String uid) async {
    var collection = fire.collection("Users");
    String imageURL;
    var docSnapshot = await collection.doc(uid).get();
    Map<String, dynamic>? data = docSnapshot.data();

    if (data?['profilePicture'] == null) {
      imageURL =
          "https://firebasestorage.googleapis.com/v0/b/flutterwebdemo-75af3.appspot.com/o/GiveALittle%2FaccountLogo.png?alt=media&token=b6b50463-becf-4c88-9463-7bf021c106b1";
    } else {
      imageURL = data?['profilePicture'];
    }
    return imageURL;
  }

//This function is used to send the updated details to firebase
//If the user has not updated their email, that specific function will not be called
//if they have updated the email, the update is handled by firebase
//should the details be updated successfully, the relevant message will be displayed

  Future<String> sendUpdatedDetails(
      String downloadURL,
      String name,
      String surname,
      String username,
      String oldemail,
      String email,
      String uid) async {
    String newEmail = Encryption().getEncryptedEmail(email);
    await fire.collection('Users').doc(uid).set({
      'name': name,
      'surname': surname,
      'username': username,
      'email': newEmail,
      'uid': uid,
      'profilePicture': downloadURL
    });
    if (oldemail != newEmail) {
      try {
        await auth.currentUser?.updateEmail(email);
        return "Details Updated";
      } on FirebaseAuthException catch (e) {
        return e.message.toString();
      }
    } else {
      return "Details Updated";
    }
  }
}
