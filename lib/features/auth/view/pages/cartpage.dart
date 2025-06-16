import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/providers/static_provider.dart';
import 'package:peopnet/core/theme/app_pallete.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceList = ref.watch(serviceListProvider);

    void goToHome() {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }

    IconData getServiceIcon(String jenis) {
      switch (jenis.toLowerCase()) {
        case "retail":
          return Icons.home_filled;
        case "soho":
          return Icons.business_center_rounded;
        case "dedicated":
          return Icons.public_rounded;
        default:
          return Icons.wifi_rounded;
      }
    }

    return WillPopScope(
      onWillPop: () async {
        goToHome();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Layanan",
            style: TextStyle(fontFamily: 'Lexendbold', color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: goToHome,
          ),
          backgroundColor: Pallete.buttonColor,
        ),
        body: serviceList.isEmpty
            ? const Center(
                child: Text(
                  'Keranjang kosong',
                  style: TextStyle(fontFamily: 'Lexendregular', fontSize: 18),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 18,
                ),
                itemCount: serviceList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final service = serviceList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detailservice',
                        arguments: service,
                      );
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Card(
                      color: Pallete.gradient1.withOpacity(0.95),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 22,
                          horizontal: 20,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Pallete.buttonColor,
                              radius: 24,
                              child: Icon(
                                getServiceIcon(service.jenisLayanan),
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.nama,
                                    style: const TextStyle(
                                      fontFamily: 'Lexendbold',
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.badge_rounded,
                                        size: 17,
                                        color: Colors.blueGrey,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "ID: ${service.idPelanggan}",
                                        style: const TextStyle(
                                          fontFamily: 'Lexendregular',
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.speed_rounded,
                                        size: 17,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Kapasitas: ${service.kapasitas}",
                                        style: const TextStyle(
                                          fontFamily: 'Lexendregular',
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.wifi,
                                        size: 17,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        service.jenisLayanan,
                                        style: const TextStyle(
                                          fontFamily: 'Lexendregular',
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
