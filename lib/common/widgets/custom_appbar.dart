import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar customAppBar(String label) => AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 16,
              child: const Icon(
                Icons.arrow_back,
                size: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
    );
