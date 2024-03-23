import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:yehia/Widgets/text_widget.dart';
import 'package:yehia/Widgets/title%20widget.dart';

void navigateTo(context,Widget)=>Navigator.push(context, MaterialPageRoute(
  builder:(context)=>Widget,
));
Future<void> errorDialog({
  required String subtitle,
  required BuildContext context,
}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                'assets/images/signo.png',
                height: 20.0,
                width: 20.0,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(' An Error occured'),
            ],
          ),
          content: Text(subtitle),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Textwidget(
                color: Colors.cyan,
                text: 'Ok',
                textsize: 18,
              ),
            ),
          ],
        );
      });
}
PreferredSizeWidget defaultAppbar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          IconlyLight.arrowLeft2,
        ),
      ),
      titleSpacing: 5.0,
      title: Text(
        title!,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: actions,
    );
Widget defaulttextbutton({
  required VoidCallback function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color? background,
  bool isUppercase = true,
  double raduis = 10,
  @required Function()? function,
  @required String? text,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        height: 45.0,
        color: background,
        child: Text(
          isUppercase ? text!.toUpperCase() : text!,
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),
      ),
    );
Widget defaultformfield({
  required TextEditingController controller,
  required TextInputType type,
  Function(String x)? onchange,
  required String? Function(String? val)? validator,
  required String label,
  required IconData prefix,
}) =>
    TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefix,
          ),
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: validator,
        keyboardType: type,
        onChanged: onchange);
Widget listtile({
  required String title,
  required IconData icon,
  String? subtitle,
  required Function onpressed,
  required Color color,

})
{
  return ListTile(
    title: Textwidget(
      color: color,
      text:title,
      textsize:22.0,
      // istitle: true,
    ),
    subtitle: Textwidget(
      color: color,
      text:subtitle==null?"":subtitle,
      textsize:18.0,
    ),
    leading: Icon(icon),
    trailing: Icon(IconlyLight.arrowRight2),
    onTap: (){
      onpressed();
    },
  );

}
Future<void> imagePickerDialog({
required BuildContext context,
required Function cameraFCT,
required Function galleryFCT,
required Function removeFCT,
}) async {
await showDialog(
context: context,
builder: (BuildContext context) {
return AlertDialog(
title: const Center(
child: TitlesTextWidget(
label: "Choose option",
),
),
content: SingleChildScrollView(
child: ListBody(
children: [
TextButton.icon(
onPressed: () {
cameraFCT();
if (Navigator.canPop(context)) {
Navigator.pop(context);
}
},
icon: const Icon(Icons.camera),
label: const Text("Camera"),
),
TextButton.icon(
onPressed: () {
galleryFCT();
if (Navigator.canPop(context)) {
Navigator.pop(context);
}
},
icon: const Icon(
Icons.browse_gallery,
),
label: const Text("Gallery"),
),
TextButton.icon(
onPressed: () {
removeFCT();
if (Navigator.canPop(context)) {
Navigator.pop(context);
}
},
icon: const Icon(
Icons.remove_circle_outline,
),
label: const Text("Remove"),
),
],
),
),
);
});
}
Future<void>warningDialog({
  required String title,
  required String subtitle,
  required VoidCallback fct,
  required BuildContext context,
})async {
  await showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Row(
        children: [
          Image.asset('assets/images/signo.png',height: 20.0,width: 20.0,fit: BoxFit.fill,),
          SizedBox(width: 8.0,),
          Text(title),
        ],
      ),
      content: Text(subtitle),
      actions: [
        TextButton(onPressed: (){
          if(Navigator.canPop(context))
          {
            Navigator.pop(context);
          }
        }, child:Textwidget(
          color: Colors.cyan,
          text: 'Cancel',
          textsize: 18,
        ),),
        TextButton(
          onPressed: fct
          ,child:Textwidget(
          color: Colors.red,
          text: 'ok',
          textsize: 18,
        ),

        ),
      ],
    );
  });
}