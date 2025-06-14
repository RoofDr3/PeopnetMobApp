import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/static_data.dart';

// List user statis
final userListProvider = StateProvider<List<DummyUser>>(
  (ref) => [
    DummyUser(
      username: 'admin',
      password: 'admin123',
      email: 'admin@mail.com',
      alamat: 'Jl. Admin',
    ),
  ],
);

// State user yang sedang login
final currentUserProvider = StateProvider<DummyUser?>((ref) => null);

// List global untuk semua layanan yang didaftarkan
final serviceListProvider = StateProvider<List<DummyService>>((ref) => []);

// Untuk layanan yang dipilih (detail)
final selectedServiceProvider = StateProvider<DummyService?>((ref) => null);
