import 'User.dart';
class ShowDetails {
  User user ;
  double balance ;
  ShowDetails(this.user , this.balance) ;
  void Show(){
    print("Welcome Dear ${user.name} ${user.last_name} to our bank") ;
    print("Your Balance is : $balance") ;
  }
}