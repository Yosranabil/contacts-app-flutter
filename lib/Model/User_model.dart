import '../Helper/constants.dart';

class ContactModel{
  int ? id ;
  String ? name,phone,email;

  ContactModel({this.id,required this.name,required this.phone,required this.email});
  toMap()
  {
    return{
      "$columnName":name,
      "$columnNumber":phone,
      "$columnMail":email,
    };
  }


  factory ContactModel.fromMap(Map<String,dynamic>map)
  {
    return ContactModel(
      name:map[columnName],
      phone:map[columnNumber],
      email: map[columnMail],
      id: map[columnId],
    );
  }


}