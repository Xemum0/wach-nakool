import 'package:flutter/material.dart';
import 'review.dart';
import 'package:mobile_project/data/icons.dart';
import '../supabase/comments.dart';

class Comments extends StatefulWidget {
  final String recipeId;
  final String recipeName;
  final String recipeImage;

  const Comments({
    super.key,
    required this.recipeId,
    required this.recipeName,
    required this.recipeImage , 
  });

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  Future<List<Map<String, dynamic>>> _comments = Future.value([]);
  Future<double> _averageRating = Future.value(0.0);
  Future<int> _commentCount = Future.value(0);

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _loadComments() {
    setState(() {
      _comments = CommentsHelper.getRecipeComments(widget.recipeId);
      _averageRating = CommentsHelper.getRecipeAverageRating(widget.recipeId);
      _commentCount = CommentsHelper.getRecipeCommentCount(widget.recipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: BackArrow,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'التقييمات',
          style: TextStyle(
            color: Color(0xFFFD5D69),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Food details container
          Container(
            height: 200,
            padding: const EdgeInsets.all(16.0),
            color: Color(0xFFFD5D69),
            child: Row(
              children: [
                // Food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.recipeImage,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 120,
                        height: 120,
                        color: Colors.grey[300],
                        child: Icon(Icons.error),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                // Right side content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Recipe name
                      Text(
                        widget.recipeName,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // Rating stars and review count
                      FutureBuilder<double>(
                        future: _averageRating,
                        builder: (context, ratingSnapshot) {
                          return FutureBuilder<int>(
                            future: _commentCount,
                            builder: (context, countSnapshot) {
                              return Row(
                                children: [
                                  Row(
                                    children: List.generate(
                                      5,
                                      (index) => Icon(
                                        index < (ratingSnapshot.data ?? 0).floor()
                                            ? Icons.star
                                            : Icons.star_border,
                                        size: 18.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    '${countSnapshot.data ?? 0} تقييم',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 8.0),
                      // Add review button
                      ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewPage(
                                imageURL: widget.recipeImage,
                                recipeId: widget.recipeId,
                              ),
                            ),
                          );
                          if (result == true) {
                            _loadComments(); // Reload comments after adding a new one
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFFFD5D69),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'أضف تقييم',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1.0, color: Colors.grey),
          // Comments list
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _comments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('لا توجد تقييمات بعد'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final comment = snapshot.data![index];
                    return _buildCommentItem(
                      comment['username'],
                      comment['comment'],
                      double.tryParse(comment['rating'].toString())?.round() ?? 0,
                      comment['date'],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(String username, String comment, int rating, String date) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFFFD5D69),
          child: Text(username[0].toUpperCase(),
              style: const TextStyle(color: Colors.white)),
        ),
        title: Text('@$username'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment),
            const SizedBox(height: 4.0),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  size: 16.0,
                  color: Color(0xFFFD5D69),
                ),
              ),
            ),
            Text(date, style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
