import 'package:flutter/material.dart';
import 'package:peopnet/core/data/static_data.dart';
import 'package:peopnet/core/theme/app_pallete.dart';

class DetailService extends StatelessWidget {
  const DetailService({super.key});

  @override
  Widget build(BuildContext context) {
    final DummyService service =
        ModalRoute.of(context)!.settings.arguments as DummyService;

    // Icon berdasarkan jenis layanan
    IconData getServiceIcon(String jenis) {
      switch (jenis.toLowerCase()) {
        case "retail":
          return Icons.home;
        case "soho":
          return Icons.business_center;
        case "dedicated":
          return Icons.public;
        default:
          return Icons.wifi;
      }
    }

    // Deskripsi singkat layanan
    String getDeskripsi(String jenis) {
      switch (jenis.toLowerCase()) {
        case "retail":
          return "Internet broadband untuk rumah tangga, harga terjangkau dan instalasi mudah.";
        case "soho":
          return "Internet untuk usaha kecil dan kantor rumahan, lebih stabil & cepat.";
        case "dedicated":
          return "Internet premium dengan SLA, kecepatan tinggi & bandwidth simetris.";
        default:
          return "-";
      }
    }

    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Detail Layanan",
          style: TextStyle(fontFamily: 'Lexendbold', color: Colors.white),
        ),
        backgroundColor: Pallete.buttonColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Pallete.gradient1,
                      radius: 36,
                      child: Icon(
                        getServiceIcon(service.jenisLayanan),
                        color: Colors.white,
                        size: 38,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: Text(
                      service.jenisLayanan,
                      style: const TextStyle(
                        fontFamily: 'Lexendbold',
                        fontSize: 22,
                        color: Colors.black87,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      getDeskripsi(service.jenisLayanan),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Lexendregular',
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  const Divider(height: 32, thickness: 1.2),
                  _detailRow("ID Pelanggan ", service.idPelanggan),
                  _detailRow("Nama : ", service.nama),
                  _detailRow("Kapasitas : ", service.kapasitas),
                  _detailRow("Alamat : ", service.alamat),
                  _detailRow("Koordinat : ", service.koordinat),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget baris data detail
  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              " $label",
              style: const TextStyle(
                fontFamily: 'Lexendbold',
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Lexendregular',
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
