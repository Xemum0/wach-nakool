import 'package:flutter/material.dart';
import 'package:mobile_project/data/icons.dart';
import 'package:get/get.dart';
import 'home.dart';
class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  bool? _isRecommended; // Null to handle initial state for Yes/No selection

  void _submitReview() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        content: const Column(
          mainAxisSize: MainAxisSize.min, // Shrink to fit content
          children: [
            // Title text
            Text(
              'شكراً لمراجعتك!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            // Check Icon
            Icon(
              Icons.check_circle,
              size: 80,
              color: Color(0xFFFD5D69), // Pink color
            ),
            SizedBox(height: 8),
            // Helper text
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
              backgroundColor: const Color(0xFFFD5D69), // Pink button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
            ),
            onPressed: () {
              Get.off(() => const Home());
            },
            child: const Text(
              'العودة إلى الرئيسية',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
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
        title: const Text(
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
                color: const Color(0xFFFD5D69), // Pink background
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/homescreen/burger.png', // Replace with your food image path
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
                            color: const Color(0xFFFD5D69),
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
                color: const Color(0xFFFFC6C9).withOpacity(0.45),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: const Color(0xFFFD5D69)),
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
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
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
                          ? const Color(0xFFFD5D69)
                          : Colors.transparent,
                      border: Border.all(color: const Color(0xFFFD5D69), width: 2),
                    ),
                    child: Center(
                      child: _isRecommended == true
                          ? const Icon(Icons.check, color: Colors.white, size: 14)
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
                          ? const Color(0xFFFD5D69)
                          : Colors.transparent,
                      border: Border.all(color: const Color(0xFFFD5D69), width: 2),
                    ),
                    child: Center(
                      child: _isRecommended == false
                          ? const Icon(Icons.check, color: Colors.white, size: 14)
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
                    backgroundColor: const Color(0xFFFD5D69),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _submitReview,
                  child: const Text(
                    'إرسال',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.off(() => const Home());//Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFFD5D69),
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
