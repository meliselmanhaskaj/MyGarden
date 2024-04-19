import 'dart:convert';
import 'package:address_24/screens/calendar_screen.dart';
import 'package:address_24/services/get_plant_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'my_home_page.dart';
import 'recipesadd_screen.dart';
import 'history_screen.dart'; // Nuova schermata per lo storico

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final List<String> organs = ["flower", "leaf"];
  final String apiKey = "2b102XrV1zcHuwVI8yxpuH8";
  bool _isLoading = false;
  final List<Map<String, dynamic>> _plantData = [];
  final List<Map<String, dynamic>> _history = [];

  int _currentImageIndex = 0;
  bool _showImageDivider = false;

  Future<void> _identifyPlants(List<XFile> images) async {
    setState(() {
      _isLoading = true;
      _plantData.clear();
    });

    try {
      final apiUrl = Uri.parse(
          'https://my-api.plantnet.org/v2/identify/all?api-key=$apiKey');
      var formData = http.MultipartRequest('POST', apiUrl);

      for (int i = 0; i < images.length; i++) {
        formData.fields['organs'] = organs[i];
        formData.files
            .add(await http.MultipartFile.fromPath('images', images[i].path));
      }

      http.Response response =
          await http.Response.fromStream(await formData.send());

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('PIANTAA ${jsonResponse['results'][0]['images']}');

        final results = jsonResponse['results'];
        for (int i = 0; i < results.length; i++) {
          final plantName =
              results[i]['species']['scientificNameWithoutAuthor'];
          final score = results[i]['score'];
          final plantImage = await getPlantImage(plantName);


          _plantData.add({
            'originalImage': images,
            'plantName': plantName,
            'score': score,
            'image': plantImage
          });
        }

        _showImageDivider = _currentImageIndex > 0;

        if (_plantData.isNotEmpty) {
          final plantName = _plantData[0]['plantName'];
          final score = _plantData[0]['score'];

          _history.add({
            'plantName': plantName,
            'score': score,
            'imageIndex': _currentImageIndex,
            'image': _plantData[0]['image']
          });

          _showImageDivider = _currentImageIndex > 0;
        }

        _currentImageIndex++;

        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to identify plant. Response: ${response.body}');
      }
    } catch (e) {
      print('Error identifying plants: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<XFile>?> _pickImages() async {
    List<XFile>? images;
    final picker = ImagePicker();
    try {
      images = await picker.pickMultiImage();
    } catch (e) {
      print('Error picking images: $e');
    }
    return images;
  }

  Future<void> _captureImage() async {
    final picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _identifyPlants([image]);
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plant Identifier',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HistoryScreen(history: _history)),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _plantData.isEmpty
                ? const Text(
                    'Identify Your Plant!',
                    style: TextStyle(fontSize: 18),
                  )
                : ListView.builder(
                    itemCount: _plantData.length,
                    itemBuilder: (context, index) {
                      final plantName = _plantData[index]['plantName'];
                      final score =
                          (_plantData[index]['score'] * 100).toStringAsFixed(2);

                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Plant ${index + 1}:',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Name:',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                plantName,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Score: $score%',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Select Image Source'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      List<XFile>? images = await _pickImages();
                      if (images != null && images.isNotEmpty) {
                        _identifyPlants(images);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Pick from Gallery'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      _captureImage();
                      Navigator.pop(context);
                    },
                    child: const Text('Capture Image'),
                  ),
                ],
              ),
            ),
          );
        },
        tooltip: 'Add Image',
        child: const Icon(Icons.add_a_photo),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green[500],
      unselectedItemColor: Colors.blue,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 20.0,
      unselectedFontSize: 14.0,
      currentIndex: 3,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today, size: 28),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.nature, size: 28),
          label: 'My Garden',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book, size: 28),
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt, size: 28),
          label: 'Camera',
        ),
      ],
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage1(events: [])),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipesMainScreen()),
        );
      } else if (index == 3) {
        // Do nothing as we are already on this screen
      }
    });
  }
}
