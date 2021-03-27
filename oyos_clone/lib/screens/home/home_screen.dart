import 'package:flutter/material.dart';
import 'package:oyos_clone/constant/constant.dart';
import 'package:oyos_clone/model/aeospecials.dart';
import 'package:oyos_clone/model/aeowordlist.dart';
import 'package:oyos_clone/model/arealocationlist.dart';
import 'package:oyos_clone/model/exploreaeohotelslist.dart';
import 'package:oyos_clone/model/latestaeo.dart';
import 'package:oyos_clone/model/limitedperiodofferlist.dart';
import 'package:oyos_clone/model/readyforsummerlist.dart';
import 'package:oyos_clone/model/weekendgetawayslist.dart';
import 'package:oyos_clone/model/yourwalletslist.dart';
import 'package:oyos_clone/widgets/customshape.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _width;
  double _height;

  List<AreaLocationList> areaLocationList;
  List<ReadyForSummerList> readyForSummer;
  List<LimitedPeriodOfferList> limitedPeriodOffer;
  List<ExploreOyoHotelsList> exploreOyoHotels;
  List<WeekendGetawaysList> weekendGetaways;
  List<oyoWordList> oyoWord;
  List<OyoSpecialsList> oyoSpecials;
  List<LatestOyoList> latestOyo;
  List<YourWalletList> yourWallets;

  @override
  void initState() {
    super.initState();
    areaLocationList = Constants.getLocationList();
    readyForSummer = Constants.getSummerList();
    limitedPeriodOffer = Constants.getLimitedPeriodOfferList();
    exploreOyoHotels = Constants.getExploreOyoHotelsList();
    weekendGetaways = Constants.getWeekendsList();
    oyoSpecials = Constants.getOyoSpecials();
    latestOyo = Constants.getLatestOyo();
    yourWallets = Constants.getYourWallet();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: _height / 5,
              floating: false,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.notifications_active),
                  onPressed: () {},
                )
              ],
              backgroundColor: Color.fromARGB(255, 196, 26, 61),
              //#f02730
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                titlePadding: EdgeInsets.only(top: 25.0),
                title: Center(
                  child: Text(
                    "AYO",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
              ),
              bottom: PreferredSize(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    width: _width,
                    height: _height / 14,
                    alignment: Alignment.topCenter,
                    child: TextFormField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(2),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.grey,
                          ),
                          hintText: "Search for Hotel, City or Location",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 13.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  preferredSize: Size(_width, _height / 20)),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: _height / 6,
                child: ListView.builder(
                    itemCount: areaLocationList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildLocationList(areaLocationList[index]);
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Grand Getaway Sale',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Container(
                      //color: Colors.blue,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          spreadRadius: 0.2,
                          offset: Offset(0.1, 3),
                        ),
                      ]),
                      height: _height / 8,
                      width: _width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'assets/images/getaway.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Aeo Innings break !',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      //color: Colors.blue,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          spreadRadius: 0.2,
                          offset: Offset(0.1, 3),
                        ),
                      ]),
                      height: _height / 4,
                      width: _width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'assets/images/inningsBreak.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Refered win',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      //color: Colors.blue,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          spreadRadius: 0.2,
                          offset: Offset(0.1, 3),
                        ),
                      ]),
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'assets/images/referwin.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Daily Super Sale',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          spreadRadius: 0.2,
                          offset: Offset(0.1, 3),
                        ),
                      ]),
                      height: _height / 4.5,
                      width: _width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'assets/images/dailySale.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Get Ready for Summer !',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 90,
                      //height: MediaQuery.of(context).size.height,
                      width: _width,
                      child: ListView.builder(
                          itemCount: readyForSummer.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildSummerList(readyForSummer[index]);
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Limited period offers',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: _height / 4,
                      child: ListView.builder(
                          itemCount: limitedPeriodOffer.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildLimitedPeriodList(
                                limitedPeriodOffer[index]);
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Wizard',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      //color: Colors.blue,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          spreadRadius: 0.2,
                          offset: Offset(0.1, 3),
                        ),
                      ]),
                      height: _height / 3.7,
                      width: _width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'assets/images/wizard.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Explore AEO Hotels and Homes',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: _width,
                      height: _height / 2.3,
                      child: ListView.builder(
                          itemCount: exploreOyoHotels.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildExploreAeoHotelsList(
                                exploreOyoHotels[index]);
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Weekend Getaways',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width,
                      height: _height / 2.8,
                      child: ListView.builder(
                          itemCount: weekendGetaways.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildWeekendGetawaysList(
                                weekendGetaways[index]);
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Aeo Specials',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: _width,
                      height: _height / 2.4,
                      child: ListView.builder(
                          itemCount: oyoSpecials.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildAeoSpecialsList(oyoSpecials[index]);
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Latest at AEO',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: _width,
                      height: _height / 2.4,
                      child: ListView.builder(
                          itemCount: latestOyo.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildLatestAeoList(latestOyo[index]);
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Shake & Win',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: _height / 4.2,
                      width: _width,
                      child: Card(
                        elevation: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          child: Image.asset(
                            'assets/images/shake_win.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        //color: Colors.orange,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Play and win',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: _height / 4.5,
                      width: _width,
                      child: Card(
                        elevation: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                          child: Image.asset(
                            'assets/images/playwin.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        //color: Colors.orange,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your wallets',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: _width,
                      height: _height / 4.2,
                      child: ListView.builder(
                          itemCount: yourWallets.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildYourWalletsList(yourWallets[index]);
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationList(AreaLocationList item) {
    return Container(
      color: Colors.white,
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(70.0),
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              item.name,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourWalletsList(YourWalletList item) {
    return Container(
        width: _width / 1.5,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Card(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          color: Colors.orange[100],
          child: Stack(children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Opacity(
                opacity: 0.75,
                child: ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    height: _height / 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange[200], Colors.pinkAccent],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Column(
                children: <Widget>[
                  Opacity(
                    opacity: 0.5,
                    child: ClipPath(
                      clipper: CustomShapeClipper2(),
                      child: Container(
                        //height: _height / 3.5,
                        height: _height / 7.8,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue[500], Colors.pinkAccent],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Text(
                          item.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            item.subTitleRupee,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(
                            item.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: 150,
                    ),
                    child: Container(
                      alignment: Alignment.topLeft,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          item.totalRupee,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Widget _buildLatestAeoList(LatestOyoList item) {
    return Container(
      width: _width / 2.1,
      child: Card(
        elevation: 0,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Image.asset(
                  item.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  item.name,
                  style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.1,
                      height: 1.5,
                      fontWeight: FontWeight.w600),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAeoSpecialsList(OyoSpecialsList item) {
    return Container(
      width: _width / 2.20,
      child: Card(
        elevation: 2,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Container(
                  child: Image.asset(
                    item.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.subTitle,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          letterSpacing: 0.1,
                          height: 1.5),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekendGetawaysList(WeekendGetawaysList item) {
    return Container(
      width: _width / 2.4,
      child: Card(
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5)),
          child: Image.asset(
            item.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildExploreAeoHotelsList(ExploreOyoHotelsList item) {
    return Container(
      width: _width / 2.20,
      child: Card(
        elevation: 2,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Image.asset(
                  item.imgUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.black,
              height: _height / 30,
              width: _width / 5,
              child: Text(
                item.title,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  item.subTitle,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      letterSpacing: 0.1,
                      height: 1.5),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLimitedPeriodList(LimitedPeriodOfferList item) {
    return Container(
      width: _width / 2.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Card(
          elevation: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
            child: Image.asset(
              item.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummerList(ReadyForSummerList item) {
    return Container(
      width: _width,
      child: Card(
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.asset(
            item.imgUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
