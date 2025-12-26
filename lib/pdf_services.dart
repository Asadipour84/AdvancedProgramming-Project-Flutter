import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'Transfer.dart';

class PdfService {
  static Future<File> generateTransactionPdf(
      List<Bank_Transfer> transactions) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Text(
            'Transaction Report',
            style: pw.TextStyle(
              fontSize: 22,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 20),

          pw.Table.fromTextArray(
            headers: [
              'Date',
              'Type',
              'Category',
              'Amount',
            ],
            data: transactions.map((tx) {
              return [
                '${tx.dateTime.year}/${tx.dateTime.month}/${tx.dateTime.day}',
                tx.type_of_transfer.name,
                tx.categories_of_transfer.name,
                tx.amount.toStringAsFixed(0),
              ];
            }).toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellAlignment: pw.Alignment.centerLeft,
          ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/transactions.pdf');

    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
