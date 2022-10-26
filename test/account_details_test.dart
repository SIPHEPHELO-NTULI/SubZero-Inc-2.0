import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/account_details_functions.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import 'auth_test.dart';

void main() {
  //UNIT TEST
  //unit Test to check that the users details are retrieved and returned
  test('get User Account Details', () async {
    String uid = "abc";
    String collectionPath = 'Users';
    final FakeFirebaseFirestore mockFirestore = FakeFirebaseFirestore();
    final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    final AccountDetails ad =
        AccountDetails(fire: mockFirestore, auth: mockFirebaseAuth);

    final DocumentReference<Map<String, dynamic>> documentReference =
        mockFirestore.collection(collectionPath).doc(uid);

    await documentReference.set({
      "name": "name",
      uid: "abc",
      "surname": "surname",
      "username": "username",
      "email": "email@gmail.com"
    });
    final DocumentSnapshot<Map<String, dynamic>> expectedDocumentSnapshot =
        await documentReference.get();
    final DocumentSnapshot<Map<String, dynamic>> actualDocumentSnapshot =
        await ad.getUserAccountDetails(uid);
    final Map<String, dynamic>? expectedData = expectedDocumentSnapshot.data();
    final Map<String, dynamic>? actualData = actualDocumentSnapshot.data();
    expect(actualData, expectedData);
  });

  //UNIT TEST
  //unit Test to check that the users name is retrieved and returned
  test('get User First Name ', () async {
    String uid = "abc";
    String collectionPath = 'Users';
    final FakeFirebaseFirestore mockFirestore = FakeFirebaseFirestore();
    final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    final AccountDetails ad =
        AccountDetails(fire: mockFirestore, auth: mockFirebaseAuth);

    final DocumentReference<Map<String, dynamic>> documentReference =
        mockFirestore.collection(collectionPath).doc(uid);

    await documentReference.set({
      "name": "John",
      uid: "abc",
      "surname": "surname",
      "username": "username",
      "email": "email@gmail.com"
    });
    final DocumentSnapshot<Map<String, dynamic>> expectedDocumentSnapshot =
        await documentReference.get();
    final Map<String, dynamic>? expectedData = expectedDocumentSnapshot.data();
    String expectedName = expectedData?['name'];
    String actualName = await ad.getUserName(uid);
    expect(actualName, expectedName);
  });

//UNIT TEST
  //unit Test to check that the appropriate profile imageURL is retrieved and returned for a user who hasnt set one
  test('Get Profile Image For user who does not have one ', () async {
    String uid = "abc";
    final FakeFirebaseFirestore mockFirestore = FakeFirebaseFirestore();
    final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    final AccountDetails ad =
        AccountDetails(fire: mockFirestore, auth: mockFirebaseAuth);
    String expectedURL =
        "https://firebasestorage.googleapis.com/v0/b/flutterwebdemo-75af3.appspot.com/o/GiveALittle%2FaccountLogo.png?alt=media&token=b6b50463-becf-4c88-9463-7bf021c106b1";
    String actualURL = await ad.getUserAccountImage(uid);
    expect(actualURL, expectedURL);
  });

  //UNIT TEST
  //unit Test to check that the appropriate profile imageURL is retrieved and returned for a user who has set one
  test('Get Profile Image For user who has one ', () async {
    String uid = "abc";
    String collectionPath = 'Users';
    final FakeFirebaseFirestore mockFirestore = FakeFirebaseFirestore();
    final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    final AccountDetails ad =
        AccountDetails(fire: mockFirestore, auth: mockFirebaseAuth);

    final DocumentReference<Map<String, dynamic>> documentReference =
        mockFirestore.collection(collectionPath).doc(uid);

    await documentReference.set({
      "name": "John",
      uid: "abc",
      "surname": "surname",
      "username": "username",
      "email": "email@gmail.com",
      "profilePicture": "profilePicture"
    });
    final DocumentSnapshot<Map<String, dynamic>> expectedDocumentSnapshot =
        await documentReference.get();
    final Map<String, dynamic>? expectedData = expectedDocumentSnapshot.data();

    String expectedimageURL = expectedData?['profilePicture'];
    String actualImageURL = await ad.getUserAccountImage(uid);
    expect(actualImageURL, expectedimageURL);
  });

  //UNIT TEST
  //unit Test to check that the function sends and updates the relevant details, given that the email hasnt been changed
  test('Send Updated Details With Same Email', () async {
    String uid = "abc";
    String collectionPath = 'Users';
    final FakeFirebaseFirestore mockFirestore = FakeFirebaseFirestore();
    final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    final AccountDetails ad =
        AccountDetails(fire: mockFirestore, auth: mockFirebaseAuth);

    final DocumentReference<Map<String, dynamic>> documentReference =
        mockFirestore.collection(collectionPath).doc(uid);
    await documentReference.set({
      "name": "John",
      uid: "abc",
      "surname": "surname",
      "username": "username",
      "email": "email@gmail.com",
      "profilePicture": "profilePicture"
    });

    String actualImageURL = await ad.sendUpdatedDetails("sdf/asd/", "John",
        "surname", "username23", "email@gmail.com", "email@gmail.com", uid);
    expect(actualImageURL, "Details Updated");
  });
  //UNIT TEST
  //unit Test to check that the function sends and updates the relevant details, given that the email has been changed
  test('Send Updated Details With Different Email', () async {
    String uid = "abc";
    String collectionPath = 'Users';
    final FakeFirebaseFirestore mockFirestore = FakeFirebaseFirestore();
    final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    final AccountDetails ad =
        AccountDetails(fire: mockFirestore, auth: mockFirebaseAuth);

    final DocumentReference<Map<String, dynamic>> documentReference =
        mockFirestore.collection(collectionPath).doc(uid);
    await documentReference.set({
      "name": "John",
      uid: "abc",
      "surname": "surname",
      "username": "username",
      "email": "email@gmail.com",
      "profilePicture": "profilePicture"
    });

    String actualImageURL = await ad.sendUpdatedDetails("sdf/asd/", "John",
        "surname", "username", "email@gmail.com", "email2@gmail.com", uid);
    expect(actualImageURL, "Details Updated");
  });
}
