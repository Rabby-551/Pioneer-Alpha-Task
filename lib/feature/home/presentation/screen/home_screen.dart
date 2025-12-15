import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:pioneer_alpha_ltd_task/feature/home/presentation/screen/repo_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Flutter Repositories'),
        actions: [
          Obx(
            () => IconButton(
              tooltip: homeController.sortPreference.value.ascending
                  ? 'Ascending'
                  : 'Descending',
              icon: Icon(
                homeController.sortPreference.value.ascending
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
              ),
              onPressed: () => homeController.selectSortField(
                homeController.sortPreference.value.field,
              ),
            ),
          ),
          PopupMenuButton<SortField>(
            onSelected: homeController.selectSortField,
            itemBuilder: (context) => [
              _buildSortItem(
                context,
                label: 'Star count',
                field: SortField.stars,
                controller: homeController,
              ),
              _buildSortItem(
                context,
                label: 'Last updated',
                field: SortField.updated,
                controller: homeController,
              ),
            ],
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: GetBuilder<HomeController>(
        builder: (_) => Obx(
          () => RefreshIndicator(
            onRefresh: homeController.fetchRepositories,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                if (homeController.isOffline.value)
                  Container(
                    width: double.infinity,
                    color: Colors.orange.withValues(alpha: 0.1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.wifi_off, color: Colors.orange),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Offline mode: showing cached data',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (homeController.errorMessage.isNotEmpty &&
                    homeController.repositories.isEmpty)
                  ErrorState(
                    message: homeController.errorMessage.value,
                    onRetry: homeController.fetchRepositories,
                  )
                else if (homeController.isLoading.value &&
                    homeController.repositories.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  ...homeController.repositories.map(
                    (repository) => RepositoryTile(
                      repository: repository,
                      onTap: () =>
                          Get.to(() => RepoDetailScreen(repo: repository)),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<SortField> _buildSortItem(
    BuildContext context, {
    required String label,
    required SortField field,
    required HomeController controller,
  }) {
    final isSelected = controller.sortPreference.value.field == field;
    return PopupMenuItem(
      value: field,
      child: Row(
        children: [
          if (isSelected) const Icon(Icons.check, size: 16),
          if (isSelected) const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}

class RepositoryTile extends StatelessWidget {
  const RepositoryTile({super.key, required this.repository, required this.onTap});
  final GitHubRepoResponseModel repository;
  final VoidCallback onTap;

  String _formatDate(DateTime date) =>
      DateFormat('MM-dd-yyyy HH:mm').format(date.toLocal());

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(repository.owner.avatarUrl),
        ),
        title: Text(repository.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(repository.owner.login),
            const SizedBox(height: 4),
            Text('Updated: ${_formatDate(repository.updatedAt)}'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const SizedBox(width: 4),
                Text(repository.stargazersCount.toString()),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.share, size: 16),
                const SizedBox(width: 4),
                Text(repository.forksCount.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
