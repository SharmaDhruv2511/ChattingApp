import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messageapp/helper/my_date_util.dart';
import 'package:messageapp/models/chat_user.dart';
import '../main.dart';

class ViewProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ViewProfileScreen({super.key, required this.user});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreen();
}

class _ViewProfileScreen extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          //app bar
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 218, 255, 176),
            title: Text(widget.user.name),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
          ),

          floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Joined On :', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16),),
                Text(
                  MyDateUtil.getLastMessageTime(context: context, time: widget.user.createdAt, showYear: true),
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ]
          ),

          backgroundColor: Color.fromARGB(255, 234, 248, 255),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: mq.width,
                    height: mq.height * .03,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * .1),
                    child: CachedNetworkImage(
                      imageUrl: widget.user.image,
                      fit: BoxFit.cover,
                      width: mq.height * .2,
                      height: mq.height * .2,
                      errorWidget: (context, url, error) => CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * .03,
                  ),
                  Text(
                    widget.user.email,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: mq.height * .02,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('About :', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16),),
                      Text(
                        widget.user.about,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ]
                  ),

                ],
              ),
            ),
          )),
    );
  }
}
