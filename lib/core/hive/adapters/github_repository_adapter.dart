import 'package:hive/hive.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/model/github_repo_response_model.dart';

class GitHubRepoAdapter extends TypeAdapter<GitHubRepoResponseModel> {
  @override
  GitHubRepoResponseModel read(BinaryReader reader) {
    throw UnimplementedError();
  }

  @override

  int get typeId => throw UnimplementedError();

  @override
  void write(BinaryWriter writer, GitHubRepoResponseModel obj) {
    
  }
}