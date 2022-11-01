import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/create_user.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late CreateUser cf;
  late String name, surname, username, email, uid;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    name = "name";
    uid = "abc";
    surname = "surname";
    username = "username";
    email = "email@gmail.com";

    cf = CreateUser(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that the database acts when a new user creates an account
  test('Add New User', () async {
    when(mockFirestore.collection('Users').doc(uid).set({
      'name': name,
      'surname': surname,
      'username': username,
      'email': email,
      'uid': uid
    }));
    expect(await cf.createUser(name, surname, username, email, uid),
        "Account Created");
  });
}
