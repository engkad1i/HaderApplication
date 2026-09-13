import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hadeer/Student/SuccessS.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'Result_Screen.dart'; // ستبقى لصفحة الفشل أو الحالات الأخرى
// يمكنك إضافة import لصفحة النجاح إذا قمتِ بفصلها: import 'Success_Screen.dart';

class ScanAttendanceScreen extends StatefulWidget {
  const ScanAttendanceScreen({super.key});

  @override
  State<ScanAttendanceScreen> createState() => _ScanAttendanceScreenState();
}

class _ScanAttendanceScreenState extends State<ScanAttendanceScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _seconds = 80;
  Timer? _timer;
  bool _showLocationAlert = false;
  bool _isBarcodeScanned = false;
  bool _isLoadingLocation = false;

  final MobileScannerController _scannerController = MobileScannerController();

  // --- إحداثيات الموقع المستهدف ونصف القطر بالمتر ---
  final double _targetLatitude = 28.4060642;
  final double _targetLongitude = 45.9846725;
  final double _geofenceRadiusInMeters = 1000000.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 10, end: 270).animate(_animationController);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer?.cancel();
        if (!_isBarcodeScanned) {
          _navigateToFailure();
        }
      }
    });
  }

  // دالة أنيميشن فحص الموقع عند الضغط على Allow
  Future<void> _checkLocationWithAnimation() async {
    setState(() {
      _showLocationAlert = false;
      _isLoadingLocation = true; // تشغيل أنيميشن الفحص (Checking Location...)
    });

    bool isInsideGeoFence = false;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
          Position? position = await Geolocator.getLastKnownPosition();

          position ??= await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
          ).timeout(const Duration(seconds: 3));

          double distanceInMeters = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            _targetLatitude,
            _targetLongitude,
          );

          if (distanceInMeters <= _geofenceRadiusInMeters) {
            isInsideGeoFence = true; // الموقع داخل النطاق المستهدف
          }
        }
      }
    } catch (e) {
      print("Geolocator exception caught: $e");
      isInsideGeoFence = false;
    }

    // إجبار الأنيميشن على الاستمرار لمدة ثانيتين كاملتين كما طلبتِ
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoadingLocation = false; // إطفاء أنيميشن الفحص
      });

      // التحقق من النتيجة والتوجيه للصفحة المناسبة
      if (isInsideGeoFence) {
        _navigateToSuccess(); // توجيه لصفحة النجاح
      } else {
        _navigateToFailure(); // توجيه لصفحة الفشل
      }
    }
  }

  // التوجيه لصفحة النجاح الجديدة
  void _navigateToSuccess() {
    _timer?.cancel();
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SuccessScreen(),
      ),
    );
  }

  // التوجيه لصفحة الفشل (ResultScreen الأصلية مع تمرير false)
  void _navigateToFailure() {
    _timer?.cancel();
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ResultScreen(isSuccess: false),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    _scannerController.dispose();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMainInterface(),
          Positioned(
            width: 38, height: 38, left: 43, top: 59,
            child: GestureDetector(
              onTap: () {
                _scannerController.dispose();
                Navigator.pop(context);
              },
              child: Image.asset('assets/12.png', fit: BoxFit.contain),
            ),
          ),
          if (_showLocationAlert) _buildLocationAlertOverlay(),
          if (_isLoadingLocation) _buildLoadingLocationOverlay(),
        ],
      ),
    );
  }

  Widget _buildMainInterface() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF005D52), Color(0xFF00C3AC)],
          stops: [0.0145, 0.3702],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            width: 277, height: 155, left: 219, top: 10,
            child: Image.asset('assets/65.png', fit: BoxFit.contain),
          ),
          Positioned(
            top: 151, left: 0, right: 0, bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(70)),
              ),
              child: Stack(
                children: [
                  const Positioned(
                    top: 71, left: 0, right: 0,
                    child: Text(
                      'Scan Attendance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF005D52),
                        fontFamily: 'IBM Plex Sans',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 170, left: (MediaQuery.of(context).size.width - 280) / 2,
                    child: _buildQRScannerArea(),
                  ),
                  Positioned(
                    top: 576, left: 0, right: 0,
                    child: const Text(
                      'Scan The QR Code to Record\nYour Attendance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.3,
                        color: Color(0xFF212121),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 638, left: 0, right: 0,
                    child: Text(
                      _formatTime(_seconds),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF005D52),
                        fontFamily: 'IBM Plex Sans',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRScannerArea() {
    return SizedBox(
      width: 280, height: 280,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 220, height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: MobileScanner(
                  controller: _scannerController,
                  onDetect: (capture) async {
                    if (_isBarcodeScanned) return;

                    final barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                      _isBarcodeScanned = true;
                      _timer?.cancel();
                      await _scannerController.stop();

                      if (mounted) {
                        setState(() {
                          _showLocationAlert = true;
                        });
                      }
                    }
                  },
                ),
              ),
            ),
          ),
          _buildCorner(top: 0, left: 0, isTop: true, isLeft: true),
          _buildCorner(top: 0, right: 0, isTop: true, isLeft: false),
          _buildCorner(bottom: 0, left: 0, isTop: false, isLeft: true),
          _buildCorner(bottom: 0, right: 0, isTop: false, isLeft: false),
        ],
      ),
    );
  }

  Widget _buildCorner({double? top, double? left, double? right, double? bottom, required bool isTop, required bool isLeft}) {
    return Positioned(
      top: top, left: left, right: right, bottom: bottom,
      child: Container(
        width: 60, height: 60,
        decoration: BoxDecoration(
          border: Border(
            top: isTop ? const BorderSide(color: Color(0xFF005D52), width: 4) : BorderSide.none,
            bottom: !isTop ? const BorderSide(color: Color(0xFF005D52), width: 4) : BorderSide.none,
            left: isLeft ? const BorderSide(color: Color(0xFF005D52), width: 4) : BorderSide.none,
            right: !isLeft ? const BorderSide(color: Color(0xFF005D52), width: 4) : BorderSide.none,
          ),
          borderRadius: BorderRadius.only(
            topLeft: isTop && isLeft ? const Radius.circular(30) : Radius.zero,
            topRight: isTop && !isLeft ? const Radius.circular(30) : Radius.zero,
            bottomLeft: !isTop && isLeft ? const Radius.circular(30) : Radius.zero,
            bottomRight: !isTop && !isLeft ? const Radius.circular(30) : Radius.zero,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationAlertOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Hader Wants to Use Your Location to Record Your Attendance',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF005D52)),
                      onPressed: () {
                        _checkLocationWithAnimation();
                        setState(() => _showLocationAlert = true);// تشغيل التحقق أولاً ثم الانتقال للنجاح
                        _navigateToSuccess();
                      },
                      child: const Text('Allow', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() => _showLocationAlert = false);
                        _navigateToFailure(); // تحويل مباشر لصفحة الفشل عند الرفض
                      },
                      child: const Text('Don\'t Allow', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingLocationOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Container(
          width: 280,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF005D52)),
                strokeWidth: 4,
              ),
              SizedBox(height: 24),
              Text(
                'Checking Location...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF005D52),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

