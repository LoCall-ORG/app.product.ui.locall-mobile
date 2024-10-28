import 'package:flutter/material.dart';

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Upload Photo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Choose a method to upload your photo",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xff959595),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: Color(0xffc2e969),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text("Camera")
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.image,
                    size: 40,
                    color: Color(0xffc2e969),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text("Gallery")
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
