import 'package:flutter/material.dart';

class ManageSystemER2 extends StatefulWidget {
  final String name;
  final String role;
  final String id;
  final String title;
  final String currentStatus;

  const ManageSystemER2({
    super.key,
    required this.name,
    required this.role,
    required this.id,
    required this.title,
    required this.currentStatus,
  });

  @override
  State<ManageSystemER2> createState() => _ManageSystemER2State();
}

class _ManageSystemER2State extends State<ManageSystemER2> {
  late String _selectedStatus;
  
  // الألوان الموحدة
  final Color primaryGreen = const Color(0xFF005D52);
  final Color lightGreen = const Color(0xFF29776E);
  final Color surfaceGray = const Color(0xFFD9D9D9);

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.currentStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // --- الخلفية الخضراء الموحدة ---
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lightGreen, primaryGreen],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -50, top: 10,
              child: Image.asset('assets/65.png', width: 277, height: 155, fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const SizedBox()),
            ),
            Positioned(
              left: 43, top: 59,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38, height: 38,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]),
                  child: const Icon(Icons.arrow_back, color: Color(0xFF212121), size: 20),
                ),
              ),
            ),
            Positioned(
              top: 145, left: 0, right: 0, bottom: 0,
              child: Container(
                // --- الخلفية الرمادية/البيضاء الموحدة ---
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [surfaceGray, Colors.white, Colors.white, surfaceGray],
                  ),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 35),
                      
                      // --- العنوان بخط IBM Plex Sans وحجم 40 ---
                      Center(
                        child: Text(
                          'Manage Reports Error Report', 
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'IBM Plex Sans', 
                            fontWeight: FontWeight.bold, 
                            fontSize: 40, 
                            color: primaryGreen
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      _buildLabel('Report By :', primaryGreen),
                      const SizedBox(height: 8),
                      _buildInfoBox(
                        height: 120,
                        text: "Full Name: ${widget.name}\nID: ${widget.id}\nRole: ${widget.role}\nReport Title: ${widget.title}",
                      ),
                      const SizedBox(height: 20),
                      _buildLabel('Description of System Error Report :', primaryGreen),
                      const SizedBox(height: 8),
                      _buildInfoBox(height: 80, text: "The System Is Very Slow"),
                      const SizedBox(height: 20),
                      _buildLabel('Update Status :', primaryGreen),
                      const SizedBox(height: 5),
                      _buildStatusOption("In Progress", primaryGreen),
                      _buildStatusOption("Resolved", primaryGreen),
                      _buildStatusOption("Pending", primaryGreen),
                      const SizedBox(height: 30),
                      
                      // --- زر Update الموحد ---
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context, _selectedStatus);
                          },
                          child: Container(
                            width: 160,
                            height: 55,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [surfaceGray, Colors.white, Colors.white, surfaceGray],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.grey.withOpacity(0.5)),
                              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
                            ),
                            child: Center(
                              child: Text(
                                'Update', 
                                style: TextStyle(
                                  fontFamily: 'Tajawal', 
                                  fontStyle: FontStyle.italic, 
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 24, 
                                  color: primaryGreen
                                )
                              )
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, Color color) {
    return Text(text, style: TextStyle(fontFamily: 'Tajawal', fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, color: color, fontSize: 16));
  }

  Widget _buildInfoBox({required double height, required String text}) {
    return Container(
      width: double.infinity, height: height, padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFFCFDFDD), borderRadius: BorderRadius.circular(30)),
      child: Text(text, style: const TextStyle(fontFamily: 'Tajawal', fontStyle: FontStyle.italic, fontSize: 14, color: Color(0xFF505050), height: 1.5)),
    );
  }

  Widget _buildStatusOption(String status, Color color) {
    return Row(
      children: [
        Radio<String>(
          value: status,
          groupValue: _selectedStatus,
          activeColor: color,
          onChanged: (value) {
            setState(() { _selectedStatus = value!; });
          },
        ),
        Text(status, style: TextStyle(fontFamily: 'Tajawal', fontStyle: FontStyle.italic, fontWeight: FontWeight.w500, color: color, fontSize: 15)),
      ],
    );
  }
}