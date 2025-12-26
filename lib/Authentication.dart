import 'User.dart';
class Authentication {
  List<User> users ;
  int User_Counter ;
  Authentication() 
  :users = [] , User_Counter = 0 ; 
  bool Exsit(String Code){
    for(int i = 0 ; i < User_Counter ; i++){
      if(users[i].national_code == Code){
        return true ;
      }
    }
    return false ;
  }
  void addUser(String name , String lastName , String Code){
    if(!Exsit(Code)){
      users.add(User(name , lastName , Code)) ;
      User_Counter++ ;
    }
  }
}