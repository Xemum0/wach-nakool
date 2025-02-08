import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_project/styles/style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_project/supabase/category.dart';
import 'dart:io';
import 'dart:convert';

import 'package:mobile_project/supabase/reciepes.dart';

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
  String? _selectedCategoryId;
  List<Map<dynamic, dynamic>> _categories = [];
  final _formKey = GlobalKey<FormState>();

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

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final categories = await Categories_Helper.GetCategoriesNames();
    setState(() {
      _categories = categories;
    });
  }

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
              child: Form(
                key: _formKey, // Assign the form key
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _toggleMenu();
                              }
                            },
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
                    _buildFormField('العنوان', _titleController, isRequired: true),
                    _buildFormField('وصف', _descriptionController, isRequired: true),
                    _buildFormField('وقت الطبخ', _cookingTimeController, isRequired: true),
                    _buildCategoryDropdown(),

                    // Integrating the new sections
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          // المكونات Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  "التعليمات",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          _buildInstructionsSection(),

                          // القيمة الغذائية Section
                          Row(
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
                    ),
                  ],
                ),
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'هل أنت متأكد من هذا الإجراء؟',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                            if (_formKey.currentState!.validate()) {
                              _submitRecipe();
                              _toggleMenu();
                            }
                          },
                          style: AppStyles.editProfileButtonStyle,
                          child: const Text('تأكيد'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildFormField(String label, TextEditingController controller, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFFFC6C9),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
              if (isRequired && (value == null || value.isEmpty)) {
                return 'هذا الحقل مطلوب';
              }
              return null;
            },
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
Future<String> fileToBase64(File file) async {
  List<int> fileBytes = await file.readAsBytes();
  return base64Encode(fileBytes);
}

void _submitRecipe() async {
  // Gather data from form fields
  String title = _titleController.text;
  String description = _descriptionController.text;
  String cookingTime = _cookingTimeController.text;

  // Separate lists for ingredients and quantities
  List<String> ingredientsList = ingredients
      .map((ingredient) => ingredient.nameController.text)
      .toList();
  List<String> quantitiesList = ingredients
      .map((ingredient) => ingredient.quantityController.text)
      .toList();

  List<String> instructionsList = instructions
      .map((instruction) => instruction.controller.text)
      .toList();
  List<String> nutritionalValues = [
    _proteinController.text,
    _carbController.text,
    _fatController.text
  ];

  // Ensure a category is selected
  if (_selectedCategoryId == null) {
    _showErrorDialog('يرجى اختيار فئة');
    return;
  }

  // Convert video to Base64
  String? videoBase64;
  if (_videoFile != null && _videoFile!.isNotEmpty) {
    File videoFile = File(_videoFile!.first.path);
    videoBase64 = await fileToBase64(videoFile);
  }

  // Convert images to Base64
  List<String>? imageBase64List;
  if (_imageFiles != null && _imageFiles!.isNotEmpty) {
    imageBase64List = [];
    for (var image in _imageFiles!) {
      File imageFile = File(image.path);
      String base64Image = await fileToBase64(imageFile);
      imageBase64List.add(base64Image);
    }
  }

  // Submit the recipe with Base64 encoded images and video
  await addRecipe(
    category: _selectedCategoryId!,
    title: title,
    details: description,
    steps: instructionsList,
    ingredients: ingredientsList,
    quantity: quantitiesList,   
    nutritionalValues: nutritionalValues,
    time: cookingTime,
    rating: 0,
    userId: "1",
    subtitle: description.length > 20 ? description.substring(0, 20) + "..." : description,
    videoBase64: videoBase64,
    imageBase64List: imageBase64List,
  );

  // Show a success message or navigate to another screen
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('تمت إضافة الوصفة بنجاح!')),
  );
}
  Widget _buildIngredientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                        return 'اسم المكون مطلوب';
                      }
                      return null;
                    },
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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                        return 'الكمية مطلوبة';
                      }
                      return null;
                    },
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
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: _addIngredient,
            style: AppStyles.editProfileButtonStyle,
            child: const Text(
              'إضافة مكون جديد +',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
  Widget _buildInstructionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (int i = 0; i < instructions.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: instructions[i].controller,
                    maxLines: null,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'تعليمات',
                      filled: true,
                      fillColor: const Color(0xFFFFC6C9),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                        return 'التعليمات مطلوبة';
                      }
                      return null;
                    },
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
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: _addInstruction,
            style: AppStyles.editProfileButtonStyle,
            child: const Text(
              'إضافة تعليمات جديدة +',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
  Widget _buildNutritionalValueSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildNutritionalInputField('بروتين', _proteinController),
        _buildNutritionalInputField('كارب', _carbController),
        _buildNutritionalInputField('دهون', _fatController),
      ],
    );
  }

  Widget _buildNutritionalInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: label,
          filled: true,
          fillColor: const Color(0xFFFFC6C9),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
            return 'هذا الحقل مطلوب';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCategoryDropdown() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'الفئة',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCategoryId,
          onChanged: (String? newValue) {
            setState(() {
              _selectedCategoryId = newValue;
            });
          },
          items: _categories.map<DropdownMenuItem<String>>((category) {
            return DropdownMenuItem<String>(
              value: category['id'].toString(),
              child: Text(category['category']),
            );
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFFC6C9),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
      ],
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
