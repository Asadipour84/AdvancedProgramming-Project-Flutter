import 'Account_Icon.dart';
class DetailsOfAccount {
  Account account ;
  DetailsOfAccount(this.account) ;
  void show_details(){
    print("Your Information is :") ;
    print("Card Number : ") ;
    print(account.Card_Number) ;
    print("Your Account Number : ") ;
    print(account.Account_Number) ;
    print("Your Balance is : ") ;
    print(account.Balance) ;
  }
}