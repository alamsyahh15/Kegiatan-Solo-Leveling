
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:book_app/intro.dart';
import 'package:book_app/color_palette.dart';
import 'package:book_app/page_login.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final List<Intro> introList = [
    Intro(
      image: "images/onboard1.jpg",
      title: "Home",
      description: "Many Category Of Book",
    ),
    Intro(
      image: "images/onboard2.jpg",
      title: "Book",
      description: "Get Knowledge With Reading Book",
    ),
    Intro(
      image: "images/onboard3.jpg",
      title: "Profile",
      description: "Update Your Profile ",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Swiper.children(
        index: 0,
        autoplay: false,
        loop: false,
        pagination: SwiperPagination(
          margin: EdgeInsets.only(bottom: 20.0),
          builder: DotSwiperPaginationBuilder(
            color: ColorPalette.dotColor,
            activeColor: ColorPalette.dotActiveColor,
            size: 10.0,
            activeSize: 10.0,
          ),
        ),
        control: SwiperControl(
            iconNext: null,
            iconPrevious: null
        ),
        children: _buildPage(context),

      ),

    );
  }

  List<Widget> _buildPage(BuildContext context) {
    List<Widget> widgets = [];

    for(int i=0; i<introList.length; i++) {
      Intro intro = introList[i];
      widgets.add(
        Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/6,
          ),
          child: ListView(
            children: <Widget>[
              Image.asset(
                intro.image,
                height: MediaQuery.of(context).size.height/3.5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height/12.0,
                ),
              ),
              Center(
                child: Text(
                  intro.title,
                  style: TextStyle(
                    color: ColorPalette.titleColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height/20.0,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height/20.0,
                ),
                child: Text(
                  intro.description,
                  style: TextStyle(
                    color: ColorPalette.descriptionColor,
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0),
                child: MaterialButton(
                  color: Colors.lightBlueAccent,
                  textColor: Colors.white,
                  child: Text('Get Started'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageLogin()));
                  },

                ),
              ),
            ],
          ),
        ),
      );
    }
    return widgets;
  }

}
