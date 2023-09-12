import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
// ignore: library_prefixes
import 'package:pdf/widgets.dart' as pdfWidgets;

generatePdf(List<DocumentSnapshot> data) async {
  final pdf = pdfWidgets.Document();
  final image =
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();
  pdf.addPage(
    pdfWidgets.Page(
      build: (pdfWidgets.Context context) {
        return pdfWidgets.Center(
          child: pdfWidgets.Container(
            child: pdfWidgets.Column(
              children: [
                pdfWidgets.Row(children: [
                  pdfWidgets.Image(
                    alignment: pdfWidgets.Alignment.center,
                    height: 100.0,
                    width: 100.0,
                    pdfWidgets.MemoryImage(image,
                        orientation: PdfImageOrientation.topLeft),
                  ),
                  pdfWidgets.SizedBox(width: 30.0),
                ]),
                pdfWidgets.SizedBox(height: 50.0),
                pdfWidgets.Table(
                  tableWidth: pdfWidgets.TableWidth.max,
                  border: pdfWidgets.TableBorder.all(width: 1.0),
                  children: [
                    pdfWidgets.TableRow(
                      verticalAlignment:
                          pdfWidgets.TableCellVerticalAlignment.middle,
                      children: [
                        pdfWidgets.Text('Name'),
                        pdfWidgets.Text('Contact No'),
                        pdfWidgets.Text('Reason'),
                        pdfWidgets.Text('Date'),
                        pdfWidgets.Text('Time'),
                        pdfWidgets.Text('Department Name'),
                        pdfWidgets.Text('Meeting With'),
                      ],
                    ),
                    for (var doc in data)
                      pdfWidgets.TableRow(
                        decoration: const pdfWidgets.BoxDecoration(
                            color: PdfColors.yellow400),
                        verticalAlignment:
                            pdfWidgets.TableCellVerticalAlignment.middle,
                        children: [
                          pdfWidgets.Text(doc['Name']),
                          pdfWidgets.Text(doc['Contact No'].toString()),
                          pdfWidgets.Text(doc['Reason']),
                          pdfWidgets.Text(doc['Date']),
                          pdfWidgets.Text(doc['Time']),
                          pdfWidgets.Text(doc['Department']),
                          pdfWidgets.Text(doc['Person']),
                          // pdfWidgets.Image(
                          //   pdfWidgets.MemoryImage(image),
                          //   width: 40.0,
                          //   height: 40.0,
                          //   alignment: pdfWidgets.Alignment.center,
                          //   fit: pdfWidgets.BoxFit.fill
                          // ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  final path = (await getExternalStorageDirectory())!.path;
  final file = File('$path/Output.pdf');
  file.writeAsBytesSync(await pdf.save());
  OpenFile.open('$path/Output1.pdf');
  // OpenFile.open(output.path)
}
