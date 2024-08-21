import 'package:floor/floor.dart';
import 'package:news_app_clean_architecture/features/main/data/models/article_model.dart';

@dao
abstract class ArticleDao {

  @Insert()
  Future<int> insertArticle(ArticleModel article);

  @delete
  Future<int> deleteArticle(ArticleModel articleModel);

  @update
  Future<int> updateArticle(ArticleModel articleModel);

  @Query('SELECT * FROM article')
  Future<List<ArticleModel>> getArticles();
}