import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/local_json_storage.dart';
import '../data/static_data.dart';

final serviceListProvider =
    StateNotifierProvider<ServiceListNotifier, List<DummyService>>((ref) {
      return ServiceListNotifier();
    });

class ServiceListNotifier extends StateNotifier<List<DummyService>> {
  static const String _cartFile = 'cart.json';
  ServiceListNotifier() : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final data = await LocalJsonStorage.readJson(_cartFile);
    if (data != null) {
      state = (data as List).map((e) => DummyService.fromJson(e)).toList();
    }
  }

  Future<void> _saveCart() async {
    await LocalJsonStorage.writeJson(
      _cartFile,
      state.map((e) => e.toJson()).toList(),
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
