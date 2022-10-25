import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/delivery_address_functions.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String recipientname;
  late String mobilenumber;
  late String complexname;
  late String streetaddress;
  late String suburbname;
  late String province;
  late String city;
  late String docID;
  late String uid;
  late DeliveryAdressFunctions da;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    uid = "abc";
    recipientname = "Ben";
    mobilenumber = "1234567890";
    complexname = "Hills Complex";
    streetaddress = "123 Hill St";
    suburbname = "Sandton";
    province = "Gauteng";
    city = "Johannesburg";
    docID = "asdj12391n";
    da = DeliveryAdressFunctions(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that the database adds a new delivery address for a signed in user
  test('Add Delivery Address', () async {
    when(mockFirestore.collection("DeliveryAddress").doc().set({
      'recipientname': recipientname,
      'mobilenumber': mobilenumber,
      'complexname': complexname,
      'streetaddress': streetaddress,
      'suburb': suburbname,
      'province': province,
      'city': city,
      'uid': uid,
      'docID': docID
    }));
    expect(
        await da.addDeliveryAdress(recipientname, mobilenumber, complexname,
            streetaddress, suburbname, province, city, uid),
        "Address added");
  });

//UNIT TEST
//this test will check that the database retrieves the relevant delivery address for the specified user
  test('Get Delivery Addresses', () async {
    when(mockFirestore.collection("DeliveryAddress").doc().get());
    expect(await da.getDeliveryAddress(uid), []);
  });

//UNIT TEST
//this test will check that the database deletes a  delivery address given the specified docID
  test('Delete Delivery Address', () async {
    when(mockFirestore.collection("DeliveryAddress").doc().delete());
    expect(await da.deleteAddress(docID), "Addresss Deleted");
  });
}
