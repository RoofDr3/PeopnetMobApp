import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/local_json_storage.dart';
import '../data/user_data.dart';

class UserListState {
  final List<AppUser> users;
  final bool isLoading;

  UserListState({required this.users, required this.isLoading});

  UserListState copyWith({List<AppUser>? users, bool? isLoading}) {
    return UserListState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final userListProvider = StateNotifierProvider<UserListNotifier, UserListState>(
  (ref) => UserListNotifier(),
);

class UserListNotifier extends StateNotifier<UserListState> {
  static const String _userFile = 'users.json';

  UserListNotifier() : super(UserListState(users: [], isLoading: true)) {
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    state = state.copyWith(isLoading: true);
    final data = await LocalJsonStorage.readJson(_userFile);
    if (data != null) {
      final loadedUsers = (data as List)
          .map((e) => AppUser.fromJson(e))
          .toList();
      state = UserListState(users: loadedUsers, isLoading: false);
    } else {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _saveUsers() async {
    await LocalJsonStorage.writeJson(
      _userFile,
      state.users.map((e) => e.toJson()).toList(),
    );
  }

  void addUser(AppUser user) {
    state = state.copyWith(users: [...state.users, user]);
    _saveUsers();
  }

  void updateUser(AppUser updated) {
    state = state.copyWith(
      users: [
        for (final u in state.users)
          if (u.username == updated.username) updated else u,
      ],
    );
    _saveUsers();
  }

  void removeUser(String username) {
    state = state.copyWith(
      users: state.users.where((u) => u.username != username).toList(),
    );
    _saveUsers();
  }
}

final currentUserProvider = StateProvider<AppUser?>((ref) => null);
