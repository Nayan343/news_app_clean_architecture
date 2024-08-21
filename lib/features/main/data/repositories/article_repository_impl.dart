import 'dart:io';

import 'package:news_app_clean_architecture/core/resources/data_state/data_state.dart';
import 'package:news_app_clean_architecture/core/resources/exception/app_exception.dart';
import 'package:news_app_clean_architecture/features/main/data/data_sources/app_database.dart';
import 'package:news_app_clean_architecture/features/main/data/data_sources/news_api_services.dart';
import 'package:news_app_clean_architecture/features/main/data/models/article_model.dart';
import 'package:news_app_clean_architecture/features/main/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/main/domain/repositories/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository{
  final NewsApiServicesImpl _newsApiServices;
  final AppDataBase _appDatabase;
  const ArticleRepositoryImpl(this._newsApiServices, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getArticles() async{
    try{
      final response = await _newsApiServices.getArticles();
      if(response.statusCode == HttpStatus.ok){
        List<ArticleModel> articleList = [];
        for(final item in response.data["articles"]){
          articleList.add(ArticleModel.fromJson(item));
        }
        return DataSuccess(articleList);
      } else{
        return DataFailure(AppException(response));
      }
    }catch(e) {
      return DataFailure(AppException(e));
    }
  }

  @override
  Future<DataState<List<ArticleModel>>> getSaveArticles() async{
    try{
      final response = await _appDatabase.articleDao.getArticles();
      return DataSuccess(response);
    }catch(e) {
      return DataFailure(AppException(e));
    }
  }

  @override
  Future<DataState<int>> removeArticles({ArticleEntity? articleEntity}) async{
    try {
      final response = await _appDatabase.articleDao.deleteArticle(articleEntity as ArticleModel);
      return DataSuccess(response);
    }catch(e){
      return DataFailure(AppException(e));
    }
  }

  @override
  Future<DataState<int>> savedArticles({ArticleEntity? articleEntity}) async{
    try{
      final response = await _appDatabase.articleDao.insertArticle(articleEntity as ArticleModel);
      return DataSuccess(response);
    }catch(e){
      return DataFailure(AppException(e));
    }
  }

  @override
  Future<DataState<int>> updateArticle({ArticleEntity? articleEntity}) async{
    try{
      final response = await _appDatabase.articleDao.updateArticle(articleEntity as ArticleModel);
      return DataSuccess(response);
    }catch(e){
      return DataFailure(AppException(e));
    }
  }
}