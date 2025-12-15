import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:pioneer_alpha_ltd_task/core/api_handler/failure.dart';
import 'package:pioneer_alpha_ltd_task/core/constants/api_endpoints.dart';
import 'package:pioneer_alpha_ltd_task/core/services/app_pigeon/app_pigeon.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/interface/home_interface.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/model/github_repo_response_model.dart';

final class HomeServiceImpl extends HomeInterface {
  HomeServiceImpl({AppPigeon? appPigeon})
    : _appPigeon = appPigeon ?? Get.find<AppPigeon>();

  final AppPigeon _appPigeon;

  @override
  Future<Either<DataCRUDFailure, List<GitHubRepoResponseModel>>> fetchTopRepositories() {
    return asyncTryCatch(
      tryFunc: () async {
        final response = await _appPigeon.get(
          ApiEndpoints.githubTopRepositories,
          query: <String, dynamic>{
            'q': 'Flutter',
            'sort': 'stars',
            'order': 'desc',
            'per_page': 50,
          },
        );

        final data = response.data as Map<String, dynamic>?;
        final items = data?['items'] as List<dynamic>? ?? [];
        return items
            .map((dynamic e) => GitHubRepoResponseModel.fromJson(e as Map<String, dynamic>))
            .toList();
      },
    );
  }
}
