import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/send_comments.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String productID;
  late String uid;
  late String text;
  late SendComment cf;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    uid = "abc";
    productID = "1232jk3h";
    text = "Good Buy";
    cf = SendComment(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that the database acts accordingly when a user reviews a product
  test('Upload Comment', () async {
    when(mockFirestore
        .collection('Products')
        .doc(productID)
        .collection('Reviews')
        .doc(uid)
        .set({
      'productID': productID,
      'name': "name",
      'uid': uid,
      'comment': text,
      'date': "date"
    }));
    expect(await cf.uploadComment(productID, text, uid), "Comment Posted");
  });
}
