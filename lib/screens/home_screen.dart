import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messageapp/helper/dialogs.dart';
import 'package:messageapp/models/chat_user.dart';
import 'package:messageapp/screens/profile_screen.dart';
import 'package:messageapp/widgets/chat_user_card.dart';

import '../apis/apis.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  //push notification api = AAAAUKn_Aaw:APA91bFNJnFRuC3euhqJdQ4siX50z_SKtLXXJMXTbmrpcKymJb0A57_4h5lMrw_42RM8W2U6pQLFiedDau7h-h7G8o-zQUAsTHj2SKx04798e4vBoId5UJ_uuJhyOuUN6IZCu0mQkPvM
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> _list = [];
  final List<ChatUser> _searchList = [];
  bool _isSearching = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIs.getSelfInfo();

    SystemChannels.lifecycle.setMessageHandler((message) {
      print('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
            //app bar
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 218, 255, 176),
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.black,
              ),
              title: _isSearching
                  ? TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name, Email....'),
                      autofocus: true,
                      style: TextStyle(fontSize: 17, letterSpacing: 0.7),
                      onChanged: (val) {
                        //search logic
                        _searchList.clear();

                        for (var i in _list) {
                          if (i.name
                                  .toLowerCase()
                                  .contains(val.toLowerCase()) ||
                              i.email
                                  .toLowerCase()
                                  .contains(val.toLowerCase())) {
                            _searchList.add(i);
                          }
                          setState(() {
                            _searchList;
                          });
                        }
                      },
                    )
                  : Text("PU Chat"),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearching = !_isSearching;
                      });
                    },
                    icon: Icon(
                      _isSearching
                          ? CupertinoIcons.clear_circled_solid
                          : Icons.search,
                      color: Colors.black,
                    )),
                //search user button
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProfileScreen(
                                    user: APIs.me,
                                  )));
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    )),
                //more options button
              ],
            ),
            backgroundColor: Color.fromARGB(255, 234, 248, 255),

            //floating button to add new user
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  _showAddEmailDialog();
                },
                child: Icon(Icons.add_comment_rounded),
              ),
            ),
            body: StreamBuilder(
              stream: APIs.getMyUsersId(),

              //get id of only known users
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  //if data is loading
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());

                  //if some or all data is loaded then show it
                  case ConnectionState.active:
                  case ConnectionState.done:
                    return StreamBuilder(
                        stream: APIs.getAllUsers(
                            snapshot.data?.docs.map((e) => e.id).toList() ??
                                []),

                        //get only those user, who's ids are provided
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            //if data is loading
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                            // return const Center(
                            //     child: CircularProgressIndicator());

                            //if some or all data is loaded then show it
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = snapshot.data?.docs;
                              _list = data
                                      ?.map((e) => ChatUser.fromJson(e.data()))
                                      .toList() ??
                                  [];

                              if (_list.isNotEmpty) {
                                return ListView.builder(
                                    itemCount: _isSearching
                                        ? _searchList.length
                                        : _list.length,
                                    padding:
                                        EdgeInsets.only(top: mq.height * .01),
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ChatUserCard(
                                          user: _isSearching
                                              ? _searchList[index]
                                              : _list[index]);
                                    });
                              } else {
                                return const Center(
                                  child: Text('No Connections Found!',
                                      style: TextStyle(fontSize: 20)),
                                );
                              }
                          }
                        });
                }
              },
            )),
      ),
    );
  }

  void _showAddEmailDialog() {
    String email = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding:
                  EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text(" Add User")
                ],
              ),
              content: TextFormField(
                maxLines: null,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    hintText: "Email Id",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    if (email.isNotEmpty) {
                      await APIs.addChatUser(email).then((value) {
                        if (!value) {
                          Dialogs.showSnackBar(context, "User Does Not  Exist");
                        }
                      });
                    }
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                )
              ],
            ));
  }
}
