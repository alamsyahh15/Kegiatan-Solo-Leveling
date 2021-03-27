import 'package:flutter/material.dart';
import 'package:simple_firebase/post_model.dart';

class DetailPost extends StatefulWidget {
  final PostModel data;

  const DetailPost({Key key, this.data}) : super(key: key);
  @override
  _DetailPostState createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Post"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget?.data?.id}"),
            SizedBox(height: 16),
            Text(
              "${widget?.data?.title}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 16),
            Text("${widget?.data?.body}"),
          ],
        ),
      ),
    );
  }
}
