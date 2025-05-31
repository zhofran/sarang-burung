// lib/models/menu_item.dart
class MenuItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final int backgroundColor; // Hex warna background

  MenuItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.backgroundColor,
  });
}
