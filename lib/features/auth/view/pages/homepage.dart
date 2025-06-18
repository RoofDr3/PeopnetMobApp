import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/providers/user_provider.dart';
import '../../../../core/theme/app_pallete.dart';
import '../widget/widgetall.dart';
import 'accountpage.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const Accountpage()));
      setState(() {
        _selectedIndex = 0;
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Peopnet-Serve",
          style: TextStyle(fontFamily: 'Lexendbold', color: Colors.white),
        ),
        backgroundColor: Pallete.buttonColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Pallete.backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  buttonIcon(
                    Icon: Icon(Icons.person_2_outlined, color: Colors.white),
                  ),
                  SizedBox(width: 20),
                  Text(
                    user?.username ?? "Guest",
                    style: TextStyle(fontFamily: 'Lexendbold', fontSize: 18),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: buttonIcon(
                    Icon: Icon(Icons.home_outlined, color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/account'),
                  child: buttonIcon(
                    Icon: Icon(Icons.person_2_outlined, color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/cart'),
                  child: buttonIcon(
                    Icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/'),
                  child: buttonIcon(
                    Icon: Icon(Icons.logout, color: Colors.white),
                  ),
                ),
              ],
            ),
            Container(
              height: screenHeight * 0.50,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/retail'),
                      child: viewCard(
                        color: Colors.green,
                        title: "RETAIL",
                        desc:
                            "Layanan internet broadband yang ditujukan untuk kebutuhan rumah tangga atau pelanggan individu, dengan kecepatan stabil, harga terjangkau, dan proses instalasi yang mudah.",
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/soho'),
                      child: viewCard(
                        color: Colors.grey,
                        title: "SOHO",
                        desc:
                            "Layanan internet khusus untuk Small Office/Home Office (SOHO) yang membutuhkan koneksi lebih stabil dan cepat dibandingkan layanan rumahan, cocok untuk usaha kecil dan kantor skala kecil hingga menengah.",
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/dedicated'),
                      child: viewCard(
                        color: Colors.orange,
                        title: "DEDICATED",
                        desc:
                            "Layanan internet premium dengan bandwidth simetris, kecepatan tinggi, dan jaminan SLA (Service Level Agreement), sangat cocok untuk perusahaan besar, kantor, atau bisnis yang membutuhkan koneksi internet tanpa gangguan dan prioritas layanan teknis.",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Pallete.buttonColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, color: Colors.white),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: "profile",
          ),
        ],
      ),
    );
  }
}
