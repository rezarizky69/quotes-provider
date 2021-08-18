import 'dart:convert';

class QuoteModel {
  QuoteModel({
    required this.id,
    required this.tags,
    required this.content,
    required this.author,
    required this.length,
  });

  final String id;
  final List<String> tags;
  final String content;
  final String author;
  final int length;

  factory QuoteModel.fromRawJson(String string) =>
      QuoteModel.fromJson(json.decode(string));

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        id: json["_id"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        content: json["content"],
        author: json["author"],
        length: json["length"],
      );
}
