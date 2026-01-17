// import 'package:flutter/material.dart';
// import '../theme/app_colors.dart';
//
// class CreatePostCard extends StatelessWidget {
//   const CreatePostCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Share Your Experience",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               maxLines: 3,
//               decoration: InputDecoration(
//                 hintText:
//                 "Share your farming experience, tips, or ask questions...",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton.icon(
//                   onPressed: () {},
//                   icon: const Icon(Icons.image),
//                   label: const Text("Add Image"),
//                 ),
//                 ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.cardGreen,
//                   ),
//                   onPressed: () {},
//                   icon: const Icon(Icons.send),
//                   label: const Text("Post"),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
