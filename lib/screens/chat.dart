import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final String name;

  Chat({this.name});

  @override
  _ChatState createState() => _ChatState();
}

TextEditingController _messageController = TextEditingController();

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(widget.name),
        actions: <Widget>[Text('.',style: TextStyle(fontSize: 70,color: Colors.white),)],
      ),
      body: Column(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusColor: Colors.green,
                        hintText: 'Enter Message here'),
                  ),
                ),
              ),
              IconButton(icon: Icon(Icons.send), onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
