import 'package:flutter/material.dart';
import 'package:mobile_project/data/icons.dart';
import '../supabase/comments.dart';
import '../supabase/user.dart';
import '../data/functions.dart';

class ReviewPage extends StatefulWidget {
  final String recipeId;
  final String imageURL;
  const ReviewPage({super.key, required this.recipeId, required this.imageURL});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  bool? _isRecommended;
  bool _isSubmitting = false;

  Future<void> _submitReview() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء تحديد التقييم')),
      );
      return;
    }

    if (_commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء كتابة تعليق')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Get current user's username
      final currentUser = await UserHelper.getCurrentUser();
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('يجب تسجيل الدخول أولاً')),
        );
        return;
      }

      // Insert the comment
      final token = await getToken();
      if (token != null) {
        await CommentsHelper.insertComment(
          recipeId: widget.recipeId,
          comment: _commentController.text.trim(),
          rating: _rating.round().toString(),
          token: token, // Pass the token here
        );
      } else {
        print('User is not authenticated.');
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'شكراً لمراجعتك!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Icon(
                Icons.check_circle,
                size: 80,
                color: Color(0xFFFD5D69),
              ),
              const SizedBox(height: 8),
              Text(
                'مساعدتك تساعدنا على تحسين \n تجربة المستخدمين',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFD5D69),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // Close the popup
                Navigator.pop(context, true); // Go back with refresh signal
              },
              child: const Text(
                'العودة إلى التقييمات',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ. حاول مرة أخرى')),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
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
          'اترك تقييما',
          style: TextStyle(
            color: Color(0xFFFD5D69),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top container with pink background and burger image
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFFFD5D69), // Pink background
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.imageURL, // Replace with your food image path
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover, // Ensure the image is fully covered
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Center the rating section
            Center(
              child: Column(
                children: [
                  const Text(
                    'تقييمك العام',
                    style: TextStyle(
                      color: Colors.black, // Set text color to black
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center stars
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: IconButton(
                          icon: Icon(
                            index < _rating ? Icons.star : Icons.star_border,
                            color: Color(0xFFFD5D69),
                          ),
                          onPressed: () {
                            setState(() {
                              _rating = index + 1.0;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Comment section
            Container(
              width: 350,
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xFFFFC6C9).withOpacity(0.45),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Color(0xFFFD5D69)),
              ),
              child: TextField(
                controller: _commentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'أترك ملاحظاتك',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.all(8.0),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),

            // Question: هل تنصح بها؟
            Align(
              alignment: Alignment.centerRight,
              child: const Text(
                'هل تنصح بها؟',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isRecommended = true;
                    });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isRecommended == true
                          ? Color(0xFFFD5D69)
                          : Colors.transparent,
                      border: Border.all(color: Color(0xFFFD5D69), width: 2),
                    ),
                    child: Center(
                      child: _isRecommended == true
                          ? Icon(Icons.check, color: Colors.white, size: 14)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                const Text('نعم'),
                const SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isRecommended = false;
                    });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isRecommended == false
                          ? Color(0xFFFD5D69)
                          : Colors.transparent,
                      border: Border.all(color: Color(0xFFFD5D69), width: 2),
                    ),
                    child: Center(
                      child: _isRecommended == false
                          ? Icon(Icons.check, color: Colors.white, size: 14)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                const Text('لا'),
              ],
            ),
            const SizedBox(height: 16.0),

            // Send and Cancel buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFD5D69),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _isSubmitting ? null : _submitReview,
                  child: Text(
                    _isSubmitting ? 'جاري الإرسال...' : 'إرسال',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFFFD5D69),
                  ),
                  child: const Text('إلغاء'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
