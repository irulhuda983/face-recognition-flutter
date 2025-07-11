import 'package:flutter/material.dart';
import 'package:absensi/pages/home_page.dart';
import 'package:absensi/pages/jurnal_page.dart';
import 'package:absensi/pages/profile_page.dart';
import 'package:absensi/pages/log_page.dart';
import 'package:absensi/pages/add_absensi_page.dart';
import 'package:absensi/widgets/add_absensi_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomePage(), JurnalPage(), LogPage(), ProfilePage()];

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AddAbsensiPage()));
    } else {
      setState(() {
        _selectedIndex = index > 2 ? index - 1 : index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color(0xffF9F9F9),
          body: _pages[_selectedIndex],
          bottomNavigationBar: Container(
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, 'assets/icons/homeIcon.svg'),
                _buildNavItem(1, 'assets/icons/jurnal.svg'),
                SizedBox(height: 48, width: 64),
                _buildNavItem(3, 'assets/icons/calendar.svg'),
                _buildNavItem(4, 'assets/icons/profile.svg'),
              ],
            ),
          ),
        ),

        // Floating AddAbsensiButton di atas bar
        Positioned(
          bottom: 35, // Geser ke atas dari BottomNavigationBar
          left: 0,
          right: 0,
          child: Center(
            child: AddAbsensiButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AddAbsensiPage()));
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(int actualIndex, String iconPath) {
    int pageIndex = actualIndex > 2 ? actualIndex - 1 : actualIndex;
    bool isSelected = _selectedIndex == pageIndex;

    return GestureDetector(
      behavior: HitTestBehavior.translucent, // penting agar area tak terlihat tetap bisa disentuh
      onTap: () => _onItemTapped(actualIndex),
      child: Container(
        width: 60, // pastikan cukup besar untuk tap
        height: 60,
        alignment: Alignment.center,
        child: SvgPicture.asset(
          iconPath,
          width: 28,
          height: 28,
          color: isSelected ? Color(0xFF0D0140) : Color(0xFFC4C4C4),
        ),
      ),
    );
  }
}
