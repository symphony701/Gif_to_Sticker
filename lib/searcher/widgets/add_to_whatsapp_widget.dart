import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToWhatsAppWidget extends StatelessWidget {
  const AddToWhatsAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 70.0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.cyan,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(Icons.whatsapp_outlined,
                color: Colors.white, size: 30),
          ),
          Text(
            'Add to WhatsApp',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
