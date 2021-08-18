import 'dart:convert';

import 'package:flutter_quotes_provider/models/quote_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future getRandomQuotes() async {
    List<QuoteModel> quotes = [];

    for (int i = 0; i < 10; i++) {
      var response =
          await http.get(Uri.parse('https://api.quotable.io/random'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        quotes.add(QuoteModel.fromJson(data));
      } else
        print(response.statusCode);
    }
    return quotes;
  }

  Future getRandomFamousQuotes() async {
    List<QuoteModel> quotes = [];

    for (int i = 0; i < 10; i++) {
      var response = await http
          .get(Uri.parse('https://api.quotable.io/random?tags=friendship'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        quotes.add(QuoteModel.fromJson(data));
      } else
        print(response.statusCode);
    }
    return quotes;
  }

  Future getRandomInspirationalQuotes() async {
    List<QuoteModel> quotes = [];

    for (int i = 0; i < 10; i++) {
      var response = await http
          .get(Uri.parse('https://api.quotable.io/random?tags=inspirational'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        quotes.add(QuoteModel.fromJson(data));
      } else
        print(response.statusCode);
    }
    return quotes;
  }

  Future getRandomWisdomQuotes() async {
    List<QuoteModel> quotes = [];

    for (int i = 0; i < 10; i++) {
      var response = await http
          .get(Uri.parse('https://api.quotable.io/random?tags=wisdom'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        quotes.add(QuoteModel.fromJson(data));
      } else
        print(response.statusCode);
    }
    return quotes;
  }
}
