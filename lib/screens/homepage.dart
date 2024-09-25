import 'package:flutter/material.dart';
import '../repository/image_repository.dart';
import '../services/pantone_database/db_helper.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pantoneDBHelper.initializePantoneDatabase();
  }

  final ImageRepository _imageRepository = ImageRepository();
  final PantoneDBHelper _pantoneDBHelper = PantoneDBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantone Book')),
      body: const Center(
        child: Text('No image selected.'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'fromCamera',
            onPressed: () {
              _imageRepository.pickImageFromCamera(context);
            },
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(width: 20.0,),
          FloatingActionButton(
            heroTag: 'fromGallery',
            onPressed: () {
              _imageRepository.pickImageFromGallery(context);
            },
            child: const Icon(Icons.image),
          ),
        ],
      ),
    );
  }
}