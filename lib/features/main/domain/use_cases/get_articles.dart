
import 'package:news_app_clean_architecture/core/resources/data_state/data_state.dart';
import 'package:news_app_clean_architecture/core/usecases/use_case.dart';
import 'package:news_app_clean_architecture/features/main/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/main/domain/repositories/article_repository.dart';

class GetArticlesUseCase implements UseCase<DataState<List<ArticleEntity>>, void>{
  final ArticleRepository _articleRepository;
  GetArticlesUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) async{
    return await _articleRepository.getArticles();
  }

}