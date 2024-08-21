import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

class ArticleEntity extends Equatable {
  const ArticleEntity({
    this.author,
    this.id,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory ArticleEntity.fromJson(dynamic json) {
    return ArticleEntity(
        id: json['id'],
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content']);
  }

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  ArticleEntity copyWith({
    int? id,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) =>
      ArticleEntity(
        id: id ?? this.id,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['author'] = author;
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    map['urlToImage'] = urlToImage;
    map['publishedAt'] = publishedAt;
    map['content'] = content;
    return map;
  }

  @override
  List<Object?> get props => [
        id,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}
