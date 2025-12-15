import 'package:dartz/dartz.dart';
import 'package:pioneer_alpha_ltd_task/core/api_handler/base_repository.dart';
import 'package:pioneer_alpha_ltd_task/core/api_handler/failure.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/model/github_repo_response_model.dart';

abstract base class HomeInterface extends BaseRepository {
  Future<Either<DataCRUDFailure, List<GitHubRepoResponseModel>>> fetchTopRepositories();
}
