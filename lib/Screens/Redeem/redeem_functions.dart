import 'dart:math';

class RedeemFunctions {
  String getAmount() {
    String amount;
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
