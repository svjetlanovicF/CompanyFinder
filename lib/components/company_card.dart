import 'package:flutter/material.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'data',
                  style: TextStyle(
                      fontSize: 24.0, color: Colors.greenAccent.shade400),
                ),
                Text(
                  'subtitle',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            TextButton(
              child: Text('button'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
