import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
// ignore: library_prefixes
import 'package:pdf/widgets.dart' as pdfWidgets;

var datetime = DateTime.now();

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
                // pdfWidgets.TableHelper.fromTextArray(
                //   headers: <String>['Name','Contact No','Reason','Department','Date','Time','Meeting With'],
                //   cellAlignment: pdfWidgets.Alignment.center,
                //   data: for (var doc in data)
                // ),
                pdfWidgets.Table(
                 
                  border: pdfWidgets.TableBorder.all(
                    width: 1.2,
                  ),
                  children: [
                    pdfWidgets.TableRow(
                      children: [
                        pdfWidgets.Container(
                          padding: const pdfWidgets.EdgeInsets.all(10.0),
                          child: pdfWidgets.Text(
                            'Name',
                            style: pdfWidgets.TextStyle(fontWeight: pdfWidgets.FontWeight.bold)
                          ),
                        ),
                        pdfWidgets.Container(
                          padding: const pdfWidgets.EdgeInsets.all(10.0),
                          child: pdfWidgets.Text('Contact No'),
                        ),
                        pdfWidgets.Container(
                          padding: const pdfWidgets.EdgeInsets.all(10.0),
                          child: pdfWidgets.Text('Reason'),
                        ),
                        pdfWidgets.Container(
                          padding: const pdfWidgets.EdgeInsets.all(10.0),
                          child: pdfWidgets.Text(
                            'Date',
                          ),
                        ),
                        pdfWidgets.Container(
                          padding: const pdfWidgets.EdgeInsets.all(10.0),
                          child: pdfWidgets.Text(
                            'Time',
                          ),
                        ),
                        pdfWidgets.Container(
                          padding: const pdfWidgets.EdgeInsets.all(10.0),
                          child: pdfWidgets.Text(
                            'Department',
                          ),
                        ),
                        pdfWidgets.Container(
                          padding: const pdfWidgets.EdgeInsets.all(10.0),
                          child: pdfWidgets.Text(
                            'Reason',
                          ),
                        ),
                      ],
                    ),
                    for (var doc in data)
                      pdfWidgets.TableRow(
                        children: [
                          pdfWidgets.Container(
                            padding: const pdfWidgets.EdgeInsets.all(10.0),
                            child: pdfWidgets.Text(
                              doc['Name'],
                            ),
                          ),
                          pdfWidgets.Container(
                            padding: const pdfWidgets.EdgeInsets.all(10.0),
                            child: pdfWidgets.Text(
                              doc['Contact No'].toString(),
                            ),
                          ),
                          pdfWidgets.Container(
                            padding: const pdfWidgets.EdgeInsets.all(10.0),
                            child: pdfWidgets.Text(doc['Reason']),
                          ),
                          pdfWidgets.Container(
                            padding: const pdfWidgets.EdgeInsets.all(10.0),
                            child: pdfWidgets.Text(
                              doc['Date'],
                            ),
                          ),
                          pdfWidgets.Container(
                            padding: const pdfWidgets.EdgeInsets.all(10.0),
                            child: pdfWidgets.Text(
                              doc['Time'],
                            ),
                          ),
                          pdfWidgets.Container(
                            padding: const pdfWidgets.EdgeInsets.all(10.0),
                            child: pdfWidgets.Text(
                              doc['Department'],
                            ),
                          ),
                          pdfWidgets.Container(
                            padding: const pdfWidgets.EdgeInsets.all(10.0),
                            child: pdfWidgets.Text(
                              doc['Person'],
                            ),
                          ),

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
  final file = File('$path/demo.pdf');
  file.writeAsBytesSync(await pdf.save());
  OpenFile.open('$path/demo.pdf');
  // OpenFile.open(output.path)
}
