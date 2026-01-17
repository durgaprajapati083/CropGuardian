// import 'package:flutter/material.dart';
// import '../theme/app_colors.dart';
//
// class StatCard extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//
//   const StatCard({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.value,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(14),
//           child: Column(
//             children: [
//               Icon(icon, color: AppColors.cardGreen),
//               const SizedBox(height: 6),
//               Text(value,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold)),
//               Text(label, style: const TextStyle(color: Colors.grey)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
