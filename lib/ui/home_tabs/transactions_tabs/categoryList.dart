  import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<Map<String, Icon>> categories = [
    {
      "Grocery": const Icon(
        FontAwesomeIcons.cartShopping,
        color: Colors.black54,
        size: 15,
      )
    },
    {
      "Transport": const Icon(
        FontAwesomeIcons.bicycle,
        color: Colors.black54,
        size: 15,
      )
    },
    {
      "Entertainment": const Icon(FontAwesomeIcons.headphones,
          color: Colors.black54, size: 15)
    },
    {
      "Food":
          const Icon(FontAwesomeIcons.utensils, color: Colors.black54, size: 15)
    },
    {
      "Bills": const Icon(FontAwesomeIcons.fileInvoiceDollar,
          color: Colors.black54, size: 15)
    },
    {
      "Clothing":
          const Icon(FontAwesomeIcons.shirt, color: Colors.black54, size: 15)
    }
  ];