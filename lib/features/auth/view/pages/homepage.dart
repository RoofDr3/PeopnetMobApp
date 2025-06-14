import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peopnet/core/providers/static_provider.dart';
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
          style: TextStyle(fontFamily: 'Lexendregular', color: Colors.white),
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
                    style: TextStyle(fontFamily: 'Lexendregular'),
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
                  onTap: () => Navigator.pushNamed(context, '/notif'),
                  child: buttonIcon(
                    Icon: Icon(
                      Icons.notification_important_outlined,
                      color: Colors.white,
                    ),
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
                        desc: "Deskripsi Retail...",
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/soho'),
                      child: viewCard(
                        color: Colors.grey,
                        title: "SOHO",
                        desc: "Deskripsi SOHO...",
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/dedicated'),
                      child: viewCard(
                        color: Colors.orange,
                        title: "DEDICATED",
                        desc: "Deskripsi Dedicated...",
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
