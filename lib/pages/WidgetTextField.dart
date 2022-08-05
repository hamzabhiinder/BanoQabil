import 'package:flutter/material.dart';

Widget textpasswordfield(String hintText, controllerprovidor) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: TextField(
          controller: controllerprovidor,
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    ),
  );
}

//Text Field

Widget textfield(String hintText, controllerprovidor) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: TextField(
          controller: controllerprovidor,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
        ),
      ),
    ),
  );
}

Widget containers(Icon icon, String icon_name) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color.fromARGB(255, 49, 112, 51),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.7),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), //change the color
        ),
      ],
    ),
    height: 150,
    width: 150,
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: icon,
          color: Colors.white,
        ),
        Text(icon_name,
            style: TextStyle(
              color: Colors.white,
            ))
      ],
    ),
  );
}
