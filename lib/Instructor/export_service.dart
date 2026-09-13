import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart' as ex; 
import 'package:pdf/widgets.dart' as pw;

class ExportService {
  
  static Future<void> toExcel() async {
    try {
      // 1. إنشاء ملف الإكسل
      var excel = ex.Excel.createExcel();
      
      // 2. الوصول إلى الصفحة (Sheet)
      // ملاحظة: الإصدارات الجديدة تستخدم ['Sheet1'] أو اسم الصفحة مباشرة
      ex.Sheet sheetObject = excel[excel.getDefaultSheet()!];

      // 3. إضافة العناوين (هنا تم تصحيح الخطأ)
      // نستخدم List<ex.CellValue?> لضمان توافق الأنواع
      sheetObject.appendRow([
        ex.TextCellValue('Lecture'),
        ex.TextCellValue('ID'),
        ex.TextCellValue('Date'),
        ex.TextCellValue('Time'),
        ex.TextCellValue('Status'),
      ]);

      // 4. إضافة بيانات تجريبية بنفس الطريقة
      sheetObject.appendRow([
        ex.TextCellValue('SWE312'),
        ex.TextCellValue('22200897'),
        ex.TextCellValue('8/12/2025'),
        ex.TextCellValue('08:00'),
        ex.TextCellValue('Present'),
      ]);

      // 5. حفظ الملف
      var fileBytes = excel.save();
      final directory = await getApplicationDocumentsDirectory();
      final file = File("${directory.path}/Attendance_Report.xlsx");
      
      if (fileBytes != null) {
        await file.writeAsBytes(fileBytes);
        print("Excel saved at: ${file.path}");
      }
    } catch (e) {
      print("Excel Error: $e");
    }
  }

  static Future<void> toPDF() async {
    try {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Text("Attendance Report", style: pw.TextStyle(fontSize: 24)),
          ),
        ),
      );

      final directory = await getApplicationDocumentsDirectory();
      final file = File("${directory.path}/Attendance_Report.pdf");
      await file.writeAsBytes(await pdf.save());
      print("PDF saved at: ${file.path}");
    } catch (e) {
      print("PDF Error: $e");
    }
  }
}