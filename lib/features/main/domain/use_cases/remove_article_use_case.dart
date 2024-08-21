import 'package:news_app_clean_architecture/core/resources/data_state/data_state.dart';
import 'package:news_app_clean_architecture/core/usecases/use_case.dart';
import 'package:news_app_clean_architecture/features/main/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/main/domain/repositories/article_repository.dart';

class RemoveArticleUseCase implements UseCase<DataState<int>, ArticleEntity>{
  final ArticleRepository _articleRepository;
  const RemoveArticleUseCase(this._articleRepository);
  @override
  Future<DataState<int>> call({ArticleEntity? params}) async{
    return await _articleRepository.removeArticles(articleEntity: params);
  }
}