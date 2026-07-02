import 'package:flutter/material.dart';
import 'package:app_messaging/core/enum/bottom_nav_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final BottomNavItem currentItem;
  final ValueChanged<BottomNavItem> onItemSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEAEAEA))),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildItem(
              item: BottomNavItem.messages,
              filledIcon: Icons.chat_bubble,
              outlinedIcon: Icons.chat_bubble_outline,
              label: "Messages",
            ),
          ),
          Expanded(
            child: _buildItem(
              item: BottomNavItem.contacts,
              filledIcon: Icons.person,
              outlinedIcon: Icons.person_outline,
              label: "Contacts",
            ),
          ),
          Expanded(
            child: _buildItem(
              item: BottomNavItem.settings,
              filledIcon: Icons.settings,
              outlinedIcon: Icons.settings_outlined,
              label: "Paramètres",
            ),
          ),
          Expanded(
            child: _buildItem(
              item: BottomNavItem.profile,
              filledIcon: Icons.account_circle,
              outlinedIcon: Icons.account_circle_outlined,
              label: "Profils",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required BottomNavItem item,
    required IconData filledIcon,
    required IconData outlinedIcon,
    required String label,
  }) {
    final selected = currentItem == item;

    return InkWell(
      onTap: () => onItemSelected(item),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selected ? filledIcon : outlinedIcon,
            color: selected ? Colors.blue : Colors.black54,
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: selected ? Colors.blue : Colors.black54,
              fontSize: 11,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
