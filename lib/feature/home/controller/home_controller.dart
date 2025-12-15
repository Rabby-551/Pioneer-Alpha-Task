import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pioneer_alpha_ltd_task/core/api_handler/failure.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/interface/home_interface.dart';
import 'package:pioneer_alpha_ltd_task/feature/home/model/github_repo_response_model.dart';

class HomeController extends GetxController {
  HomeController(this._repository);

  final HomeInterface _repository;
  final RxList<GitHubRepoResponseModel> repositories = <GitHubRepoResponseModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isOffline = false.obs;
  final Rx<SortPreference> sortPreference =
      const SortPreference(field: SortField.stars, ascending: false).obs;

  late final Box _repoBox;
  late final Box _settingsBox;

  @override
  void onInit() {
    super.onInit();
    _repoBox = Hive.box('reposBox');
    _settingsBox = Hive.box('settingsBox');
    _loadPersistedSort();
    _loadCachedRepos();
    fetchRepositories();
  }

  Future<void> fetchRepositories() async {
    isLoading.value = true;
    errorMessage.value = '';
    isOffline.value = false;
    update();

    final result = await _repository.fetchTopRepositories();
    result.fold(
      (failure) {
        errorMessage.value = _getErrorMessage(failure);
        isOffline.value = repositories.isNotEmpty;
      },
      (data) async {
        repositories.assignAll(data);
        await _repoBox.put('repos', data);
        _applySorting();
      },
    );

    isLoading.value = false;
    update();
  }

  void _loadCachedRepos() {
    final cached = _repoBox.get('repos') as List<dynamic>?;
    if (cached != null && cached.isNotEmpty) {
      repositories.assignAll(cached.cast<GitHubRepoResponseModel>());
      _applySorting();
    }
  }

  void _loadPersistedSort() {
    final stored = _settingsBox.get('sort_pref') as SortPreference?;
    if (stored != null) {
      sortPreference.value = stored;
    }
  }

  void selectSortField(SortField field) {
    final current = sortPreference.value;
    final newPref = current.field == field
        ? SortPreference(field: field, ascending: !current.ascending)
        : SortPreference(field: field, ascending: false);

    sortPreference.value = newPref;
    _settingsBox.put('sort_pref', newPref);
    _applySorting();
  }

  void _applySorting() {
    final pref = sortPreference.value;
    final sorted = [...repositories];
    sorted.sort((a, b) {
      int compare;
      if (pref.field == SortField.stars) {
        compare = a.stargazersCount.compareTo(b.stargazersCount);
      } else {
        compare = a.updatedAt.compareTo(b.updatedAt);
      }
      return pref.ascending ? compare : -compare;
    });
    repositories.assignAll(sorted);
  }

  String _getErrorMessage(DataCRUDFailure failure) {
    switch (failure.failure) {
      case Failure.socketFailure:
      case Failure.timeout:
        return 'Network error. Please check your internet connection and try again.';
      case Failure.severFailure:
        return 'Server is currently unavailable. Please try again later.';
      case Failure.authFailure:
      case Failure.forbidden:
        return 'Session expired. Please log in again.';
      case Failure.noData:
        return 'No data available. Please try again later.';
      case Failure.outOfMemoryError:
        return 'Device memory is low. Please close some apps and try again.';
      default:
        return failure.uiMessage.isNotEmpty
            ? failure.uiMessage
            : 'An error occurred. Please try again.';
    }
  }
}
