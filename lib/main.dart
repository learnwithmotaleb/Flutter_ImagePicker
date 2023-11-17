import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primaryColor: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;

  Future getImage(ImageSource source)async{
    final image = await ImagePicker().pickImage(source: source);
    if(image == null)return;
    final imageTempprary = File(image.path);
    setState(() {
      _image = imageTempprary;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      title:const Text('ImagePicker'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipOval(
                //CircleAvatar
                // radius: 80,
                // backgroundImage: FileImage(_image!),
                child: _image!= null ? Image.file(_image!, width: 200, height: 200,fit:BoxFit.cover): Image.asset("assets/image/motaleb.jpg", width: 200, height: 200,fit:BoxFit.cover),

            )
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    title: 'Galley',
                    icon: Icons.image_outlined,
                    onClick:()=>getImage(ImageSource.gallery)
                ),
                const SizedBox(width: 10,),
                CustomButton(
                    title: 'Camera',
                    icon: Icons.camera_alt,
                    onClick:()=>getImage(ImageSource.camera)
                ),
              ],
            )


          ],

        ),
      )
    );
  }
}

Widget CustomButton(
{
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}){
  return Container(
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          Text(title),
        ],
      ),
    ),
  );
}
