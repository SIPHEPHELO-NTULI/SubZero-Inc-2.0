import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/credit_functions.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String balance;
  late String uid;
  late String sign;
  late CreditFunctions cf;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    uid = "abc";
    balance = "120";
    sign = "+";
    cf = CreditFunctions(fire: mockFirestore);
  });
  test('Update Credit Balance', () async {
    when(mockFirestore.collection('Credits').doc(uid).set({"balance": 200}));
    expect(await cf.updateCredits(uid, balance, sign), "Balance Updated!");
  });

  test('Get Current Balance', () async {
    when(mockFirestore.collection("Credits").doc(uid).get());
    expect(await cf.getCurrentBalance(uid), "0");
  });
}
