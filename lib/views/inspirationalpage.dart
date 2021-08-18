import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quotes_provider/viewmodel/home_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InspirationalPage extends StatefulWidget {
  @override
  _InspirationalPageState createState() => _InspirationalPageState();
}

class _InspirationalPageState extends State<InspirationalPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // menggunakan provider untuk fetching data quotes
    Provider.of<QuotesProvider>(context, listen: false)
        .getRandomInspirationalQuotesList();

    // menggunakan scroll controller agar ketika user sudah mencapai akhir layar
    // maka akan fecthing data melalui provider lagi
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // melakukan fetching quotes
        Provider.of<QuotesProvider>(context, listen: false)
            .getRandomInspirationalQuotesList();
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
            " \" Inspirational Quotes \" ",
            textScaleFactor: 2.0,
            style: GoogleFonts.dancingScript(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Container(
            child: dataModel.currentInspirationalQuotes.isEmpty
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
                    itemCount: dataModel.currentInspirationalQuotes.length,
                    itemBuilder: (context, index) {
                      if (index ==
                          dataModel.currentInspirationalQuotes.length - 1) {
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
                                " \"${dataModel.currentInspirationalQuotes[index].content}\" ",
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  " - ${dataModel.currentInspirationalQuotes[index].author} ",
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
