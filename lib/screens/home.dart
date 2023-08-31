import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> users=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount:users.length,
          itemBuilder: (context,index)=>
              Column(
                children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(users[index]['picture']['large']),
                  ),
                  subtitle: Text(users[index]['email']),
                  title: Text(users[index]['name']['first']),
                  // trailing: Text(users[index]['name']['title']),
                  trailing: TimePickerDialog(
                    initialTime: TimeOfDay.now(),

                  ),
                ),
              ],),

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () async {
          const url='https://randomuser.me/api/?results=500';
          final uri =Uri.parse(url);
          final responce= await http.get(uri);
          final body=responce.body;
          final json=jsonDecode(body);
          setState(() {
            users=json['results'];
            print(json);
          });

        },
      ),
    );
  }
}
