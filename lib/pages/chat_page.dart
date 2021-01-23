import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  List<ChatMessage> _messages = [];

  bool _isWriting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget>[
            CircleAvatar(
              child: Text('Eh', style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3),
            Text('Emmanuel Hurtado', style: TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _messages.length,
                    itemBuilder: (_, i) => _messages[i],
                    reverse: true,
                )
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat(){
    return SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSumbit,
                    onChanged: (String texto){
                      setState(() {
                        if (texto.trim().length > 0){
                          _isWriting = true;
                        } else {
                          _isWriting = false;
                        }
                      });
                    },
                    decoration: InputDecoration.collapsed(
                        hintText: 'Enviar mensaje'
                    ),
                    focusNode: _focusNode,
                  )
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Platform.isIOS
                ? CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: _isWriting
                      ? () => _handleSumbit(_textController.text.trim())
                      : null,
                    )
                    : Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue[400]),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.send),
                      onPressed: _isWriting 
                      ? () => _handleSumbit(_textController.text.trim())
                      : null,
                    ),
                  ),
                )
              )
            ],
          ),
        )
    );
  }

  _handleSumbit(String texto){

    if(texto.length ==0) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
        uid: '123',
        texto: texto,
        animationController: AnimationController(
            vsync: this,
            duration: Duration(milliseconds: 400)
        )
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    //TODO: off del socket

    for (ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }

}