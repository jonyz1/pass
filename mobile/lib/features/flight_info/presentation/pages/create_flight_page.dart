import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/core/theme/app_colors.dart';

class CreateFlightPage extends StatefulWidget {
  const CreateFlightPage({super.key});

  @override
  State<CreateFlightPage> createState() => _CreateFlightPageState();
}

class _CreateFlightPageState extends State<CreateFlightPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _fromCountryController = TextEditingController();
  final _toCountryController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final List<TextEditingController> _answerControllers = List.generate(
    5,
    (index) => TextEditingController(),
  );

  final List<Map<String, String>> _questions = [
    {
      "englishQuestion": "What is the purpose of your visit?",
      "amharicQuestion": "የመጎብኘትዎ ዓላማ ምንድነው?",
    },
    {
      "englishQuestion": "How long do you plan to stay during your visit?",
      "amharicQuestion": "በመጎብኘትዎ እንድምር የትኛው ወቅት እንዳትቆዩ እቅፍ ነው?",
    },
    {
      "englishQuestion": "Do you have a return ticket?",
      "amharicQuestion": "የመመለስ ቲኬት አለዎት?",
    },
    {
      "englishQuestion": "Where will you be staying during your visit?",
      "amharicQuestion": "በመጎብኘትዎ ጊዜ የት ትኖራላችሁ?",
    },
    {
      "englishQuestion": "Are you traveling alone or with others?",
      "amharicQuestion": "ብቻዎትን ነው ወይስ ከሌሎች ጋር ትጓዛላችሁ?",
    },
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _fromCountryController.dispose();
    _toCountryController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Create New Flight',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _titleController,
                label: 'Flight Title',
                hint: 'e.g., My First Trip to USA',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _fromCountryController,
                label: 'From Country',
                hint: 'e.g., Ethiopia',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _toCountryController,
                label: 'To Country',
                hint: 'e.g., USA',
              ),
              const SizedBox(height: 16),
              _buildDatePicker(),
              const SizedBox(height: 24),
              Text(
                'Questions & Answers',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(_questions.length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _questions[index]['englishQuestion']!,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _questions[index]['amharicQuestion']!,
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _answerControllers[index],
                      label: 'Your Answer',
                      hint: 'Enter your answer here',
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Implement flight creation logic
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Create Flight',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.white54),
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                  style: GoogleFonts.inter(color: Colors.white),
                ),
                Icon(Icons.calendar_today, color: Colors.white70),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 