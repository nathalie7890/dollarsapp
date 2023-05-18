import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(width: 5, color: Colors.white),
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('assets/images/bob_marley.jpg'),
                  fit: BoxFit.cover,
                )),
            child: GestureDetector(
              onTap: () {},
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Bob Marley",
          style: GoogleFonts.montserrat(
              color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 20),
        ),
        Text(
          "Premium",
          style: GoogleFonts.montserrat(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
              fontSize: 14),
        )
      ],
    );
  }
}
