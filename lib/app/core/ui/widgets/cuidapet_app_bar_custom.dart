import 'package:flutter/material.dart';

class CuidapetAppBarCustom extends AppBar {
final String label;


  CuidapetAppBarCustom(this.label, {super.key})
      : super(
          leading: const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.arrow_back_ios_sharp,
                  color: Colors.white,
                ),
              )
            ],
          ),
          title: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
          elevation: 0,
        );

  
}
