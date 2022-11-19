import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:noteped/databasehelp.dart';
import 'package:noteped/note.dart';
import 'package:sqflite/sqflite.dart';


class frist extends StatefulWidget {


  @override
  State<frist> createState() => _fristState();
}

class _fristState extends State<frist> {
  bool plus=false;
  bool note=false;
  Database? db;

  List name=[];

  List<Map<String, Object?>> l=List.empty(growable: true);
 Future<List> getdata() async {

    db=await databasehelp().getData();
    print(db);
    String qry="select * from note_book";
    List<Map<String, Object?>> x=await db!.rawQuery(qry);
    l.addAll(x);
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Super Note"),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 1, 15, 1),

            child: Icon(Icons.search),
          ),
          Padding(
            padding: EdgeInsets.all(1),
            child: Icon(Icons.cloud_upload),
          ),
          PopupMenuButton(itemBuilder: (context) => [
            PopupMenuItem(child: Text("first")),
            PopupMenuItem(child: Text("second")),
            PopupMenuItem(child: Text("third")),
            PopupMenuItem(child: Text("fourth")),
          ],)
        ],
      ),

      body:
          FutureBuilder(future:getdata(),builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.done)
            {
              List<Map<String, Object?>> mylist = snapshot.data as List<Map<String, Object?>>;
              List title=[];
              List note=[];
              List id=[];

              if(snapshot.hasData) {
                mylist.forEach((element) {
                  title.add(element['title']);
                  note.add(element['note']);

                  id.add(element['id']);
                });
                return ListView.builder(
                  itemCount: mylist.length, itemBuilder: (context, index) {
               //   Map m = mylist[index];
                  return ListTile(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return noteped(title[index],note[index],id[index]);
                      },));
                    },
                    title: Text("${title[index]}"),
                    subtitle: Text("${note[index]}",maxLines: 2,),
                  );
                },);
              }
              else
              {
                return Center(child: CircularProgressIndicator(),);
              }
            }
            else
              {
                return Center(child: CircularProgressIndicator(),);
              }

          },),
          // ListView.builder(itemBuilder: (context, index) {
          //
          //   );
          // },
          // )

      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        animatedIconTheme: IconThemeData(size: 28.0),
        backgroundColor: Colors.green[900],
        visible: true,
        curve: Curves.bounceInOut,
        children: [
          SpeedDialChild(
            child: Icon(Icons.checklist_rtl_outlined,),
              label:"checklist"
          ),
          SpeedDialChild(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return noteped();
              },));
            },
              child: Icon(Icons.note_alt_outlined,),
              label:"note"
          )
        ],
      )

    );
  }
}


// class _MapEqualColorMappingPageState extends SampleViewState {
//   List<_CountryTimeInGMT> _timeZones;
//   MapShapeSource _mapSource;
//
//   ...
// }