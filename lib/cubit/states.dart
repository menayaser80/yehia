
abstract class NewsStates{}
class SocialInitialState extends NewsStates{}
class SocialGetUserLoadingState extends NewsStates{}
class SocialGetUserSuccessState extends NewsStates{}
class SocialGetUserErrorState extends NewsStates{
  final String error;
  SocialGetUserErrorState(this.error);
}
class SocialUserUpdateLoadingState extends NewsStates{}
class SocialProfileImagePickedSuccessState extends NewsStates{}
class SocialProfileImagePickedErrorState extends NewsStates{}
class SocialcoverimagePickedSuccessState extends NewsStates{}
class SocialcoverimagePickedErrorState extends NewsStates{}

class SocialuploadimageErrorState extends NewsStates{}
class SocialUserUpdateErrorState extends NewsStates{}
class SocialuploadcoverimageErrorState extends NewsStates{}
class AppChangeDarkState extends NewsStates{}
class AppChangeBottomState extends NewsStates{}
class SocialUserUpdateSuccessState extends NewsStates{}

