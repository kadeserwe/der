import 'package:file_picker/file_picker.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:flutter/material.dart';

class Singlefilepicker extends StatefulWidget {
  const Singlefilepicker({super.key});

  @override
  State<Singlefilepicker> createState() => _SinglefilepickerState();
}

class _SinglefilepickerState extends State<Singlefilepicker> {
  PlatformFile? file;
  String? size;
  Future<void> picksinglefile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = result.files.first;
      file == null ? false : OpenAppFile.open(file!.path.toString());
      final kb = file!.size / 1024;
      final mb = kb / 1024;
      final size = (mb >= 1)
          ? '${mb.toStringAsFixed(2)} MB'
          : '${kb.toStringAsFixed(2)} KB';
      this.size = size;
      ElevatedButton(
        onPressed: () async {
          setState(() {
            Navigator.pop(context);
            // surfaceOccupeeController="${position?.longitude ?? ""}" as TextEditingController;
          });
        },
        child: Text("ok"),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Fichier',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 170,
          ),
          file == null
              ? Text('No File found yet')
              : Column(
                  children: [
                    Text('Name -  ${file!.name}'),
                    Text('Size -  ${size!}'),
                    Text('Extension -  ${file!.extension}')
                  ],
                ),
          const SizedBox(
            height: 170,
          ),
          ElevatedButton.icon(
              onPressed: picksinglefile,
              // style: const ButtonStyle(
              //     backgroundColor:
              //     MaterialStatePropertyAll(Color.fromARGB
              //       (255, 61, 186, 228))),
              icon: const Icon(Icons.insert_drive_file_sharp),
              label: const Text(
                'Pick File',
                style: TextStyle(fontSize: 25),
              )),
        ])),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //
      //     Navigator.pop(context);
      //   },
      //
      //
      //   label: const Text('suivant '),
      //   // icon: const Icon(Icons.edit),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
