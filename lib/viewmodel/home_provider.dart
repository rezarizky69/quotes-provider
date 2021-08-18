import 'package:flutter/cupertino.dart';
import 'package:flutter_quotes_provider/api/api_services.dart';
import 'package:flutter_quotes_provider/models/quote_model.dart';

class QuotesProvider extends ChangeNotifier {
  List<QuoteModel> currentQuotes = [];
  List<QuoteModel> currentFamousQuotes = [];
  List<QuoteModel> currentInspirationalQuotes = [];
  List<QuoteModel> currentWisdomQuotes = [];

  getRandomQuotesList() async {
    List<QuoteModel> updatedQuotes = await ApiService().getRandomQuotes();
    // ignore: unnecessary_null_comparison
    if (currentQuotes != null) {
      if (currentQuotes.length > 1) {
        currentQuotes.addAll(updatedQuotes);
      } else {
        currentQuotes = updatedQuotes;
      }
      notifyListeners();
    } else {
      print('quotes is null');
    }
  }

  getRandomFamousQuotesList() async {
    List<QuoteModel> updatedQuotes = await ApiService().getRandomFamousQuotes();
    // ignore: unnecessary_null_comparison
    if (currentFamousQuotes != null) {
      if (currentFamousQuotes.length > 1) {
        currentFamousQuotes.addAll(updatedQuotes);
      } else {
        currentFamousQuotes = updatedQuotes;
      }
      notifyListeners();
    } else {
      print('quotes is null');
    }
  }

  getRandomInspirationalQuotesList() async {
    List<QuoteModel> updatedQuotes =
        await ApiService().getRandomInspirationalQuotes();
    // ignore: unnecessary_null_comparison
    if (currentInspirationalQuotes != null) {
      if (currentInspirationalQuotes.length > 1) {
        currentInspirationalQuotes.addAll(updatedQuotes);
      } else {
        currentInspirationalQuotes = updatedQuotes;
      }
      notifyListeners();
    } else {
      print('quotes is null');
    }
  }

  getRandomWisdomQuotesList() async {
    List<QuoteModel> updatedQuotes = await ApiService().getRandomWisdomQuotes();
    // ignore: unnecessary_null_comparison
    if (currentWisdomQuotes != null) {
      if (currentWisdomQuotes.length > 1) {
        currentWisdomQuotes.addAll(updatedQuotes);
      } else {
        currentWisdomQuotes = updatedQuotes;
      }
      notifyListeners();
    } else {
      print('quotes is null');
    }
  }
}
