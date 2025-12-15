class GitHubRepoResponseModel {
  final int id;
  final String name;
  final String fullName;
  final String description;
  final int stargazersCount;
  final int forksCount;
  final DateTime updatedAt;
  final String htmlUrl;
  final RepoOwner owner;

  GitHubRepoResponseModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.stargazersCount,
    required this.forksCount,
    required this.updatedAt,
    required this.htmlUrl,
    required this.owner,
  });

  factory GitHubRepoResponseModel.fromJson(Map<String, dynamic> json) {
    return GitHubRepoResponseModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      stargazersCount: (json['stargazers_count'] as num?)?.toInt() ?? 0,
      forksCount: (json['forks_count'] as num?)?.toInt() ?? 0,
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      htmlUrl: json['html_url'] as String? ?? '',
      owner: RepoOwner.fromJson(json['owner'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'full_name': fullName,
      'description': description,
      'stargazers_count': stargazersCount,
      'forks_count': forksCount,
      'updated_at': updatedAt.toIso8601String(),
      'html_url': htmlUrl,
      'owner': owner.toJson(),
    };
  }
}

class RepoOwner {
  final String login;
  final String avatarUrl;
  final String htmlUrl;

  RepoOwner({
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
  });

  factory RepoOwner.fromJson(Map<String, dynamic> json) {
    return RepoOwner(
      login: json['login'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      htmlUrl: json['html_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'login': login,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
    };
  }
}

enum SortField { stars, updated }

class SortPreference {
  final SortField field;
  final bool ascending;

  const SortPreference({
    required this.field,
    required this.ascending,
  });
}
