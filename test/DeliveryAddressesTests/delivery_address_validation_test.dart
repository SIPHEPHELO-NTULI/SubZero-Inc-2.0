import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/DeliveryAddress/Validation/city_validator.dart';
import 'package:give_a_little_sdp/Screens/DeliveryAddress/Validation/complex_name_validator.dart';
import 'package:give_a_little_sdp/Screens/DeliveryAddress/Validation/phone_number_validator.dart';
import 'package:give_a_little_sdp/Screens/DeliveryAddress/Validation/province_validator.dart';
import 'package:give_a_little_sdp/Screens/DeliveryAddress/Validation/recipient_name_validator.dart';
import 'package:give_a_little_sdp/Screens/DeliveryAddress/Validation/street_address_validator.dart';
import 'package:give_a_little_sdp/Screens/DeliveryAddress/Validation/suburb_validator.dart';

void main() {
//UNIT TEST
//this test will check that recipient name field validator correctly validates an empty recipient name
  test('empty name returns error string', () async {
    var result = RecipientNameValidator.validate('');
    expect(result, "Recipient Name Missing");
  });

//UNIT TEST
//this test will check that recipient name field validator correctly validates a correct recipient name
  test('valid name returns null', () async {
    var result = RecipientNameValidator.validate('Kay');
    expect(result, null);
  });

//UNIT TEST
//this test will check that city field validator correctly validates an empty city
  test('empty city returns error string', () async {
    var result = CityValidator.validate('');
    expect(result, "City Missing");
  });

//UNIT TEST
//this test will check that city field validator correctly validates a correct city name
  test('valid city returns null', () async {
    var result = CityValidator.validate('Johannesburg');
    expect(result, null);
  });

//UNIT TEST
//this test will check that complex name field validator correctly validates an empty complex name
  test('empty complex name returns error string', () async {
    var result = ComplexNameValidator.validate('');
    expect(result, "Complex Name Missing");
  });

//UNIT TEST
//this test will check that complex name field validator correctly validates a correct complex name
  test('valid complex name returns null', () async {
    var result = ComplexNameValidator.validate('Hills Complex');
    expect(result, null);
  });

//UNIT TEST
//this test will check that province field validator correctly validates an empty province
  test('empty province returns error string', () async {
    var result = ProvinceValidator.validate('');
    expect(result, "Province Missing");
  });

//UNIT TEST
//this test will check that province field validator correctly validates a correct province name
  test('valid province name returns null', () async {
    var result = ProvinceValidator.validate('Gauteng');
    expect(result, null);
  });

//UNIT TEST
//this test will check that street field validator correctly validates an empty street address
  test('empty street name returns error string', () async {
    var result = StreetAddressValidator.validate('');
    expect(result, "Street Address Missing");
  });

//UNIT TEST
//this test will check that street field validator correctly validates a correct street name
  test('valid street name returns null', () async {
    var result = StreetAddressValidator.validate('123 St');
    expect(result, null);
  });

//UNIT TEST
//this test will check that suburb field validator correctly validates an empty suburb
  test('empty Suburb name returns error string', () async {
    var result = SuburbValidator.validate('');
    expect(result, "Suburb Missing");
  });

//UNIT TEST
//this test will check that suburb field validator correctly validates a correct suburb name
  test('valid suburb name returns null', () async {
    var result = SuburbValidator.validate('Sandton');
    expect(result, null);
  });

//UNIT TEST
//this test will check that phone number validator correctly validates an empty phone number
  test('empty phone number returns error string', () async {
    var result = PhoneNumberValidator.validate('');
    expect(result, "Phone Number Missing");
  });

  //UNIT TEST
//this test will check that phone number validator correctly validates a phone number with non numeric characters
  test('invalid phone number returns error string', () async {
    var result = PhoneNumberValidator.validate('adw');
    expect(result, "Phone number must contain numeric values only");
  });

//UNIT TEST
//this test will check that phone number field validator correctly validates a correct phone number
  test('valid phone number returns null', () async {
    var result = PhoneNumberValidator.validate('1234567890');
    expect(result, null);
  });
}
