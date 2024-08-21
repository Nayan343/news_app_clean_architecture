import 'package:floor/floor.dart';
import 'package:news_app_clean_architecture/features/main/domain/entities/article_entity.dart';

@Entity(tableName: "Article")
class ArticleModel extends ArticleEntity {
  const ArticleModel({
      int? id,
      String? author,
      String? title,
      String? description,
      String? url,
      String? urlToImage,
      String? publishedAt,
      String? content})
      : super(
            id: id,
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content);

  factory ArticleModel.fromJson(dynamic json) {
    return ArticleModel(
        id: json['id'],
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content']);
  }
}
