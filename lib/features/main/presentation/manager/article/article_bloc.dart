import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/resources/data_state/data_state.dart';
import 'package:news_app_clean_architecture/core/resources/exception/app_exception.dart';
import 'package:news_app_clean_architecture/features/main/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/main/domain/use_cases/get_articles.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(const ArticleInitialLoading()) {
    on<GetArticleEvent>(getArticle);
  }

  Future<void> getArticle(GetArticleEvent event, Emitter<ArticleState> emit) async{
    try{
      emit(const ArticleInitialLoading());
      final getArticlesUseCase = sl<GetArticlesUseCase>();
      final response = await getArticlesUseCase();
      if(response is DataSuccess){
        emit(ArticleDone(response.data ?? []));
      }else{
        throw response.error ?? AppException("");
      }
    }catch(e){
      debugPrint("error : $e");
      emit(ArticleError(e is AppException ? e : AppException(e)));
    }
  }
}
