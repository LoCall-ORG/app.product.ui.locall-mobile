import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer(
      {super.key, required this.onRemove, this.image, required this.onAdd});
  final VoidCallback onRemove;
  final File? image;
  final VoidCallback onAdd;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: widget.image != null
              ? Image.file(widget.image!)
              : GestureDetector(
                  onTap: widget.onAdd,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
        ),
        if (widget.image != null) ...{
          Positioned(
            left: 60,
            child: InkWell(
              onTap: widget.onRemove,
              child: const CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          )
        },
      ],
    );
  }
}
