import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/auth_service.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final AuthService auth = AuthService();

  setUp(() {});
  tearDown(() {});

//need to get UserCredentials First
  /*  test("sign up", () async {
    when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: "123@gmail.com", password: "123456"));
    expect(await auth.signUp("123@gmail.com", "123456"), "Account Created");
  }); */
}
