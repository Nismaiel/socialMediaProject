class UserData {
  final String name;
  final String id;
  final String email;

  UserData({this.id, this.name, this.email});

  UserData.fromJson(Map<String, dynamic>parsed) :
        name=parsed['name'],
        id=parsed['id'],
        email=parsed['email'];

  Map<String,dynamic>toJson(){
    return{
      'name':name,
      'id':id,
      'email':email
    };
  }



}