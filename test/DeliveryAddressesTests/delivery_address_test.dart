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
    when(await mockFirestore.collection("DeliveryAddress").doc().set({
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
//this test will check that the database retrieves the relevant delivery address for the specified user when they have not added one
  test('Get Delivery Addresses expect empty list', () async {
    expect(await da.getDeliveryAddress(uid), []);
  });

  //UNIT TEST
//this test will check that the database retrieves the relevant delivery address for the specified user when they have not added one
  test('Get Delivery Addresses expect list of addresses', () async {
    await mockFirestore.collection("DeliveryAddress").doc().set({
      'recipientname': recipientname,
      'mobilenumber': mobilenumber,
      'complexname': complexname,
      'streetaddress': streetaddress,
      'suburb': suburbname,
      'province': province,
      'city': city,
      'uid': uid,
      'docID': docID
    });
    await mockFirestore.collection("DeliveryAddress").doc().set({
      'recipientname': recipientname,
      'mobilenumber': mobilenumber,
      'complexname': complexname,
      'streetaddress': streetaddress,
      'suburb': suburbname,
      'province': province,
      'city': city,
      'uid': uid,
      'docID': "docID3"
    });
    final List<dynamic> dataList = (await da.getDeliveryAddress(uid));
    expect(dataList, [
      {
        'recipientname': recipientname,
        'mobilenumber': mobilenumber,
        'complexname': complexname,
        'streetaddress': streetaddress,
        'suburb': suburbname,
        'province': province,
        'city': city,
        'uid': uid,
        'docID': docID
      },
      {
        'recipientname': recipientname,
        'mobilenumber': mobilenumber,
        'complexname': complexname,
        'streetaddress': streetaddress,
        'suburb': suburbname,
        'province': province,
        'city': city,
        'uid': uid,
        'docID': "docID3"
      }
    ]);
  });

//UNIT TEST
//this test will check that the database deletes a  delivery address given the specified docID
  test('Delete Delivery Address', () async {
    await mockFirestore.collection("DeliveryAddress").doc().set({
      'recipientname': recipientname,
      'mobilenumber': mobilenumber,
      'complexname': complexname,
      'streetaddress': streetaddress,
      'suburb': suburbname,
      'province': province,
      'city': city,
      'uid': uid,
      'docID': docID
    });
    expect(await da.deleteAddress(docID), "Addresss Deleted");
  });
}
