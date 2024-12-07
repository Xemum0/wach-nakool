import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_project/styles/style.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddOnereciep extends StatefulWidget {
  const AddOnereciep({super.key});

  @override
  State<AddOnereciep> createState() => _AddOnereciepState();
}

class _AddOnereciepState extends State<AddOnereciep> {
  bool _isMenuVisible = false;
  List<XFile>? _videoFile = [];
  List<XFile>? _imageFiles = [];
  final ImagePicker _picker = ImagePicker();
  List<IngredientItem> ingredients = [];
  List<InstructionItem> instructions = [];
  // Controllers for form fields
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _carbController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _nutritionalValueController =
      TextEditingController();

  // Media selection method
  Future<void> _selectMedia() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.video_library),
                title: const Text('اختيار فيديو'),
                onTap: () {
                  Navigator.pop(context);
                  _pickVideo();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('اختيار صور'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImages();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Video selection method
  Future<void> _pickVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        File videoFile = File(video.path);
        int fileSize = await videoFile.length();

        if (fileSize <= 100 * 1024 * 1024) {
          // 100MB limit
          setState(() {
            _videoFile = [video];
          });
        } else {
          _showErrorDialog('حجم الفيديو يجب أن يكون أقل من 100MB.');
        }
      }
    } catch (e) {
      _showErrorDialog('حدث خطأ أثناء اختيار الفيديو.');
    }
  }

  // Image selection method
  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.length <= 3) {
        int totalSize = 0;
        for (var image in images) {
          File imageFile = File(image.path);
          totalSize += await imageFile.length();
        }

        if (totalSize <= 6 * 1024 * 1024) {
          // 3 * 2MB limit (6MB in total)
          setState(() {
            _imageFiles = images;
          });
        } else {
          _showErrorDialog('حجم الصور يجب أن يكون أقل من 6MB.');
        }
      } else {
        _showErrorDialog('يمكنك اختيار 3 صور فقط.');
      }
    } catch (e) {
      _showErrorDialog('حدث خطأ أثناء اختيار الصور.');
    }
  }

  // Error dialog method
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('خطأ'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('حسناً'),
            ),
          ],
        );
      },
    );
  }

  // Toggle menu visibility
  void _toggleMenu() {
    setState(() {
      _isMenuVisible = !_isMenuVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('اضافة وصفة', style: AppStyles.appBarstyle),
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow_back.svg',
            width: 16.0,
            height: 16.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Buttons for delete and publish
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _toggleMenu(),
                          style: AppStyles.editProfileButtonStyle,
                          child: const Text('حذف'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: AppStyles.editProfileButtonStyle,
                          onPressed: () => _toggleMenu(),
                          child: const Text('نشر'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Media Download Section
                  GestureDetector(
                    onTap: _selectMedia,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC6C9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _videoFile != null && _videoFile!.isNotEmpty
                                  ? Icons.video_library
                                  : _imageFiles != null &&
                                          _imageFiles!.isNotEmpty
                                      ? Icons.image
                                      : Icons.add_photo_alternate,
                              size: 40,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _videoFile != null && _videoFile!.isNotEmpty
                                  ? 'تم اختيار فيديو'
                                  : _imageFiles != null &&
                                          _imageFiles!.isNotEmpty
                                      ? 'تم اختيار صور (${_imageFiles!.length})'
                                      : 'اضف فيديو او صور',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 247, 31, 45)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Form fields for title, description, etc.
                  _buildFormField('العنوان', _titleController),
                  _buildFormField('وصف', _descriptionController),
                  _buildFormField('وقت الطبخ', _cookingTimeController),

                  // Integrating the new sections
                  Directionality(
                    textDirection:
                        TextDirection.rtl, // Apply RTL globally to this section
                    child: Column(
                      children: [
                        // المكونات Section
                        const Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, // Forces the text to the far right
                          children: [
                            Expanded(
                              child: Text(
                                "المكونات",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        _buildIngredientsSection(),

                        // التعليمات Section
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                "التعليمات",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        _buildInstructionsSection(),

                        // القيمة الغذائية Section
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                "القيمة الغذائية",
                                textAlign: TextAlign.right,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        _buildNutritionalValueSection(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          // Confirmation menu
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: _isMenuVisible ? 0 : -200,
            left: 0,
            right: 0,
            child: GestureDetector(
                onTap: _toggleMenu,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'هل أنت متأكد من هذا الإجراء؟',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: _toggleMenu,
                            style: AppStyles.editProfileButtonStyle,
                            child: const Text('إلغاء'),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Confirm action (delete or publish)
                              _toggleMenu();
                            },
                            style: AppStyles.editProfileButtonStyle,
                            child: const Text('تأكيد'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  } // Form field builder method

  Widget _buildFormField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.end, // Align the form elements to the right
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            textAlign: TextAlign.right, // Align the label text to the right
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            textAlign: TextAlign.right, // Align text input to the right
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFFC6C9), // Background color
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0), // Rounded corners
                borderSide: BorderSide.none, // Remove border color
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide.none, // Remove border color when focused
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers
    _titleController.dispose();
    _descriptionController.dispose();
    _cookingTimeController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    _nutritionalValueController.dispose();
    super.dispose();
  }

  Widget _buildIngredientsSection() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.end, // Align content to the right for RTL
      children: [
        for (int i = 0; i < ingredients.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: ingredients[i].nameController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'اسم المكون',
                      filled: true,
                      fillColor: const Color(0xFFFFC6C9),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    controller: ingredients[i].quantityController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'الكمية',
                      filled: true,
                      fillColor: const Color(0xFFFFC6C9),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/icons/trash.svg'),
                  onPressed: () => _removeIngredient(i),
                ),
              ],
            ),
          ),
        Align(
          alignment: Alignment.center, // Center the button
          child: ElevatedButton(
            onPressed: _addIngredient,
            style: AppStyles.editProfileButtonStyle,
            child: const Text(
              'إضافة مكون جديد +',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildInstructionsSection() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.end, // Align content to the right for RTL
      children: [
        for (int i = 0; i < instructions.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .end, // Align row content to the right for RTL
              children: [
                Expanded(
                  child: TextFormField(
                    controller: instructions[i].controller,
                    maxLines: null, // Allow multiple lines of input
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'تعليمات',
                      filled: true,
                      fillColor: const Color(0xFFFFC6C9),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/icons/trash.svg'),
                  onPressed: () => _removeInstruction(i),
                ),
              ],
            ),
          ),
        Align(
          alignment: Alignment.center, // Center the button
          child: ElevatedButton(
            onPressed: _addInstruction,
            style: AppStyles.editProfileButtonStyle,
            child: const Text(
              'إضافة تعليمات جديدة +',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildNutritionalValueSection() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.end, // Align content to the right for RTL
      children: [
        // Protein input
        _buildNutritionalInputField('بروتين', _proteinController),
        // Carbs input
        _buildNutritionalInputField('كارب', _carbController),
        // Fats input
        _buildNutritionalInputField('دهون', _fatController),
      ],
    );
  }

  Widget _buildNutritionalInputField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: label,
          alignLabelWithHint: true, // Aligns label with the hint
          filled: true,
          fillColor: const Color(0xFFFFC6C9),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'يرجى إدخال قيمة';
          }
          return null;
        },
      ),
    );
  }

  void _addIngredient() {
    setState(() {
      ingredients.add(IngredientItem());
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      ingredients.removeAt(index);
    });
  }

  void _removeInstruction(int index) {
    setState(() {
      instructions.removeAt(index);
    });
  }

  void _addInstruction() {
    setState(() {
      instructions.add(InstructionItem());
    });
  }
}

class IngredientItem {
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
}

class InstructionItem {
  TextEditingController controller = TextEditingController();
}
