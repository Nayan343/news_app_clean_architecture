import 'package:get_it/get_it.dart';
import 'package:news_app_clean_architecture/core/resources/network/dio_client.dart';
import 'package:news_app_clean_architecture/features/main/data/data_sources/app_database.dart';
import 'package:news_app_clean_architecture/features/main/data/data_sources/news_api_services.dart';
import 'package:news_app_clean_architecture/features/main/data/repositories/article_repository_impl.dart';
import 'package:news_app_clean_architecture/features/main/domain/repositories/article_repository.dart';
import 'package:news_app_clean_architecture/features/main/domain/use_cases/get_articles.dart';
import 'package:news_app_clean_architecture/features/main/domain/use_cases/get_saved_articles_use_case.dart';
import 'package:news_app_clean_architecture/features/main/domain/use_cases/remove_article_use_case.dart';
import 'package:news_app_clean_architecture/features/main/domain/use_cases/save_article_use_case.dart';
import 'package:news_app_clean_architecture/features/main/domain/use_cases/update_article_use_case.dart';
import 'package:news_app_clean_architecture/features/main/presentation/manager/article/article_bloc.dart';
import 'package:news_app_clean_architecture/features/main/presentation/manager/saved_article/saved_article_bloc.dart';

final sl = GetIt.instance;

Future<void> injectionContainer() async{
  // Sql Database
  final database = await $FloorAppDataBase.databaseBuilder("app_database.db").build();

  sl.registerSingleton<AppDataBase>(database);
  // DioClient
  sl.registerSingleton<DioClient>(DioClient());

  // ApiServices
  sl.registerSingleton<NewsApiServicesImpl>(NewsApiServicesImpl(sl<DioClient>()));

  // Repositories
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl<NewsApiServicesImpl>(), sl<AppDataBase>()));

  // Use Cases
  sl.registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(sl<ArticleRepository>()));
  sl.registerSingleton<GetSavedArticlesUseCase>(GetSavedArticlesUseCase(sl<ArticleRepository>()));
  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl<ArticleRepository>()));
  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl<ArticleRepository>()));
  sl.registerSingleton<UpdateArticleUseCase>(UpdateArticleUseCase(sl<ArticleRepository>()));

  // Bloc
  sl.registerSingleton<ArticleBloc>(ArticleBloc());
  sl.registerSingleton<SavedArticleBloc>(SavedArticleBloc());
}