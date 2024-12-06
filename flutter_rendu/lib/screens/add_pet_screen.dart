import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPetScreen extends StatefulWidget {
  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerBioController = TextEditingController();

  String _gender = 'Male'; // Default value for gender

  @override
  void dispose() {
    // Dispose of controllers to free resources
    _nameController.dispose();
    _ageController.dispose();
    _colorController.dispose();
    _weightController.dispose();
    _locationController.dispose();
    _aboutController.dispose();
    _ownerNameController.dispose();
    _ownerBioController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Collect form data
      final String name = _nameController.text.trim();
      final int age = int.parse(_ageController.text.trim());
      final double weight =
          double.tryParse(_weightController.text.trim()) ?? 0.0;
      final String color = _colorController.text.trim();
      final String location = _locationController.text.trim();
      final String about = _aboutController.text.trim();
      final String ownerName = _ownerNameController.text.trim();
      final String ownerBio = _ownerBioController.text.trim();

      // Endpoint
      final url = Uri.parse('http://localhost:5001/api/dogs');

      try {
        // API request
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'name': name,
            'age': age,
            'gender': _gender,
            'color': color,
            'weight': weight,
            'location': location,
            'about': about,
            'owner': ownerName,
            'bio': ownerBio,
          }),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Pet added successfully!')),
          );
          // Optionally, clear the form
          _formKey.currentState?.reset();
          _nameController.clear();
          _ageController.clear();
          _colorController.clear();
          _weightController.clear();
          _locationController.clear();
          _aboutController.clear();
          _ownerNameController.clear();
          _ownerBioController.clear();
        } else {
          final errorMessage =
              json.decode(response.body)['message'] ?? 'An error occurred.';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add pet: $errorMessage')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Pet'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Dog Name', _nameController, Icons.pets),
                _buildTextField('Age', _ageController, Icons.calendar_today,
                    isNumber: true),
                _buildTextField('Color', _colorController, Icons.palette),
                _buildTextField('Weight (kg)', _weightController, Icons.scale,
                    isNumber: true),
                _buildGenderDropdown(),
                _buildTextField(
                    'Location', _locationController, Icons.location_on),
                _buildTextField('About', _aboutController, Icons.description,
                    maxLines: 3),
                _buildTextField(
                    'Owner Name', _ownerNameController, Icons.person),
                _buildTextField('Owner Bio', _ownerBioController, Icons.info,
                    maxLines: 2),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.teal),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        value: _gender,
        onChanged: (value) => setState(() => _gender = value!),
        items: ['Male', 'Female'].map((gender) {
          return DropdownMenuItem(value: gender, child: Text(gender));
        }).toList(),
        decoration: InputDecoration(
          labelText: 'Gender',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
// // }import 'dart:convert';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// class AddPetScreen extends StatefulWidget {
//   @override
//   _AddPetScreenState createState() => _AddPetScreenState();
// }

// class _AddPetScreenState extends State<AddPetScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _colorController = TextEditingController();
//   final TextEditingController _weightController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _aboutController = TextEditingController();
//   final TextEditingController _ownerNameController = TextEditingController();
//   final TextEditingController _ownerBioController = TextEditingController();

//   String _gender = 'Male'; // Default value for gender
//   XFile? _selectedImage; // Controller for selected image

//   @override
//   void dispose() {
//     // Dispose of controllers to free resources
//     _nameController.dispose();
//     _ageController.dispose();
//     _colorController.dispose();
//     _weightController.dispose();
//     _locationController.dispose();
//     _aboutController.dispose();
//     _ownerNameController.dispose();
//     _ownerBioController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _selectedImage = pickedFile;
//       }
//     });
//   }
//   Future<void> _submitForm() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       // Collect form data
//       final String name = _nameController.text.trim();
//       final int age = int.parse(_ageController.text.trim());
//       final double weight = double.tryParse(_weightController.text.trim()) ?? 0.0;
//       final String color = _colorController.text.trim();
//       final String location = _locationController.text.trim();
//       final String about = _aboutController.text.trim();
//       final String ownerName = _ownerNameController.text.trim();
//       final String ownerBio = _ownerBioController.text.trim();

//       // Endpoint
//       final url = Uri.parse('http://localhost:5001/api/dogs'); // Correct URL

//       try {
//         // API request
//         final request = http.MultipartRequest('POST', url)
//           ..fields['name'] = name
//           ..fields['age'] = age.toString()
//           ..fields['gender'] = _gender
//           ..fields['color'] = color
//           ..fields['weight'] = weight.toString()
//           ..fields['location'] = location
//           ..fields['about'] = about
//           ..fields['owner'] = ownerName
//           ..fields['bio'] = ownerBio;

//         if (_selectedImage != null) {
//           request.files.add(await http.MultipartFile.fromPath('image', _selectedImage!.path));
//         }
      
//         final response = await request.send();

//         if (response.statusCode == 201) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Pet added successfully!')),
//           );
//           // Optionally, clear the form
//           _formKey.currentState?.reset();
//           _nameController.clear();
//           _ageController.clear();
//           _colorController.clear();
//           _weightController.clear();
//           _locationController.clear();
//           _aboutController.clear();
//           _ownerNameController.clear();
//           _ownerBioController.clear();
//         } else {
//           final responseString = await response.stream.bytesToString();
//           final errorMessage = json.decode(responseString)['message'] ?? 'An error occurred.';
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to add pet: $errorMessage')),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('An error occurred: $e')),
//         );
//       }
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Pet'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 _buildTextField('Dog Name', _nameController, Icons.pets),
//                 _buildTextField('Age', _ageController, Icons.calendar_today, isNumber: true),
//                 _buildTextField('Color', _colorController, Icons.palette),
//                 _buildTextField('Weight (kg)', _weightController, Icons.scale, isNumber: true),
//                 _buildGenderDropdown(),
//                 _buildTextField('Location', _locationController, Icons.location_on),
//                 _buildTextField('About', _aboutController, Icons.description, maxLines: 3),
//                 _buildTextField('Owner Name', _ownerNameController, Icons.person),
//                 _buildTextField('Owner Bio', _ownerBioController, Icons.info, maxLines: 2),
//                 SizedBox(height: 20),
//                 _buildImagePicker(),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _submitForm,
//                   child: Text('Submit'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                     padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool isNumber = false, int maxLines = 1}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         maxLines: maxLines,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: Colors.teal),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return 'Please enter $label';
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildGenderDropdown() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: DropdownButtonFormField<String>(
//         value: _gender,
//         onChanged: (value) => setState(() => _gender = value!),
//         items: ['Male', 'Female'].map((gender) {
//           return DropdownMenuItem(value: gender, child: Text(gender));
//         }).toList(),
//         decoration: InputDecoration(
//           labelText: 'Gender',
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//     );
//   }

//   Widget _buildImagePicker() {
//     return Column(
//       children: [
//         _selectedImage != null
//             ? Image.file(File(_selectedImage!.path), width: 100, height: 100, fit: BoxFit.cover)
//             : Text('No image selected'),
//         SizedBox(height: 10),
//         ElevatedButton.icon(
//           onPressed: _pickImage,
//           icon: Icon(Icons.image, color: Colors.teal),
//           label: Text('Pick Image'),
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
//         ),
//       ],
//     );
//   }
// }
