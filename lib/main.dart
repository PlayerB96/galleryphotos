import 'dart:io';
import 'dart:typed_data';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

ImagePicker picker = ImagePicker();
Uint8List imagesArchived = Uint8List(0);
List<String> pathsPhoto = [];
File image = File('');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Galleryphotos"),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.amberAccent,
            constraints: const BoxConstraints.expand(),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ExpansionTileCard(
                    expandedColor: Colors.white,
                    initialElevation: 4,
                    elevation: 4,
                    initialPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    baseColor: Colors.white,
                    subtitle: const Text("Bryan Rafael"),
                    title: const Text("Ing.Informático"),
                    trailing: const Icon(Iconsax.alarm),
                    children: [
                      const Divider(
                        height: 5,
                        thickness: 5,
                      ),
                      ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          buttonMinWidth: 20.0,
                          buttonHeight: 20.0,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                    onPressed: () {
                                      pickImageOrders();
                                    },
                                    icon: const Icon(Iconsax.camera),
                                    label: const Text("Tomar foto")),
                                TextButton.icon(
                                    onPressed: () {
                                      getFilesFromOrder(context: context);
                                    },
                                    icon: const Icon(Iconsax.gallery),
                                    label: const Text("Ver foto")),
                              ],
                            )
                          ]),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> pickImageOrders() async {
  XFile? photo =
      await picker.pickImage(source: ImageSource.camera, imageQuality: 40);
  final temp = await photo!.readAsBytes();
  imagesArchived = temp;
  pathsPhoto.add(photo.path);
  image = File(photo.path);
}

Future<void> getFilesFromOrder({required BuildContext context}) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Imagen seleccionada'),
        content: Image.file(
          image,
          width: 180,
          height: 220,
          // key: UniqueKey(),
          fit: BoxFit.cover,
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
