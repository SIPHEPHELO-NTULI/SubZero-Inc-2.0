//this class hold the users registration details
// this makes it easier to track individual details of the user
class UserModel {
  String? name;
  String? surname;
  String? username;

  UserModel({this.name, this.surname, this.username});

  //get data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      name: map['name'],
      surname: map['surname'],
      username: map['username'],
    );
  }
}
