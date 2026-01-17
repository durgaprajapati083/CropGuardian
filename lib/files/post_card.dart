// import 'package:flutter/material.dart';
//
// class PostCard extends StatelessWidget {
//   final String message;
//   final String time;
//
//   const PostCard({
//     super.key,
//     required this.message,
//     required this.time,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Anonymous",
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 4),
//             Text(time, style: const TextStyle(color: Colors.grey)),
//             const SizedBox(height: 10),
//             Text(message),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Icon(Icons.thumb_up_alt_outlined, size: 18),
//                 const SizedBox(width: 6),
//                 const Text("0"),
//                 const SizedBox(width: 20),
//                 Icon(Icons.comment_outlined, size: 18),
//                 const SizedBox(width: 6),
//                 const Text("Comment"),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
