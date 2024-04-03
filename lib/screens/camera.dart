import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;
  bool _isLoading = false;
  String _plantName = '';

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      _identifyPlant();
    }
  }

  Future<void> _identifyPlant() async {
    setState(() {
      _isLoading = true;
      _plantName = '';
    });

    try {
      final apiUrl = Uri.parse(
          'https://my-api.plantnet.org/v2/identify/all?api-key=2b102XrV1zcHuwVI8yxpuH8');

      // Converte l'immagine in base64
      List<int> imageBytes = await _imageFile!.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      // Crea il corpo della richiesta JSON
      Map<String, String> requestBody = {
        'images': base64Image,
      };

      final response = await http.post(
        apiUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final assetSelfLink = jsonResponse['results'][0]['links']['_self']['href'];
        await _activateAsset(assetSelfLink);
      } else {
        throw Exception('Failed to identify plant. Response: ${response.body}');
      }
    } catch (e) {
      print('Error identifying plant: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _activateAsset(String assetSelfLink) async {
    final response = await http.put(
      Uri.parse(assetSelfLink + '/activate'),
    );
    if (response.statusCode == 204) {
      await _pollAssetStatus(assetSelfLink);
    } else {
      throw Exception('Failed to activate asset. Response: ${response.body}');
    }
  }

  Future<void> _pollAssetStatus(String assetSelfLink) async {
    setState(() {
      _plantName = 'Attivazione in corso...';
    });

    while (true) {
      await Future.delayed(Duration(seconds: 5));
      final response = await http.get(
        Uri.parse(assetSelfLink),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final status = jsonResponse['status'];
        if (status == 'active') {
          final location = jsonResponse['location'];
          await _downloadImage(location);
          break;
        }
      } else {
        throw Exception('Failed to poll asset status. Response: ${response.body}');
      }
    }
  }

  Future<void> _downloadImage(String imageUrl) async {
    final response = await http.get(
      Uri.parse(imageUrl),
    );
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final appDir = await getApplicationDocumentsDirectory();
      final localFilePath = '${appDir.path}/plant_image.jpg';
      final imageFile = File(localFilePath);
      await imageFile.writeAsBytes(bytes);

      setState(() {
        _plantName = 'Immagine scaricata con successo: $localFilePath';
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to download image. Response: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _imageFile == null
                ? Text('Nessuna immagine selezionata')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.file(_imageFile!),
                      SizedBox(height: 20),
                      _plantName.isNotEmpty
                          ? Text(
                              'Nome della pianta: $_plantName',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              'Pianta non identificata',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                    ],
                  ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _getImage(ImageSource.camera),
            tooltip: 'Scatta foto',
            child: Icon(Icons.camera),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => _getImage(ImageSource.gallery),
            tooltip: 'Scegli dalla galleria',
            child: Icon(Icons.image),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Plant Identifier',
    home: CameraScreen(),
  ));
}
