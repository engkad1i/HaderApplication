import 'package:flutter/material.dart';
import 'success_downloaded.dart'; 
import 'export_service.dart'; // تأكدي من استيراد ملف الخدمة هنا

class DailyAttendanceScreen2 extends StatelessWidget {
  final String courseId;
  final String sectionId;
  final String lectureId;

  const DailyAttendanceScreen2({
    super.key,
    required this.courseId,
    required this.sectionId,
    required this.lectureId,
  });

  @override
  Widget build(BuildContext context) {
    const BoxDecoration figmaGradientDecoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFD9D9D9),
          Color(0xFFFFFFFF),
          Color(0xFFFFFFFF),
          Color(0xFFD9D9D9),
        ],
        stops: [0.0, 0.4375, 0.9279, 1.0],
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          // 1. الخلفية الخضراء
          Container(
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
          ),

          // الشعار
          Positioned(
            top: -30,
            right: -50,
            child: Image.asset('assets/65.png', width: 260, height: 260),
          ),

          // العودة
          Positioned(
            top: 60,
            left: 25,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                
                child: Image.asset(
               'assets/12.png', 
               width: 50,  // عرض الصورة
               height: 50, // طول الصورة
               fit: BoxFit.contain,
               ),
              ),
            ),
          ),

          // 2. الحاوية البيضاء
          // استبدلي الـ Positioned القديم بهذا:
DraggableScrollableSheet(
  initialChildSize: 0.8, // يبدأ من 80% من الشاشة
  minChildSize: 0.8,     // أقل حجم عند السحب للأسفل
  maxChildSize: 1.0,    // أقصى حجم عند السحب للأعلى
  snap: true,
  builder: (context, scrollController) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: figmaGradientDecoration.gradient,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(70),
          topRight: Radius.circular(70),
        ),
      ),
      child: ListView( // استبدلنا Column بـ ListView ليدعم السحب
        controller: scrollController, // ضروري جداً لربط الحركة
        children: [
          const SizedBox(height: 30),
          const Center( // وضعنا العنوان في Center
            child: Text(
              "Daily Attendance",
              style: TextStyle(
                fontFamily: 'IBM Plex Sans',
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Color(0xFF005D52),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // عناوين الجدول
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HeaderText("Lecture", width: 60),
                _HeaderText("ID", width: 65),
                _HeaderText("Date", width: 65),
                _HeaderText("Time", width: 50),
                _HeaderText("Status", width: 55),
              ],
            ),
          ),
          const Divider(color: Color(0xFF606060), thickness: 0.5),

          // محتوى القائمة
          // بما أننا داخل ListView كبير، نستخدم Column للمحتوى أو ListView.builder مع shrinkWrap
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
            children: _buildListContent(),
          ),
          ),
          

          const SizedBox(height: 20),

          // الأزرار
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildExportButton("Export as Excel", figmaGradientDecoration, context),
                _buildExportButton("Export as PDF", figmaGradientDecoration, context),
              ],
            ),
          ),
          
          const SizedBox(height: 50), // مساحة إضافية في الأسفل
      
        ],
      ),
    );
  },
),
        ],
      ),
    );
  }

  // دالة بناء الزر مع الربط الفعلي
  Widget _buildExportButton(String title, BoxDecoration decoration, BuildContext context) {
    return InkWell(
      onTap: () async {
        // 1. تنفيذ التصدير الفعلي بناءً على العنوان
        if (title.contains("Excel")) {
          await ExportService.toExcel();
        } else {
          await ExportService.toPDF();
        }

        // 2. الانتقال لصفحة النجاح بعد اكتمال العملية
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SuccessDownloadedScreen()),
          );
        }
      },
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          gradient: decoration.gradient,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xB58C8484)),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF005D52),
              fontFamily: 'IBM Plex Sans',
              fontStyle: FontStyle.italic,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildListContent() {
    if (courseId == "1" && sectionId == "101") {
      return [
        const _AttendanceRow("SWE312:\nUser interface", "22200897", "8/12/2025", "08:00-\n08:50", "Present"),
        const _AttendanceRow("SWE312:\nUser interface", "222008127", "8/12/2025", "08:00-\n08:50", "Present"),
        const _AttendanceRow("SWE312:\nUser interface", "22200887", "8/12/2025", "08:00-\n08:50", "Present"),
        const _AttendanceRow("SWE312:\nUser interface", "22200437", "8/12/2025", "08:00-\n08:50", "Absent"),
      ];
    } else {
      return [const Center(child: Text("No Data Found"))];
    }
  }
}

// الويجيتات المساعدة تبقى كما هي في كودك الأصلي...
class _HeaderText extends StatelessWidget {
  final String text;
  final double width;
  const _HeaderText(this.text, {required this.width});
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: Text(text, style: const TextStyle(fontSize: 14, color: Color(0xFF005D52))));
  }
}

class _AttendanceRow extends StatelessWidget {
  final String lecture, id, date, time, status;
  const _AttendanceRow(this.lecture, this.id, this.date, this.time, this.status);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _RowCell(lecture, width: 60),
          _RowCell(id, width: 65),
          _RowCell(date, width: 65),
          _RowCell(time, width: 50),
          _RowCell(status, width: 55, color: status == "Absent" ? Colors.red : const Color(0xFF005D52)),
        ],
      ),
    );
  }
}

class _RowCell extends StatelessWidget {
  final String text;
  final double width;
  final Color? color;
  const _RowCell(this.text, {required this.width, this.color});
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: Text(text, style: TextStyle(fontSize: 14, color: color ?? const Color(0xFF005D52))));
  }
}