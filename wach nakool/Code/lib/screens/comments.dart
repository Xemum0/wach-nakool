import 'package:flutter/material.dart';
import 'review.dart';
import 'package:mobile_project/data/icons.dart';

class Comments extends StatelessWidget {
  const Comments({super.key});

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
        title: const Text(
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
          // Food details container with height 200px
          Container(
            height: 200,
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFFFD5D69), // Pink background
            child: Row(
              children: [
                // Food image on the left
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/homescreen/burger.png', // Replace with your food image path
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16.0),
                // Right side content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Food name
                      const Text(
                        'برجر دجاج', // Replace with your food name
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // White text
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // Rating stars and number of reviews
                      Row(
                        children: [
                          // Stars
                          Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star,
                                size: 18.0,
                                color: Colors.white, // White stars
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          // Number of reviews
                          const Text(
                            '100 reviews', // Replace with total review count
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white, // White text
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      // Add review button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ReviewPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // White button
                          foregroundColor: const Color(0xFFFD5D69), // Pink text
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
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildCommentItem(
                    'samir', 'Lorem ipsum dolor sit amet', 4, 'قبل 15 ساعة'),
                _buildCommentItem(
                    'halim', 'Consectetur adipiscing elit', 5, 'قبل 2 يوم'),
                _buildCommentItem(
                    'sarah', 'Praesent tincidunt purus', 3, 'قبل 1 سنة'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(
      String user, String comment, int rating, String time) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFFD5D69),
          child: Text(user[0].toUpperCase(),
              style: const TextStyle(color: Colors.white)),
        ),
        title: Text('@$user'),
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
                        color: const Color(0xFFFD5D69),
                      )),
            ),
            Text(time,
                style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
