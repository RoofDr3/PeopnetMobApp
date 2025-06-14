import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/data/static_data.dart';
import 'package:peopnet/core/providers/static_provider.dart';

class RetailPage extends ConsumerStatefulWidget {
  const RetailPage({super.key});

  @override
  ConsumerState<RetailPage> createState() => _RetailPageState();
}

class _RetailPageState extends ConsumerState<RetailPage> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final alamatController = TextEditingController();
  final koordinatController = TextEditingController();

  final List<String> kapasitasOptions = [
    '10 Mbps',
    '20 Mbps',
    '30 Mbps',
    '50 Mbps',
    '100 Mbps',
  ];
  String? selectedKapasitas;

  @override
  void initState() {
    super.initState();
    final randomId = (Random().nextInt(900000) + 100000).toString();
    idController.text = randomId;
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    alamatController.dispose();
    koordinatController.dispose();
    super.dispose();
  }

  void _addService() {
    final service = DummyService(
      idPelanggan: idController.text,
      nama: nameController.text,
      jenisLayanan: 'Retail',
      kapasitas: selectedKapasitas ?? '',
      alamat: alamatController.text,
      koordinat: koordinatController.text,
    );

    ref.read(serviceListProvider.notifier).state = [
      ...ref.read(serviceListProvider),
      service,
    ];

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Layanan Retail berhasil ditambahkan ke Cart'),
      ),
    );
    Navigator.pushNamed(context, '/cart');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Layanan Retail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'ID Pelanggan'),
              readOnly: true,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: alamatController,
              decoration: const InputDecoration(labelText: 'Alamat'),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Kapasitas'),
              value: selectedKapasitas,
              items: kapasitasOptions
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (val) => setState(() => selectedKapasitas = val),
            ),
            TextField(
              controller: koordinatController,
              decoration: const InputDecoration(labelText: 'Koordinat'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addService,
              child: const Text('Tambah ke Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
