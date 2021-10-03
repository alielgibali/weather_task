import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final Function(String)? onChanged;

  SearchBox({
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.search),
          SizedBox(
            width: 5,
          ),
          VerticalDivider(
            color: Colors.grey[800],
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 100,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: TextFormField(
                onChanged: onChanged,
                //   controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Cairo,Maadi,NasrCity',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Mulish',
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
