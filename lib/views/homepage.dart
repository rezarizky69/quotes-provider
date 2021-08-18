import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quotes_provider/viewmodel/home_provider.dart';
import 'package:flutter_quotes_provider/views/famouspage.dart';
import 'package:flutter_quotes_provider/views/inspirationalpage.dart';
import 'package:flutter_quotes_provider/views/wisdompage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // menggunakan provider untuk fetching data quotes
    Provider.of<QuotesProvider>(context, listen: false).getRandomQuotesList();

    // menggunakan scroll controller agar ketika user sudah mencapai akhir layar
    // maka akan fecthing data melalui provider lagi
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // melakukan fetching quotes
        Provider.of<QuotesProvider>(context, listen: false)
            .getRandomQuotesList();
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<QuotesProvider>(builder: (context, dataModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            " \" Quotes \" ",
            textScaleFactor: 2.0,
            style: GoogleFonts.dancingScript(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.black,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text("by Reza Rizky"),
                accountEmail: Text("Quotes Category"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "R",
                    style: TextStyle(fontSize: 40.0, color: Colors.black),
                  ),
                ),
              ),
               ListTile(
                title: Text("Random Quotes"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()));
                },
              ),
              ListTile(
                title: Text("Friendship Quotes"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FamousPage()));
                },
              ),
              ListTile(
                title: Text("Inspirational Quotes"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => InspirationalPage()));
                },
              ),
              ListTile(
                title: Text("Wisdom Quotes"),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => WisdomPage()));
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            child: dataModel.currentQuotes.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      crossAxisCount: size.width < 700
                          ? 1
                          : size.width < 1000
                              ? 2
                              : size.width < 1200
                                  ? 3
                                  : 4,
                    ),
                    itemCount: dataModel.currentQuotes.length,
                    itemBuilder: (context, index) {
                      if (index == dataModel.currentQuotes.length - 1) {
                        return Container(
                            margin: EdgeInsets.all(25),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            alignment: Alignment.center,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ));
                      } else {
                        return Container(
                          margin: EdgeInsets.all(25),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.black26)),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                " \"${dataModel.currentQuotes[index].content}\" ",
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  " - ${dataModel.currentQuotes[index].author} ",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.merriweather(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
          ),
        ),
      );
    });
  }
}
