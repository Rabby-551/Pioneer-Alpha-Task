import 'package:hive/hive.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/model/github_repo_response_model.dart';

class GitHubRepoAdapter extends TypeAdapter<GitHubRepoResponseModel> {
  @override
  final int typeId = 0;

  @override
  GitHubRepoResponseModel read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();
    final fullName = reader.readString();
    final description = reader.readString();
    final stargazersCount = reader.readInt();
    final forksCount = reader.readInt();
    final updatedAt = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final htmlUrl = reader.readString();
    final owner = reader.read() as RepoOwner;
    return GitHubRepoResponseModel(
      id: id,
      name: name,
      fullName: fullName,
      description: description,
      stargazersCount: stargazersCount,
      forksCount: forksCount,
      updatedAt: updatedAt,
      htmlUrl: htmlUrl,
      owner: owner,
    );
    
  }


    @override
  void write(BinaryWriter writer, GitHubRepoResponseModel obj) {
    writer
      ..writeInt(obj.id)
      ..writeString(obj.name)
      ..writeString(obj.fullName)
      ..writeString(obj.description)
      ..writeInt(obj.stargazersCount)
      ..writeInt(obj.forksCount)
      ..writeInt(obj.updatedAt.millisecondsSinceEpoch)
      ..writeString(obj.htmlUrl)
      ..write(obj.owner);
  }
}

class RepoOwnerAdapter extends TypeAdapter<RepoOwner> {

 @override
  final int typeId = 1;

  @override
  RepoOwner read(BinaryReader reader) {
    final login = reader.readString();
    final avatarUrl = reader.readString();
    final htmlUrl = reader.readString();
    return RepoOwner(login: login, avatarUrl: avatarUrl, htmlUrl: htmlUrl);
  }



@override
  void write(BinaryWriter writer, RepoOwner obj) {
    writer
      ..writeString(obj.login)
      ..writeString(obj.avatarUrl)
      ..writeString(obj.htmlUrl);
  }
}

class SortPreferenceAdapter extends TypeAdapter<SortPreference> {

  @override
  final int typeId = 2;

  @override
  SortPreference read(BinaryReader reader) {
    final fieldIndex = reader.readInt();
    final ascending = reader.readBool();
    final field = SortField.values[fieldIndex];
    return SortPreference(field: field, ascending: ascending);
  }


 @override
  void write(BinaryWriter writer, SortPreference obj) {
    writer
      ..writeInt(obj.field.index)
      ..writeBool(obj.ascending);
  }
}