import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/resources/data_state/data_state.dart';
import 'package:news_app_clean_architecture/core/resources/exception/app_exception.dart';
import 'package:news_app_clean_architecture/features/main/domain/entities/article_entity.dart';
import 'package:news_app_clean_architecture/features/main/domain/use_cases/get_saved_articles_use_case.dart';
import 'package:news_app_clean_architecture/features/main/domain/use_cases/remove_article_use_case.dart';
import 'package:news_app_clean_architecture/features/main/domain/use_cases/save_article_use_case.dart';
import 'package:news_app_clean_architecture/features/main/domain/use_cases/update_article_use_case.dart';
import 'package:news_app_clean_architecture/injection_container.dart';

part 'saved_article_event.dart';
part 'saved_article_state.dart';

class SavedArticleBloc extends Bloc<SavedArticleEvent, SavedArticleState> {
  SavedArticleBloc() : super(const SavedArticleState(status: SavedArticleStatus.initial)) {
    on<SaveArticle>(_onSaveArticle);
    on<RemoveArticle>(_onRemoveArticle);
    on<GetSavedArticles>(_onGetSavedArticles);
  }

  Future<void> _onSaveArticle(SaveArticle event, Emitter<SavedArticleState> emit) async{
    try{
      emit(state.copyWith(status: SavedArticleStatus.initial, exception: null));
      final result = state.articles?.any((element) => element.title == event.articleEntity?.title);
      if(result == true){
        await sl<UpdateArticleUseCase>().call(params: event.articleEntity);
      }else {
        await sl<SaveArticleUseCase>().call(params: event.articleEntity);
      }
      add(const GetSavedArticles());
    }catch(e){
      emit(state.copyWith(status: SavedArticleStatus.failed, exception: e is AppException ? e : AppException(e)));
    }
  }

  Future<void> _onRemoveArticle(RemoveArticle event, Emitter<SavedArticleState> emit) async{
    try{
      emit(state.copyWith(status: SavedArticleStatus.initial, exception: null));
      await sl<RemoveArticleUseCase>().call(params: event.articleEntity);
      add(const GetSavedArticles());
    }catch(e){
      emit(state.copyWith(status: SavedArticleStatus.failed, exception: e is AppException ? e : AppException(e)));
    }
  }

  Future<void> _onGetSavedArticles(GetSavedArticles event, Emitter<SavedArticleState> emit) async{
    try{
      emit(state.copyWith(status: SavedArticleStatus.initial, exception: null));
      final getSavedArticlesUseCase = sl<GetSavedArticlesUseCase>();
      final response = await getSavedArticlesUseCase();
      if(response is DataSuccess){
        emit(state.copyWith(status: SavedArticleStatus.success, articles: response.data ?? []));
      }else{
        throw response.error ?? AppException("");
      }
    }catch(e){
      debugPrint("error : $e");
      emit(state.copyWith(status: SavedArticleStatus.failed, exception: e is AppException ? e : AppException(e)));
    }
  }
}
