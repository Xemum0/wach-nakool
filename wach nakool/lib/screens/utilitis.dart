import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget Suggestions(
    String image, String text, String description, String stars, String time) {
  return Column(
    children: [
      Stack(
        children: [
          // Image container with reduced width and height
          Container(
              width: 175, // Decreased width for tighter layout
              height: 160, // Decreased height for tighter layout
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(1, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: image.startsWith('http')
                    ? Image.network(
                        image,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
              )),

        ],
      ),
      Container(
        width: 165,
        margin: const EdgeInsets.symmetric(
            horizontal: 4), // Reduced horizontal margin
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFEC888D)),
            left: BorderSide(color: Color(0xFFEC888D)),
            right: BorderSide(color: Color(0xFFEC888D)),
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0), // Reduced padding
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16), // Smaller font size for tighter layout
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0), // Reduced padding
              child: Text(
                textDirection: TextDirection.rtl,
                description,
                style: const TextStyle(fontSize: 10), // Smaller font size
              ),
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, // Evenly distribute items
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Text(
                        stars,
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    ),
                    Icon(
                      MdiIcons.star,
                      size: 12,
                      color: Colors.red,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      MdiIcons.clock,
                      size: 12,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        '$time mins',
                        style: TextStyle(
                            fontSize: 14,
                            color: const Color.fromRGBO(253, 93, 105, 1)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
