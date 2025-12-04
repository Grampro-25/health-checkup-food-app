import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class FoodScanScreen extends StatefulWidget {
  const FoodScanScreen({super.key});

  @override
  State<FoodScanScreen> createState() => _FoodScanScreenState();
}

class _FoodScanScreenState extends State<FoodScanScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  CameraController? _cameraController;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      try {
        final cameras = await availableCameras();
        if (cameras.isNotEmpty) {
          _cameraController = CameraController(
            cameras.first,
            ResolutionPreset.high,
          );
          await _cameraController!.initialize();
          if (mounted) {
            setState(() {
              _isCameraInitialized = true;
            });
          }
        }
      } catch (e) {
        print('Error initializing camera: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Food'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.camera_alt), text: 'Camera'),
            Tab(icon: Icon(Icons.qr_code_scanner), text: 'Barcode'),
            Tab(icon: Icon(Icons.edit), text: 'Text Entry'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCameraTab(),
          _buildBarcodeTab(),
          _buildTextEntryTab(),
        ],
      ),
    );
  }

  Widget _buildCameraTab() {
    if (!_isCameraInitialized || _cameraController == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      children: [
        SizedBox.expand(
          child: CameraPreview(_cameraController!),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Center(
            child: FloatingActionButton.large(
              onPressed: _takePicture,
              backgroundColor: const Color(0xFF4CAF50),
              child: const Icon(Icons.camera, size: 40),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Point camera at food item or packaging',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBarcodeTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.qr_code_scanner,
              size: 100, color: Color(0xFF4CAF50)),
          const SizedBox(height: 24),
          const Text(
            'Barcode Scanner',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Scan product barcodes to get instant nutrition information',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _scanBarcode,
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Start Scanning'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextEntryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter Food Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Food Name',
              prefixIcon: Icon(Icons.restaurant),
              hintText: 'e.g., Apple, Chicken Breast',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Brand (Optional)',
              prefixIcon: Icon(Icons.business),
              hintText: 'e.g., Organic Valley',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Ingredients (Optional)',
              prefixIcon: Icon(Icons.list),
              hintText: 'Comma separated',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _analyzeFood,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
              ),
              child: const Text('Analyze Food'),
            ),
          ),
        ],
      ),
    );
  }

  void _takePicture() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        await _cameraController!.takePicture();
        if (mounted) {
          // Navigate to analysis screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Analyzing food...')),
          );
        }
      } catch (e) {
        print('Error taking picture: $e');
      }
    }
  }

  void _scanBarcode() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening barcode scanner...')),
    );
  }

  void _analyzeFood() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Analyzing food...')),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }
}
