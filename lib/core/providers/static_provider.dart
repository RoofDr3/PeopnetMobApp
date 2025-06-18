import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/data/static_data.dart';
import 'package:peopnet/core/local_json_storage.dart';
import 'user_provider.dart';

final serviceListProvider =
    StateNotifierProvider<ServiceListNotifier, List<DummyService>>((ref) {
      final user = ref.watch(currentUserProvider);
      return ServiceListNotifier(user?.username);
    });

class ServiceListNotifier extends StateNotifier<List<DummyService>> {
  static const String _cartFile = 'cart.json';
  final String? username;
  ServiceListNotifier(this.username) : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final data = await LocalJsonStorage.readJson(_cartFile);
    if (data != null && username != null) {
      state = (data as List)
          .map((e) => DummyService.fromJson(e))
          .where((e) => e.username == username)
          .toList();
    }
  }

  Future<void> _saveCart() async {
    final data = await LocalJsonStorage.readJson(_cartFile) ?? [];
    // Hapus cart user ini, lalu tambah state saat ini
    final others = (data as List)
        .map((e) => DummyService.fromJson(e))
        .where((e) => e.username != username)
        .toList();
    final all = [...others, ...state];
    await LocalJsonStorage.writeJson(
      _cartFile,
      all.map((e) => e.toJson()).toList(),
    );
  }

  @override
  set state(List<DummyService> value) {
    super.state = value;
    _saveCart();
  }

  void addService(DummyService service) {
    state = [...state, service];
  }

  void clearCart() {
    state = [];
  }

  void removeAt(int index) {
    final temp = [...state];
    temp.removeAt(index);
    state = temp;
  }
}
