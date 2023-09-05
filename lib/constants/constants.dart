 import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
 import 'package:pdf/widgets.dart' as pdfWidgets;

generatePdf(List<DocumentSnapshot> data) async {
    final pdf = pdfWidgets.Document();
    final image =
        (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List();
    pdf.addPage(
      pdfWidgets.Page(
        build: (pdfWidgets.Context context) {
          return pdfWidgets.Center(
            child: pdfWidgets.Table(
              defaultVerticalAlignment:
                  pdfWidgets.TableCellVerticalAlignment.middle,
              tableWidth: pdfWidgets.TableWidth.max,
              border: pdfWidgets.TableBorder.all(width: 2.0),
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
          );
        },
      ),
    );

    final path = (await getExternalStorageDirectory())!.path;
    final file = File('$path/Output1.pdf');
    file.writeAsBytesSync(await pdf.save());
    OpenFile.open('$path/Output1.pdf');
    // OpenFile.open(output.path)
  }