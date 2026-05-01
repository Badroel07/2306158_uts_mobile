import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final String label;
  final IconData ikon;
  final Color warna;
  final int nilai;

  const ChipWidget({
    super.key,
    required this.label,
    required this.ikon,
    required this.warna,
    required this.nilai,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: warna.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: warna.withOpacity(0.3)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(ikon, size: 16, color: warna),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              nilai.toString(),
              style: TextStyle(
                fontSize: 12,
                color: warna,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
