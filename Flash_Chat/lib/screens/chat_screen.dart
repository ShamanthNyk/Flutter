import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore=Firestore.instance;
FirebaseUser LoggedinUser;

class ChatScreen extends StatefulWidget {
  static String id= 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth =FirebaseAuth.instance;
  final messagetextcontroller=TextEditingController();

  String messageText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        LoggedinUser = user;
        print(LoggedinUser.email);
      }
    }
    catch(e){
      print(e);
    }
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
              
                //Implement logout functionality
                _auth.signOut();
               Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Mymessagesstream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messagetextcontroller,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      messagetextcontroller.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender':LoggedinUser.email,
                        'timestamp':FieldValue.serverTimestamp(),
                      });

                      
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Mymessagesstream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:_firestore.collection('messages').orderBy('timestamp').snapshots(),
      // ignore: missing_return
      builder: (context, snapshot ) {
        if(!snapshot.hasData){
          return Center(
            child:CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages=snapshot.data.documents.reversed;
        List<MessageBubble>messagebubbles=[];
        for( var message in messages){
          final mtext=message.data['text'];
          final msender=message.data['sender'];
          final currentUser=LoggedinUser.email;

          final mbubble=MessageBubble(sender:msender,text:mtext,isme: currentUser==msender?true:false);
          messagebubbles.add(mbubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:
            EdgeInsets.symmetric(horizontal:10.0,vertical:20.0),
            children: messagebubbles,
          ),
        );

      },
    );
  }
}


class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isme;
  MessageBubble({this.sender,this.text,this.isme});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme?CrossAxisAlignment.end : CrossAxisAlignment.start,
        children:<Widget>[
          Text(
              sender,
            style: TextStyle(
              color:Colors.black54,
              fontSize: 12.0,
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: isme?BorderRadius.only(topLeft: Radius.circular(30.0)
                ,bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ) :BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ) ,
            color: isme? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Text(''
                  '$text',
                style: TextStyle(
                  color:isme?Colors.white :Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
         ],
        ),
      );

    
  }
}

