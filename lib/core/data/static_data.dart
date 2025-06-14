// Static data untuk dummy user dan layanan

class DummyUser {
  final String username;
  final String password;
  final String email;
  final String alamat;

  DummyUser({
    required this.username,
    required this.password,
    required this.email,
    required this.alamat,
  });

  // Tambahkan method copyWith berikut:
  DummyUser copyWith({
    String? username,
    String? password,
    String? email,
    String? alamat,
  }) {
    return DummyUser(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      alamat: alamat ?? this.alamat,
    );
  }
}

class DummyService {
  final String idPelanggan;
  final String nama;
  final String jenisLayanan;
  final String kapasitas;
  final String alamat;
  final String koordinat;

  DummyService({
    required this.idPelanggan,
    required this.nama,
    required this.jenisLayanan,
    required this.kapasitas,
    required this.alamat,
    required this.koordinat,
  });
}
