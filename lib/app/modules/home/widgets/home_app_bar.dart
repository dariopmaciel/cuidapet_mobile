import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends SliverAppBar {
  const HomeAppBar({super.key})
      : super(
          expandedHeight: 100,
          collapsedHeight: 100,
          toolbarHeight: 10,
          elevation: 0,
          flexibleSpace: const _CuidapetAppBar(),
          // iconTheme: const IconThemeData(color: Colors.red),
          pinned: true,
        );
}

class _CuidapetAppBar extends StatelessWidget {
  const _CuidapetAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final outLineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey[200]!),
    );

    return AppBar(
      // iconTheme: const IconThemeData(color: Colors.black),
      iconTheme: const IconThemeData(),
      backgroundColor: Colors.grey[100],
      centerTitle: true,
      title: const Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Text('CuidaPet'),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
      ],
      elevation: 0,
      flexibleSpace: Stack(
        children: [
          Container(
            height: 140.h,
            color: context.primaryColor,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: .8.sw,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(30),
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: const Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.grey,
                      ),
                      border: outLineInputBorder,
                      focusedBorder: outLineInputBorder,
                      enabledBorder: outLineInputBorder,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
