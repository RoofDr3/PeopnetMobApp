class DummyService {
  final String idPelanggan;
  final String nama;
  final String jenisLayanan;
  final String kapasitas;
  final String alamat;
  final String koordinat;
  final String
  username; // ← relasi user (atau: userId jika model user pakai id)

  DummyService({
    required this.idPelanggan,
    required this.nama,
    required this.jenisLayanan,
    required this.kapasitas,
    required this.alamat,
    required this.koordinat,
    required this.username,
  });

  factory DummyService.fromJson(Map<String, dynamic> json) => DummyService(
    idPelanggan: json['idPelanggan'] ?? '',
    nama: json['nama'] ?? '',
    jenisLayanan: json['jenisLayanan'] ?? '',
    kapasitas: json['kapasitas'] ?? '',
    alamat: json['alamat'] ?? '',
    koordinat: json['koordinat'] ?? '',
    username: json['username'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'idPelanggan': idPelanggan,
    'nama': nama,
    'jenisLayanan': jenisLayanan,
    'kapasitas': kapasitas,
    'alamat': alamat,
    'koordinat': koordinat,
    'username': username,
  };
}
