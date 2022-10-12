import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/check_product.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late CheckProduct cf;
  late String productID, uid;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    productID = "productID";
    uid = "abc";

    cf = CheckProduct(fire: mockFirestore);
  });
  test('Check Product', () async {
    when(mockFirestore.collection("PurchaseHistory2").get());
    expect(await cf.check(productID, uid), false);
  });
}
