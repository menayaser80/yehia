import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yehia/constants/global%20method.dart';
import 'package:yehia/cubit/bloc.dart';
import 'package:yehia/cubit/states.dart';
class EditProfile extends StatelessWidget {
  var namecontroller=TextEditingController();
  var biocontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  var titlecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){
        if(state is SocialUserUpdateSuccessState)
          {
            Fluttertoast.showToast(
              msg: "Data Updated Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey.shade600,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
      },
      builder: (context,state){
        var usermodel = NewsCubit.get(context).usermodel;
        var profileimage=NewsCubit.get(context).profileImage;
        var coverimage=NewsCubit.get(context).coverimage;
        namecontroller.text = usermodel!.name!;
        biocontroller.text = usermodel.bio!;
        phonecontroller.text = usermodel.phone!;
        titlecontroller.text=usermodel.shopping_address!;
        return  Scaffold(
          appBar: defaultAppbar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaulttextbutton(
                function: ()async{
                  NewsCubit.get(context).updataUser(
                      name:namecontroller.text ,
                      phone:phonecontroller.text ,
                      bio:biocontroller.text,
                    title: titlecontroller.text,
                  );
                  },

                text:'Update',
              ),
              SizedBox(width: 15.0,),
            ],
          ),
          body:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                    SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0,),
                                    topRight: Radius.circular(4.0,),
                                  ),
                                  image: DecorationImage(
                                    image: coverimage==null?NetworkImage(
                                        '${usermodel.cover}'
                                    )as ImageProvider:FileImage(coverimage)as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  NewsCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar
                                  (radius: 20.0,
                                  child: Icon(IconlyLight.camera,size: 16.0,),
                                ),
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor:Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileimage == null
                                    ? NetworkImage('${usermodel.image}')
                                as ImageProvider
                                    : FileImage(profileimage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                NewsCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar
                                (radius: 20.0,
                                child: Icon(IconlyLight.camera,size: 16.0,),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if(NewsCubit.get(context).profileImage!=null ||NewsCubit.get(context).coverimage!=null )
                    Row(
                      children: [
                        if (NewsCubit.get(context).profileImage != null)
                          Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                      function: () {
                                        NewsCubit.get(context).UploadProfileImage(
                                            name: namecontroller.text,
                                            phone: phonecontroller.text,
                                            bio: biocontroller.text,
                                          title: titlecontroller.text,
                                        );
                                      },
                                      text: 'Upload Profile',
                                      background: Colors.blue),
                                  if (state is SocialUserUpdateLoadingState)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (state is SocialUserUpdateLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              )),
                        SizedBox(
                          width: 5,
                        ),
                        if (NewsCubit.get(context).coverimage != null)
                          Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                      function: () {
                                        NewsCubit.get(context).UploadcoverImage(
                                            name: namecontroller.text,
                                            phone: phonecontroller.text,
                                            title: titlecontroller.text,
                                            bio: biocontroller.text
                                        );
                                      },
                                      text: 'Upload Cover',
                                      background: Colors.blue),
                                  if (state is SocialUserUpdateLoadingState)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (state is SocialUserUpdateLoadingState)
                                    LinearProgressIndicator(),
                                ],
                              ))
                      ],
                    ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultformfield(controller: namecontroller, type: TextInputType.name, validator: (value)
                  {
                    if(value!.isEmpty&&value!=null)
                    {
                      return 'name must not be empty';
                    }
                    return null;
                  }, label: 'Name',
                    prefix:IconlyLight.user2,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultformfield(controller: biocontroller, type: TextInputType.text, validator: (value)
                  {
                    if(value!.isEmpty&&value!=null)
                    {
                      return 'Bio must not be empty';
                    }
                    return null;
                  }, label: 'Bio',
                    prefix:IconlyLight.infoSquare,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultformfield(controller: phonecontroller, type: TextInputType.phone, validator: (value)
                  {
                    if(value!.isEmpty&&value!=null)
                    {
                      return 'phone number must not be empty';
                    }
                    return null;
                  }, label: 'phone',
                    prefix:IconlyLight.call,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultformfield(controller: titlecontroller, type: TextInputType.text, validator: (value)
                  {
                    if(value!.isEmpty&&value!=null)
                    {
                      return 'Title number must not be empty';
                    }
                    return null;
                  }, label: 'Title',
                    prefix:IconlyLight.chart,
                  ),
                ],
              ),
            ),
          ) ,
        );
      },
    );
  }
}