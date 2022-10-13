import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/auth_service.dart';
import 'package:mockito/mockito.dart';

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseUser extends Mock implements User {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String? email,
    required String? password,
  }) =>
      super.noSuchMethod(
          Invocation.method(#signInWithEmailAndPassword, [email, password]),
          returnValue: Future.value(MockUserCredential()));

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String? email,
    required String? password,
  }) =>
      super.noSuchMethod(
          Invocation.method(#createUserWithEmailAndPassword, [email, password]),
          returnValue: Future.value(MockUserCredential()));

  @override
  Future<String> signOut() =>
      super.noSuchMethod(Invocation.method(#signOut, []),
          returnValue: Future.value("Success"));
}

void main() {
  late MockFirebaseAuth mockAuth;
  late MockUserCredential mockCredential;
  late AuthService auth;
  late MockFirebaseUser mockUser;
  setUp(() {
    mockAuth = MockFirebaseAuth();
    auth = AuthService(auth: mockAuth);
    mockUser = MockFirebaseUser();
    mockCredential = MockUserCredential();
    when(mockCredential.user).thenReturn(mockUser); // IMPORTANT
  });

//UNIT TEST
//this test will check that the database acts accordingly to an existing user signing in
  test("Testing User Login Function", () async {
    when(mockAuth.signInWithEmailAndPassword(email: any, password: any))
        .thenAnswer((_) async => mockCredential);
    final result = await auth.signIn("123@gmail.com", "123456");
    expect(result, "Success");
    verify(mockAuth.signInWithEmailAndPassword(
        email: "123@gmail.com", password: "123456"));
  });

//UNIT TEST
//this test will check that the database acts accordingly to a new user signing up
  test("Testing User Creation Function", () async {
    when(mockAuth.createUserWithEmailAndPassword(
            email: "jack@gmail.com", password: "12345678"))
        .thenAnswer((_) async => mockCredential);
    final result = await auth.signUp("jack@gmail.com", "12345678");
    expect(result, "Account Created");
    verify(mockAuth.createUserWithEmailAndPassword(
        email: "jack@gmail.com", password: "12345678"));
  });

//UNIT TEST
//this test will check that the database acts accordingly to an existing user signing out
  test("Testing Sign Out", () async {
    when(mockAuth.signOut()).thenAnswer((_) async => Future.value("Success"));
    final result = await auth.signOut();
    expect(result, "Success");
    verify(mockAuth.signOut());
  });
}
