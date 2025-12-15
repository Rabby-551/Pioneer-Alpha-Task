import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/model/github_repo_response_model.dart';

class RepoDetailScreen extends StatelessWidget {
  const RepoDetailScreen({super.key, required this.repo});

  final GitHubRepoResponseModel repo;

  String _formatDate(DateTime date) =>
      DateFormat('MM-dd-yyyy HH:mm').format(date.toLocal());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repo.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(repo.owner.avatarUrl),
                  radius: 30,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        repo.fullName,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text('Owner: ${repo.owner.login}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              repo.description.isNotEmpty
                  ? repo.description
                  : 'No description provided.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                _StatChip(
                  icon: Icons.star,
                  label: 'Stars',
                  value: repo.stargazersCount.toString(),
                ),
                _StatChip(
                  icon: Icons.share,
                  label: 'Forks',
                  value: repo.forksCount.toString(),
                ),
                _StatChip(
                  icon: Icons.update,
                  label: 'Updated',
                  value: _formatDate(repo.updatedAt),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Repository URL',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(repo.htmlUrl, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      avatar: Icon(icon, size: 18),
      label: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
