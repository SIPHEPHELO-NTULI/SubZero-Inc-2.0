import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:give_a_little_sdp/Firebase/voucher_code_functions.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String code;
  late VoucherCodeFunctions vc;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    code = "abcdefghijkl";
    vc = VoucherCodeFunctions(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that database acts accordingly when a valid voucher code is sent to the database
  test('valid voucher code sent to firebase collection', () async {
    expect(await vc.sendVoucherCode(code), "Success");
  });

//UNIT TEST
//this test will check that database acts accordingly when a user tries to redeem an already redeemed voucher code
  test('validate code returns false', () async {
    mockFirestore.collection("VoucherCodes").add({"vouchercode": code});
    expect(await vc.checkCode(code), false);
  });

//UNIT TEST
//this test will check that database acts accordingly when a user tries to redeem a new voucher code
  test('validate code returns false', () async {
    mockFirestore
        .collection("VoucherCodes")
        .add({"vouchercode": "1234567abder"});
    expect(await vc.checkCode(code), true);
  });
}
