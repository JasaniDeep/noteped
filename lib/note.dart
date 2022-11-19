// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:noteped/databasehelp.dart';
import 'package:noteped/first.dart';
import 'package:sqflite/sqflite.dart';

class noteped extends StatefulWidget {
  int id;
  String title;
  String note;

  noteped([this.title="",this.note="",this.id=-1]);




  @override
  State<noteped> createState() => _notepedState();
}

class _notepedState extends State<noteped> {
  TextEditingController title_n=TextEditingController();
  TextEditingController note_text=TextEditingController();
  Color fontcolor = Color(0xff000000);
  Color f_back_color = Color(0xFFFFFF);
  Color background_color = Color(0xFFFFFFFF);
  bool underline=false;
  // double f_size=14;
  bool f_bold=false;
  bool f_italic=false;
  Database? db;
  @override
  void initState() {
    super.initState();
    databasehelp().getData().then((value) {
      db=value;
    });

    title_n.text=widget.title;
    note_text.text=widget.note;


  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        foregroundColor: Colors.black,
        title: TextField(
          controller: title_n,
          decoration: InputDecoration(
            hintText: "Edit Title",
          ),
          cursorColor: Colors.black,
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 15),
              child:InkWell(
                onTap: () async{
                  setState((){});
                    String str1,str2;
                    str1=title_n.text;
                    str2=note_text.text;
                    String sql="insert into note_book values(null,'$str1','$str2')";
                    print(sql);
                    int r_id;
                    r_id= await db!.rawInsert(sql);
                    print(r_id);
                    str1="";
                    str2="";
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return frist();
                    },));
                  },

                child: Icon(Icons.save),
              ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 1, 15, 1),
            child: Icon(Icons.search),
          ),
          PopupMenuButton(
            offset: Offset(300, 60),
            itemBuilder: (context)  => [
              PopupMenuItem(child: ListTile(leading: Icon(Icons.push_pin_sharp),title: Text('pin'),),),
              PopupMenuItem(child: ListTile(leading: Icon(Icons.mobile_screen_share_rounded),title: Text('share'),),),
              PopupMenuItem(child: ListTile(leading: Icon(Icons.copy),title: Text('Thems'),),),
              PopupMenuItem(child: ListTile(leading: Icon(Icons.add_alert_outlined),title: Text('Reminder'),),),
              PopupMenuItem(child: ListTile(leading: Icon(Icons.delete,color: Colors.red,), title: Text('Delete',style: TextStyle(color: Colors.red),),),),
            ],),
          ],
        ),
      body: Column(
        children: [
          Expanded(

              child:ColoredBox(
                  color: background_color,
                child: TextField(
                  controller: note_text,
                  style: TextStyle(
                      color: fontcolor,
                      backgroundColor:f_back_color,
                      decoration: (underline==true)?TextDecoration.underline:TextDecoration.none,
                      textBaseline: TextBaseline.alphabetic,
                      // fontSize: f_size.toDouble(),
                      fontWeight:(f_bold==true)?FontWeight.bold:FontWeight.normal,
                      fontStyle: (f_italic==true)?FontStyle.italic:FontStyle.normal
                  ),
                  decoration: InputDecoration(hintText: "Insert your message",),
                  scrollPadding: EdgeInsets.all(20.0),
                  keyboardType: TextInputType.multiline,
                  maxLines: 99999,
                  autofocus: true,
                ),
              )
          ),
         SizedBox(
           height: 70,
           width: double.infinity,
           child: Row(
             children: [
               Expanded(child: IconButton(onPressed: () {
                 showDialog(builder:(context){
                   return AlertDialog(
                     title: const Text('Font Background Color'),
                     content: ColorPicker(onColorChanged: (value) {
                       setState((){
                         background_color=value;
                       });
                     },pickerColor: background_color, ),
                   );
                 },context: context,);
               },icon:Icon(Icons.color_lens_outlined)),),
               Expanded(child: IconButton(onPressed: () {
                 setState((){
                   f_bold=!f_bold;
                 });

               }, icon: Icon(Icons.format_bold_outlined))),
               Expanded(child: IconButton(onPressed: () {
                 setState((){
                   f_italic=!f_italic;
                 });
               }, icon: Icon(Icons.format_italic_outlined))),
               Expanded(child: IconButton(onPressed: () {
                 setState((){underline=!underline;});
               }, icon: Icon(Icons.format_underline_outlined))),
               Expanded(child: IconButton(onPressed: () {
                 showDialog(builder:(context){
                   return AlertDialog(
                     title: const Text('Font Background Color'),
                     content: ColorPicker(onColorChanged: (value) {
                       setState((){
                         f_back_color=value;
                       });
                     },pickerColor: f_back_color ),
                   );
                 },context: context,);
               },icon:Icon(Icons.format_color_text)),),
               Expanded(child: IconButton(onPressed: () {
                 showDialog(builder:(context){
                   return AlertDialog(
                     title: const Text('Font Color'),
                     content: BlockPicker(onColorChanged: (value) {
                       setState((){
                         fontcolor=value;
                       });
                     },pickerColor: fontcolor ),
                   );
                 },context: context,);
               }, icon:Icon(Icons.border_color)),),

              ],
           ),
         )
        ],
      ),
    );
  }
}
