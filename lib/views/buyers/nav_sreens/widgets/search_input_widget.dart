import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child:  TextField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Search For Products",
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding:  EdgeInsets.all(14.0),
              child: SvgPicture.asset(
                "assets/icons/search.svg",
                width: 10,
              ),
            )
        ),
      ),
    );
  }
}

