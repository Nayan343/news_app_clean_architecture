import 'package:news_app_clean_architecture/core/resources/data_state/data_state.dart';
import 'package:news_app_clean_architecture/features/main/domain/entities/article_entity.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getArticles();

  Future<DataState<List<ArticleEntity>>> getSaveArticles();
  Future<DataState<int>> savedArticles({ArticleEntity? articleEntity});
  Future<DataState<int>> updateArticle({ArticleEntity? articleEntity});
  Future<DataState<int>> removeArticles({ArticleEntity? articleEntity});
}
