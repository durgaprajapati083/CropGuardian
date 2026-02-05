import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croupguardiandurgaprajapati/responsive_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'controllers/community_controller.dart';
import 'models/post_model.dart';

class CommunityScreen extends StatelessWidget {
  final controller = Get.put(CommunityController());
  final String currentUid = FirebaseAuth.instance.currentUser?.uid ?? "";

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      child: Scaffold(
        // UI TIP: Using a slightly off-white/grey background makes the white cards "pop"
        backgroundColor: const Color(0xFFF2F4F7),
        appBar: AppBar(
          title: const Text(
            "Kisan Community",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          centerTitle: true,
          backgroundColor: Colors.green[900],
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        body: Obx(() {
          if (controller.posts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            // UI TIP: Makes scrolling feel smooth like iOS
            itemCount: controller.posts.length,
            itemBuilder: (context, index) =>
                _postCard(context, controller.posts[index]),
          );
        }),
        floatingActionButton: FloatingActionButton.extended(
          // UI TIP: "Extended" FAB looks more modern than just a circle
          label: const Text("Post",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
          icon: const Icon(Icons.add_a_photo,color: Colors.white,),
          backgroundColor: Colors.green[900],
          onPressed: () => _showPostSheet(context),
        ),
      ),
    );
  }

  // --- BEAUTIFUL POST CARD WIDGET ---
  Widget _postCard(BuildContext context, PostModel post) {
    bool isLiked = post.likedBy.contains(currentUid);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: User Info
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.green,
                  width: 2,
                ), // Theme Border
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.green[50],
                  // Ensure 'post.userProfile' matches the field name in your PostModel
                  backgroundImage:
                      (post.userProfile != null && post.userProfile!.isNotEmpty)
                      ? NetworkImage(post.userProfile!)
                      : null,
                  child: (post.userProfile == null || post.userProfile!.isEmpty)
                      ? Text(post.userName[0].toUpperCase())
                      : null,
                ),
              ),
            ),
            title: Text(
              post.userName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              DateFormat('hh:mm a, dd MMM').format(post.createdAt),
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            trailing: post.userId == currentUid
                ? PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showEditDialog(context, post,controller);
                      } else if (value == 'delete') {
                        _confirmDelete(context, post.id,controller);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 8),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red, size: 20),
                            SizedBox(width: 8),
                            Text("Delete", style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  )
                : null,
          ),

          // Body: Text Content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              post.content,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ),

          // IMAGE SECTION: Hero animation for smooth full-screen transition
          if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
            GestureDetector(
              onTap: () => Get.to(
                () => FullScreenImage(imageUrl: post.imageUrl!, tag: post.id),
              ),
              child: Hero(
                tag: post.id, // THE MAGIC: Connects to full screen
                child: Image.network(
                  post.imageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 250,
                      color: Colors.grey[100],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                ),
              ),
            ),

          const Divider(height: 1),

          // INTERACTION BAR
          Container(
            color: Colors.grey[50],
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _interactionBtn(
                  icon: isLiked ? Icons.favorite : Icons.favorite_border,
                  label: "${post.likedBy.length} Likes",
                  color: isLiked ? Colors.red : Colors.grey[700]!,
                  onTap: () => controller.toggleLike(post),
                ),
                _interactionBtn(
                  icon: Icons.mode_comment_outlined,
                  label: "${post.commentCount} Comments",
                  color: Colors.grey[700]!,
                  onTap: () => _viewComments(context, post),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- REUSABLE INTERACTION BUTTON ---
  Widget _interactionBtn({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPostSheet(BuildContext context) {
    final textController = TextEditingController();
    Rx<File?> img = Rx<File?>(null);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Create Post",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: textController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "What's on your farm today?",
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.green),
                    onPressed: () async {
                      img.value = await controller.pickImage(
                        ImageSource.camera,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.image, color: Colors.green),
                    onPressed: () async {
                      img.value = await controller.pickImage(
                        ImageSource.gallery,
                      );
                    },
                  ),
                  const Spacer(),
                  Obx(
                    () => img.value != null
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const SizedBox(),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Obx(
                () => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[800],
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () => controller.submitPost(
                          textController.text,
                          img.value,
                        ),
                        child: const Text(
                          "Post Update",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _viewComments(BuildContext context, PostModel post) {
    final textController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          children: [
            Text(
              "Comments (${post.commentCount})",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Divider(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("community_posts")
                    .doc(post.id)
                    .collection("comments")
                    .orderBy("createdAt", descending: true)
                    .snapshots(),
                builder: (context, snap) {
                  if (!snap.hasData)
                    return const Center(child: CircularProgressIndicator());
                  return ListView.builder(
                    itemCount: snap.data!.docs.length,
                    itemBuilder: (context, i) {
                      var d = snap.data!.docs[i].data() as Map<String, dynamic>;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green[50],
                          // Checks if userProfile exists and is not empty
                          backgroundImage:
                              (d['userProfile'] != null &&
                                  d['userProfile'] != "")
                              ? NetworkImage(d['userProfile'])
                              : null,
                          child:
                              (d['userProfile'] == null ||
                                  d['userProfile'] == "")
                              ? Text(
                                  d['userName'][0].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),
                        title: Text(
                          d['userName'] ?? "Farmer",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        subtitle: Text(d['text'] ?? ""),
                      );
                    },
                  );
                },
              ),
            ),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: "Add a comment...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      controller.addComment(post.id, textController.text);
                      textController.clear();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PRESENTATION: This class handles the Zoomable Full Screen View
class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const FullScreenImage({required this.imageUrl, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Makes the image stand out
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: tag, // Connects back to the same tag in the _postCard
          child: InteractiveViewer(
            // PRESENTATION: Allows users to pinch-to-zoom and pan the image
            panEnabled: true,
            minScale: 0.5,
            maxScale: 4.0,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    );
  }
}

void _showEditDialog(
  BuildContext context,
  PostModel post,
  CommunityController controller,
) {
  final editController = TextEditingController(text: post.content);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Edit Post"),
      content: TextField(
        controller: editController,
        maxLines: 3,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Update your post...",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            controller.updatePost(post.id, editController.text);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text("Update"),
        ),
      ],
    ),
  );
}

void _confirmDelete(BuildContext context, String postId, CommunityController controller) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete Post?"),
      content: const Text(
        "Are you sure you want to remove this post? This action cannot be undone.",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            controller.deletePost(postId);
            Navigator.pop(context);
          },
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
