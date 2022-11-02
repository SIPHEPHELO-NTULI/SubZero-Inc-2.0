import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/credit_functions.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String amount;
  late String uid;
  late String sign;
  late CreditFunctions cf;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    uid = "abc";
    amount = "20";
    cf = CreditFunctions(fire: mockFirestore);
  });

  //UNIT TEST
//this test will check that the database acts accordingly when an existing user's credit balance changes
  test('Update Credit Balance By Increasing The Balance', () async {
    await mockFirestore.collection("Credits").doc(uid).set({"balance": 100});
    expect(await cf.updateCredits(uid, amount, "+"), "Balance Updated!");
  });

  //UNIT TEST
//this test will check that the database acts accordingly when an existing user's credit balance changes
  test('Update Credit Balance By Decreasing The Balance', () async {
    await mockFirestore.collection("Credits").doc(uid).set({"balance": 100});
    expect(await cf.updateCredits(uid, amount, "-"), "Balance Updated!");
  });

  //UNIT TEST
//this test will check that the database acts accordingly in retrieving an existing user's credit balance
  test('Get Current Balance When It exists', () async {
    await mockFirestore.collection("Credits").doc(uid).set({"balance": 100});
    expect(await cf.getCurrentBalance(uid), "100");
  });

  //UNIT TEST
//this test will check that the database acts accordingly in retrieving an existing user's credit balance
  test('Get Current Balance When It does not exist', () async {
    expect(await cf.getCurrentBalance(uid), "0");
  });
}
