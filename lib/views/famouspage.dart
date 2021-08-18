import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quotes_provider/viewmodel/home_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FamousPage extends StatefulWidget {
  @override
  _FamousPageState createState() => _FamousPageState();
}

class _FamousPageState extends State<FamousPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // menggunakan provider untuk fetching data quotes
    Provider.of<QuotesProvider>(context, listen: false)
        .getRandomFamousQuotesList();

    // menggunakan scroll controller agar ketika user sudah mencapai akhir layar
    // maka akan fecthing data melalui provider lagi
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // melakukan fetching quotes
        Provider.of<QuotesProvider>(context, listen: false)
            .getRandomFamousQuotesList();
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
            " \" Friendship Quotes \" ",
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
            child: dataModel.currentFamousQuotes.isEmpty
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
                    itemCount: dataModel.currentFamousQuotes.length,
                    itemBuilder: (context, index) {
                      if (index == dataModel.currentFamousQuotes.length - 1) {
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
                                " \"${dataModel.currentFamousQuotes[index].content}\" ",
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  " - ${dataModel.currentFamousQuotes[index].author} ",
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
