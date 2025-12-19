import 'User.dart';
import 'Groups.dart';
class FastAccess {
  late List<User?> users ;
  late List<Groups?> groups ;
  FastAccess(){
    users = List<User?>.filled(100 , null) ;
    groups = List<Groups?>.filled(100 , null) ;
  }
}