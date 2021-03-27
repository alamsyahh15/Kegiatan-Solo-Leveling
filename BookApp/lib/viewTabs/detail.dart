

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:book_app/constant/constantFile.dart';
import 'package:book_app/constant/bookModel.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailBook extends StatefulWidget {
  final BookModel model;
  final VoidCallback reload;

  DetailBook(this.model, this.reload);

  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  final _key = new GlobalKey<FormState>();

  _launchURL() async {
    var url = widget.model.link_book;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.title),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: <Widget>[
          Image.network(
      BaseUrl.insertImage + widget.model.image,
          ),
          Container(
            padding: EdgeInsets.all(32.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          widget.model.title,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text('Kategori : '+widget.model.category,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                      ),
                      Text('Tanggal Publish : '+widget.model.date_publish,style: TextStyle(fontSize: 10),),

                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 32.0, right: 32.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'Deskripsi : ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                            ),

                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.model.description,
                    style: TextStyle(
                      fontSize: 13),
                    softWrap: true,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(
                    color: Colors.lightBlue[800],
                    textColor: Colors.white,
                    onPressed: _launchURL,
                    child: new Text('Show E-Book'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
