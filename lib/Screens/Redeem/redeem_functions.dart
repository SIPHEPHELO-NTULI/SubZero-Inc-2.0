import 'dart:math';

//This class generates a random amount for a user once a voucher code has been entered
class RedeemFunctions {
  String getAmount() {
    String amount;
    //This is a list of all the possible amounts the user can redeem using a code
    List possibleAmount = [
      '100',
      '150',
      '200',
      '250',
      '300',
      '350',
      '400',
      '450',
      '500',
      '550',
      '600',
      '650',
      '700',
      '750',
      '800',
      '850',
      '900',
      '950',
      '1000'
    ];
    Random random = Random();
    int randomNumber = random.nextInt(possibleAmount.length - 1);
    amount = possibleAmount[randomNumber];
    return amount;
  }
}
