import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserHeaderCard extends StatelessWidget {
  final String userName;
  final String profileImage;
  final String greetingText;
  final String wavingEmoji;
  final String farmerImage;
  final String companyLogo;

  const UserHeaderCard({
    super.key,
    required this.userName,
    required this.profileImage,
    required this.greetingText,
    required this.wavingEmoji,
    required this.farmerImage,
    required this.companyLogo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0D593D), // Warna hijau dari desain
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        children: [

          // Bubble Dekoratif Kiri Bawah
          Positioned(
            bottom: -60,
            left: -40,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFF1AB27A),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Bubble Dekoratif Kanan Bawah
          Positioned(
            bottom: -70,
            right: -35,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color(0xFF1AB27A), // Warna hijau dari desain
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Background utama dengan rounded di bagian bawah
          Container(
            padding: const EdgeInsets.all(16),
            height: 140,
            child: SafeArea(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey[200], // Jika gambar gagal dimuat
                    child: ClipOval(
                      child: Image.network(
                        profileImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/default_profile.png', // Gambar default
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            greetingText,
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            wavingEmoji,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Text(
                        userName,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Image.asset(
                  //   farmerImage,
                  //   height: 80,
                  //   width: 80,
                  //   fit: BoxFit.cover,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}