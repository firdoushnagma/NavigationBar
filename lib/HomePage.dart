import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex;
  Icon _searchIcon = Icon(
    Icons.search,
  );
  bool isSearchClicked = false;
  final TextEditingController _filter = new TextEditingController();

  List<String> itemList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      for (int count = 0; count < 50; count++) {
        itemList.add("Item $count");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[createSilverAppBar()];
          },
          body: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(itemList[index]),
                  ),
                );
              })),
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        backgroundColor: Color(0xE8E9F0EE),
        animationDuration: Duration(microseconds: 200),
        index: 0,
        animationCurve: Curves.bounceInOut,
        buttonBackgroundColor: Colors.white,
        items: [
          SvgPicture.asset('assets/home.svg',
              height: 30,
              color: _currentIndex == 0 ? Colors.grey : Colors.green),
          SvgPicture.asset('assets/bookmark.svg',
              height: 30,
              color: _currentIndex == 0 ? Colors.grey : Colors.green),
          SvgPicture.asset('assets/partner.svg',
              height: 30,
              color: _currentIndex == 0 ? Colors.grey : Colors.green)
        ],
        onTap: (index) {
          setState(() {});
        },
      ),
    );
  }

  SliverAppBar createSilverAppBar() {
    return SliverAppBar(
        actions: <Widget>[
          RawMaterialButton(
            elevation: 0.0,
            child: _searchIcon,
            onPressed: () {
              _searchPressed();
            },
            constraints: BoxConstraints.tightFor(
              width: 56,
              height: 56,
            ),
            shape: CircleBorder(),
          ),
        ],
        expandedHeight: 300,
        floating: true,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(bottom: 15),
          centerTitle: true,
          title: isSearchClicked
              ? Container(
                  padding: EdgeInsets.only(bottom: 2),
                  constraints: BoxConstraints(minHeight: 40, maxHeight: 40),
                  width: 220,
                  child: CupertinoTextField(
                    controller: _filter,
                    keyboardType: TextInputType.text,
                    placeholder: "Search..",
                    placeholderStyle: TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 14.0,
                      fontFamily: 'Brutal',
                    ),
                    prefix: Padding(
                      padding: const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                  ),
                )
              : Text("NAGMA"),
        ));
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(
          Icons.close,
        );
        isSearchClicked = true;
      } else {
        this._searchIcon = Icon(
          Icons.search,
        );
        isSearchClicked = false;
        _filter.clear();
      }
    });
  }
}
