import 'package:flutter/material.dart';
import 'package:peopnet/core/data/static_data.dart';

class DetailService extends StatelessWidget {
  const DetailService({super.key});

  @override
  Widget build(BuildContext context) {
    final DummyService service =
        ModalRoute.of(context)!.settings.arguments as DummyService;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Layanan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${service.idPelanggan}'),
            Text('Nama: ${service.nama}'),
            Text('Layanan: ${service.jenisLayanan}'),
            Text('Kapasitas: ${service.kapasitas}'),
            Text('Alamat: ${service.alamat}'),
            Text('Koordinat: ${service.koordinat}'),
          ],
        ),
      ),
    );
  }
}
