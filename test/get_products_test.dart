import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/get_products.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late FireStoreDataBase fireStoreDataBase;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    fireStoreDataBase = FireStoreDataBase(fire: mockFirestore);
  });
  test('Get Products', () async {
    when(mockFirestore.collection("Products").get());
    expect(await fireStoreDataBase.getData(), []);
  });
}
