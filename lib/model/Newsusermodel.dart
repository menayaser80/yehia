class NewsUserModel
{
  String? name;
  String? email;
  String? phone;
  String? shopping_address;
  String? id;
  String? image;
  String? bio;
  String? cover;
  bool? isEmailVerified;
  NewsUserModel({
    this.name,
    this.email,
    this.shopping_address,
    this.phone,
    this.image,
    this.bio,
    this.cover,
    this.id,
    this.isEmailVerified,
  });
  NewsUserModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    shopping_address=json['shopping_address'];
    id=json['id'];
    image=json['image'];
    bio=json['bio'];
    cover=json['cover'];
    isEmailVerified=json['isEmailVerified'];
  }
  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'email':email,
      'shopping_address':shopping_address,
      'phone':phone,
      'id':id,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}