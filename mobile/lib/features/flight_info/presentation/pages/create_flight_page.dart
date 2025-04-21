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

  String _selectedLanguage = 'English';
  final List<String> _languages = ['English', 'Amharic'];

  final Map<String, Map<String, String>> _translations = {
    'English': {
      'title': 'Flight Title',
      'example': 'Example',
      'exampleText': 'My first trip to America',
      'fromCountry': 'From Country',
      'fromCountryExample': 'Ethiopia',
      'toCountry': 'To Country',
      'toCountryExample': 'America',
      'date': 'Date',
      'createFlight': 'Create Flight',
      'questions': 'Questions',
      'question1': '1. What is the purpose of your visit?',
      'question2': '2. How long do you plan to stay?',
      'question3': '3. Do you have a return ticket?',
      'question4': '4. Where will you be staying during your visit?',
      'question5': '5. Are you traveling alone or with others?',
      'enterAnswer': 'Enter your answer here',
    },
    'Amharic': {
      'title': 'የበረራ ርዕስ',
      'example': 'ምሳሌ',
      'exampleText': 'ወደ አሜሪካ የመጀመሪያ ጉዞዬ',
      'fromCountry': 'ከሀገር',
      'fromCountryExample': 'ኢትዮጵያ',
      'toCountry': 'ወደ ሀገር',
      'toCountryExample': 'አሜሪካ',
      'date': 'ቀን',
      'createFlight': 'በረራ ይፍጠሩ',
      'questions': 'ጥያቄዎች',
      'question1': '1. የጉብኝትዎ አላማ ምንድነው?',
      'question2': '2. ለምን ጊዜ መቆየት ትፈልጋላችሁ?',
      'question3': '3. የመመለሻ ቲኬት አለዎት?',
      'question4': '4. በጉብኝትዎ ወቅት የምትቆዩበት ቦታ የት ነው?',
      'question5': '5. ብቻዎን ነው የምትጓዙት ወይስ ከሌሎች ጋር?',
      'enterAnswer': 'መልስዎን እዚህ ያስገቡ',
    },
  };

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
    final translations = _translations[_selectedLanguage]!;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          translations['createFlight']!,
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
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedLanguage,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      dropdownColor: Colors.grey[900],
                      style: TextStyle(color: Colors.white),
                      items: _languages.map((String language) {
                        return DropdownMenuItem<String>(
                          value: language,
                          child: Text(language),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedLanguage = newValue;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.swap_horiz, color: Colors.white),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedLanguage == 'English' ? 'Amharic' : 'English',
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[900],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      dropdownColor: Colors.grey[900],
                      style: TextStyle(color: Colors.white),
                      items: _languages.map((String language) {
                        return DropdownMenuItem<String>(
                          value: language,
                          child: Text(language),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedLanguage = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _titleController,
                label: translations['title']!,
                hint: translations['exampleText']!,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _fromCountryController,
                label: translations['fromCountry']!,
                hint: translations['fromCountryExample']!,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _toCountryController,
                label: translations['toCountry']!,
                hint: translations['toCountryExample']!,
              ),
              const SizedBox(height: 16),
              _buildDatePicker(translations['date']!),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              _buildQuestionField(
                controller: _answerControllers[0],
                question: translations['question1']!,
                hint: translations['enterAnswer']!,
              ),
              _buildQuestionField(
                controller: _answerControllers[1],
                question: translations['question2']!,
                hint: translations['enterAnswer']!,
              ),
              _buildQuestionField(
                controller: _answerControllers[2],
                question: translations['question3']!,
                hint: translations['enterAnswer']!,
              ),
              _buildQuestionField(
                controller: _answerControllers[3],
                question: translations['question4']!,
                hint: translations['enterAnswer']!,
              ),
              _buildQuestionField(
                controller: _answerControllers[4],
                question: translations['question5']!,
                hint: translations['enterAnswer']!,
              ),
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
                    translations['createFlight']!,
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

  Widget _buildQuestionField({
    required TextEditingController controller,
    required String question,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
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
              return 'Please enter your answer';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDatePicker(String label) {
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